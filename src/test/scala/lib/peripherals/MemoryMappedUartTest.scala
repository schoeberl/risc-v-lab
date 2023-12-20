package lib.peripherals

import chisel3._
import chiseltest._
import lib.BusDriver
import org.scalatest.flatspec.AnyFlatSpec

import scala.annotation.tailrec
import scala.util.Random

class MemoryMappedUartTest extends AnyFlatSpec with ChiselScalatestTester {

  "MemoryMappedUart" should "send and receive data" in {
    test(new MemoryMappedUart(10000, 3000, 2, 2)) { dut =>
      val messageLength = 500

      val driver = MemoryMappedUartDriver(dut) // create UART driver

      fork { // connect uart tx to rx
        while (true) {
          dut.io.pins.rx.poke(dut.io.pins.tx.peek())
          dut.clock.step()
        }
      }

      // generate test data to be transmitted
      val message =
        Seq.fill(messageLength)(Random.nextPrintableChar().U(8.W))

      // send and receive characters eagerly
      sendAndReceive(messageLength)(driver, message.iterator)
        .zip(message)
        .zipWithIndex
        .foreach { case ((received, expected), i) =>
          assert(
            received.litValue == expected.litValue,
            s"For character $i: received 0x${received.litValue
              .toString(16)} but expected: 0x${expected.litValue.toString(16)}"
          ) // check if received data is equal to sent data
        }

    }
  }

  // send and receive data eagerly until all data has been sent and received
  @tailrec
  private def sendAndReceive(numberOfMessages: Int)(
      driver: MemoryMappedUartDriver,
      sendIter: Iterator[UInt],
      receivedMessages: Seq[UInt] = Seq.empty
  ): Seq[UInt] = {

    if (numberOfMessages == 0) {
      receivedMessages
    } else {
      if (sendIter.nonEmpty) driver.trySend(sendIter.next())

      driver.tryReceive() match {
        case Some(char) => {
          sendAndReceive(numberOfMessages - 1)(
            driver,
            sendIter,
            receivedMessages :+ char
          )
        }
        case None =>
          sendAndReceive(numberOfMessages)(driver, sendIter, receivedMessages)
      }
    }

  }

}

/**
 * Driver for a [[MemoryMappedUart]] for simulation purposes. Provides methods to
 * abstract the interaction with the memory mapped interface. Uses a [[BusDriver]] to
 * drive the bus.
 * @param uart UART to drive
 */
case class MemoryMappedUartDriver(uart: MemoryMappedUart) {

  val busDriver = BusDriver(uart.io.port, uart.clock) // create bus driver

  /** Reads UART status and checks whether bit 1 is set */
  def hasData: Boolean = {
    val status = busDriver.read(1.U).litValue
    (status & 0x2) != 0
  }

  /** Reads UART status and checks whether bit 0 is set */
  def isReady: Boolean = {
    val status = busDriver.read(1.U).litValue
    (status & 0x1) != 0
  }

  /** Writes data to UART Tx buffer. Blocks until UART is ready */
  def send(data: UInt): Unit = {
    while (!isReady) busDriver.clock.step()

    busDriver.write(0.U, data)
  }

  /** Writes data to UART Tx buffer if it is ready. Returns false if UART is not ready */
  def trySend(data: => UInt): Boolean = {
    val ready = isReady
    if (ready) busDriver.write(0.U, data)
    ready
  }

  /** Read UART from receive buffer. Blocks until data is available */
  def receive(): UInt = {
    while (!hasData) uart.clock.step()

    busDriver.read(0.U)
  }

  /** Reads data, if available. Else returns None */
  def tryReceive(): Option[UInt] = {
    if (hasData) {
      Some(busDriver.read(0.U))
    } else {
      None
    }
  }

}
