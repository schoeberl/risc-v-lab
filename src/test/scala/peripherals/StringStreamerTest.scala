package peripherals

import chisel3._
import chiseltest._
import bus.BusMonitor
import org.scalatest.flatspec.AnyFlatSpec

import scala.util.Random

class StringStreamerTest extends AnyFlatSpec with ChiselScalatestTester {

  "StringStreamer" should "send a string" in {

    val message = // create message string
      Seq.fill(1000)(Random.nextPrintableChar()).mkString

    test(new StringStreamer(message)) { dut =>
      val monitor = BusMonitor(dut.io.port, dut.clock) // create bus monitor

      monitor.spawnResponder {
        case 0 => 0.U
        case 1 => Random.nextInt(2).U // indicate that UART is ready to receive
      }

      // expect all message characters to be sent over the bus
      monitor.expectSeq(message.map(_.U(8.W)))

    }
  }

}
