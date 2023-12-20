package lib

import chisel3._
import chiseltest._

/**
 * Monitor for a [[Bus.RequestPort]] for simulation purposes. Provides methods to
 * create a responder thread and expect write operations.
 * @param bus request port to monitor
 * @param clock clock connected to the interface
 */
case class BusMonitor(bus: Bus.RequestPort, clock: Clock) {

  private def hasWrite =
    bus.write.peekBoolean()

  private def hasRead =
    bus.read.peekBoolean()

  /** Expect a write operation on the bus. Blocks until a write operation has occurred.
   * @param item expected item
   */
  def expect(item: UInt): Unit = {
    while (!hasWrite) clock.step()

    bus.wrData.expect(item)
    clock.step()
  }

  /** Expect a sequence of write operations on the bus. Blocks until all write operations
   * have occurred.
   * @param items expected items
   */
  def expectSeq(items: Seq[UInt]): Unit = {
    items.foreach(expect)
  }

  /** Spawn a responder thread. The responder thread will respond to read requests
   * with the result of the given function.
   * @param fun function mapping addresses to read responses
   */
  def spawnResponder(fun: Int => UInt): Unit = {
    fork { // fork to detach from main thread
      while (true) {
        while (!hasRead) clock.step() // wait for read

        fork { // fork to handle read while parent thread waits for next read
          timescope {
            val addr = bus.addr.peekInt().toInt
            clock.step()
            bus.rdData.poke(fun(addr))
            clock.step()
          }
        }

        clock.step()
      }
    }
  }

}
