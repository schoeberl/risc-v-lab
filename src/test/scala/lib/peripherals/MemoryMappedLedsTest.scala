package lib.peripherals

import chisel3._
import org.scalatest.flatspec.AnyFlatSpec
import chiseltest._
import lib.BusDriver

class MemoryMappedLedsTest extends AnyFlatSpec with ChiselScalatestTester {

  behavior of "Memory-mapped LEDs"

  it should "light up" in {
    test(new MemoryMappedLeds(4)) { dut =>
      val driver = BusDriver(dut.io.port, dut.clock)

      driver.write(0.U, 0x0f.U) // turn on all LEDs

      driver.expect(0.U, 0x0f.U) // check if register is updated

      dut.io.pins.expect(0x0f.U) // check if all LEDs are on
    }
  }

}
