package lib.peripherals

import chisel3._
import chisel3.util._

import lib.Bus

/**
 * Sends a string over a [[Bus.RequestPort]].
 *
 * The IO is as follows:
 * - [[io.port]] requester bus port
 *
 * @param msg string to send
 */
class StringStreamer(msg: String) extends Module {
  val io = IO(new Bundle {
    val port = Bus.RequestPort() // bus port
  })

  object State extends ChiselEnum {
    val getBusy, // initiate status read
    recvBusy, // receive status
    Send, // send character
    Done // done sending all characters
    = Value
  }

  val rom = VecInit(msg.map(_.U(8.W))) // character ROM
  val ptrReg = Counter(rom.length) // pointer into character ROM
  val stateReg = RegInit(State.getBusy)

  io.port.init()

  switch(stateReg) {
    is(State.getBusy) { // initiate status read
      io.port.readRequest(1.U)
      stateReg := State.recvBusy
    }
    is(State.recvBusy) { // receive status
      stateReg := Mux(io.port.rdData(0), State.Send, State.getBusy)
    }
    is(State.Send) { // send character
      io.port.writeRequest(0.U, rom(ptrReg.value))
      val ptrWrap = ptrReg.inc()
      stateReg := Mux(ptrWrap, State.Done, State.getBusy)
    }
    is(State.Done) {}
  }

}

object StringStreamer {
  /** Create a [[StringStreamer]] module
   * @param msg string to send
   * */
  def apply(msg: String): StringStreamer = Module(new StringStreamer(msg))
}