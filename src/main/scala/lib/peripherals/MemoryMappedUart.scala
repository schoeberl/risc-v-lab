package lib.peripherals

import chisel3._
import chisel3.util._

import chisel.lib.uart._

import lib.Bus

/** A combined UART receiver and transmitter with a memory mapped interface.
  *
  * The UART is controlled through 32-bit aligned registers and buffers mapped to the
  * following addresses:
  *
  * | address | read                           | write                           |
  * |---------|--------------------------------|---------------------------------|
  * | 0x00    | read received data from buffer |  write data to send into buffer |
  * | 0x04    | read UART status               | -                               |
  *
  * The UART status has the following format:
  *
  * | bit | description              |
  * |-----|--------------------------|
  * | 0   | transmitter ready        |
  * | 1   | receiver has data        |
  *
  * Reading from address 0x00 will remove a character from the receive buffer. If the
  * buffer is empty, no valid data is returned. Read from address 0x04 and check bit 1 to
  * see if there is data.
  *
  * Writing to address 0x00 will add a character to the transmit buffer. If the buffer
  * is full, the character will be dropped. Read from address 0x04 and check bit 0 to see
  * if the transmitter is ready to accept data.
  *
  * The IO is as follows:
  * - [[io.pins]]  UART tx and rx pins
  * - [[io.port]]  responder bus port
  *
  * @param freq clock frequency of [[clock]]
  * @param baud baud rate of UART
  * @param txBufferDepth depth of transmit buffer
  * @param rxBufferDepth depth of receive buffer
  */
class MemoryMappedUart(
    freq: Int,
    baud: Int,
    txBufferDepth: Int,
    rxBufferDepth: Int
) extends Module {
  val io = IO(new Bundle {

    /** UART tx and rx pins */
    val pins = MemoryMappedUart.UartPins()

    /** bus port */
    val port = Bus.RespondPort()
  })

  // UART controllers
  val transmitter = Module(new Tx(freq, baud))
  val receiver = Module(new Rx(freq, baud))

  // buffer for sending data
  val txBuffer = Module(new Queue(UInt(8.W), txBufferDepth))
  val rxBuffer = Module(new Queue(UInt(8.W), rxBufferDepth))

  // connect UART controllers to buffers
  txBuffer.io.deq <> transmitter.io.channel
  receiver.io.channel <> rxBuffer.io.enq

  // read from receive buffer in the next cycle
  val hadDataReadRequest =
    RegNext(
      next = io.port.hasReadRequestAt(0.U),
      init = 0.B
    )

  // connect transmitter buffer to bus
  txBuffer.io.enq.bits := io.port.wrData
  txBuffer.io.enq.valid := io.port.hasWriteRequestAt(0.U)

  // connect receiver buffer to bus
  rxBuffer.io.deq.ready := hadDataReadRequest

  // connect UART pins
  io.pins.tx := transmitter.io.txd
  receiver.io.rxd := io.pins.rx

  // select payload of response
  io.port.rdData := Mux(
    hadDataReadRequest,
    rxBuffer.io.deq.bits,
    rxBuffer.io.deq.valid ## txBuffer.io.enq.ready
  )

}

object MemoryMappedUart {

  /** Rx and Tx pins for UART */
  case class UartPins() extends Bundle {
    val tx = Output(Bool())
    val rx = Input(Bool())
  }

  /** Create a [[MemoryMappedUart]].
    * @param freq clock frequency
    * @param baud baud rate of UART
    * @param txBufferDepth depth of transmit buffer
    * @param rxBufferDepth depth of receive buffer
    * @return memory mapped UART module
    */
  def apply(
      freq: Int,
      baud: Int,
      txBufferDepth: Int,
      rxBufferDepth: Int
  ): MemoryMappedUart = Module(
    new MemoryMappedUart(freq, baud, txBufferDepth, rxBufferDepth)
  )

}
