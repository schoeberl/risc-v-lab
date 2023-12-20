import chisel3._
import chisel3.util._

import lib.peripherals.{MemoryMappedUart, StringStreamer}
import lib.peripherals.MemoryMappedUart.UartPins

object HelloWorld extends App {
  emitVerilog(
    new HelloWorld(50000000, 9600),
    Array("--target-dir", "generated")
  )
}

/** Example circuit using the [[MemoryMappedUart]] and the [[StringStreamer]] to send out "Hello World!"
 * @param freq The frequency of the clock
 * @param baud The baud rate of the UART
 * */
class HelloWorld(freq: Int, baud: Int) extends Module {
  val io = IO(new Bundle {
    val uart = UartPins()
  })

  val stringStreamer = StringStreamer("Hello World!\n")

  val mmUart = MemoryMappedUart(
    freq,
    baud,
    txBufferDepth = 8,
    rxBufferDepth = 8
  )

  stringStreamer.io.port <> mmUart.io.port
  io.uart <> mmUart.io.pins
}

