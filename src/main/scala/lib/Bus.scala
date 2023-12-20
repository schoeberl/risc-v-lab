package lib

import chisel3._
import chisel3.internal.firrtl.Width

object Bus {

  /** Base type for bus ports.
    */
  sealed abstract class Port extends Bundle {

    /** Read from given address */
    val read = Output(Bool())

    /** Write at given address */
    val write = Output(Bool())

    /** Address */
    val addr = Output(UInt(32.W))

    /** Write data */
    val wrData = Output(UInt(32.W))

    /** Read data, valid one cycle after read request */
    val rdData = Input(UInt(32.W))

    def init(): Unit
  }

  /** Request port for the bus.
    */
  sealed class RequestPort extends Port {

    /** Apply a write request to the bus.
      * @param addr address
      * @param data data to write
      */
    def writeRequest(addr: UInt, data: UInt): Unit = {
      this.write := 1.B
      this.read := 0.B
      this.addr := addr
      this.wrData := data
    }

    /** Apply a read request to the bus.
      * @param addr address
      */
    def readRequest(addr: UInt): Unit = {
      this.write := 0.B
      this.read := 1.B
      this.addr := addr
      this.wrData := DontCare
    }

    /** Initialize the port signals to no request. */
    def init(): Unit = {
      this.write := 0.B // no request
      this.read := 0.B

      // request data signals don't matter
      this.addr := DontCare
      this.wrData := DontCare
    }
  }

  /** Response port for the bus.
    */
  sealed class RespondPort extends Port {

    /** Generate signal indicating whether there is a write request at the given address.
      * @param addr address
      * @return write request signal
      */
    def hasWriteRequestAt(addr: UInt): Bool =
      this.write && this.addr === addr

    /** Generate signal indicating whether there is a read request at the given address.
      * @param addr address
      * @return read request signal
      */
    def hasReadRequestAt(addr: UInt): Bool =
      this.read && this.addr === addr

    /** Initialize the port signals to no response. */
    def init(): Unit = {
      this.rdData := DontCare // read data can be anything
    }
  }

  object RespondPort {
    /** Create a response port
     * @return the response port
     */
    def apply(): RespondPort = Flipped(new RespondPort)
  }

  object RequestPort {
    /** Create a request port
     * @return the request port
     */
    def apply(): RequestPort = new RequestPort
  }

}
