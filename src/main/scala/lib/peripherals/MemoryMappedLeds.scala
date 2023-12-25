package lib.peripherals

import chisel3._
import chisel3.util._

import lib.Bus

/** Memory mapped register controlling [[cnt]] LEDs.
  *
  * The IO is as follows:
  * - [[io.port]] responder bus port
  * - [[io.pins]] pins to the physical LEDs
  *
  * @param msg string to send
  */
class MemoryMappedLeds(cnt: Int) extends Module {
  assert(cnt <= 32, "Only up to 32 LEDs can be controlled through the bus")

  val io = IO(new Bundle {

    /** bus port */
    val port = Bus.RespondPort()

    /** LED pins */
    val pins = Output(UInt(cnt.W))
  })

  val ledReg = RegInit(0.U(cnt.W))

  when(io.port.write) {
    ledReg := io.port.wrData
  }

  io.pins := ledReg
  io.port.rdData := ledReg

}
