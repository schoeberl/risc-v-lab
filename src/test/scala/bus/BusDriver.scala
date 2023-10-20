package bus

import chisel3._
import chiseltest._

/**
 * Driver for a [[Bus.RespondPort]] for simulation purposes. Provides methods to
 * abstract read and write operations.
 * @param port respond port to drive
 * @param clock clock connected to the interface
 */
case class BusDriver(port: Bus.RespondPort, clock: Clock) {

  /** Drive a write operation on the bus.
   * @param addr address
   * @param data data to write
   */
  def write(addr: UInt, data: UInt): Unit = {
    timescope {
      port.valid.poke(1.B)
      port.op.poke(Bus.Operation.write)
      port.addr.poke(addr)
      port.wrData.poke(data)

      clock.step()
    }
  }

  /** Drive a read operation on the bus.
   * @param addr address
   * @return data read from the bus
   */
  def read(addr: UInt): UInt = {
    timescope {
      port.valid.poke(1.B)
      port.op.poke(Bus.Operation.read)
      port.addr.poke(addr)

      clock.step()
    }

    port.rdData.peek()
  }
}

