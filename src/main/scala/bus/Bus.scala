package bus

import chisel3._
import chisel3.internal.firrtl.Width

object Bus {

  /** Operation type of the bus. Can be [[read]] or [[write]].
    */
  object Operation extends ChiselEnum {
    val read, write = Value
  }

  /** Base type for bus ports.
    * @param aw address width
    */
  sealed abstract class Port(aw: Width) extends Bundle {

    /** Valid request on bus */
    val valid = Output(Bool())

    /** Operation type */
    val op = Output(Operation())

    /** Address */
    val addr = Output(UInt(aw))

    /** Write data */
    val wrData = Output(UInt(32.W))

    /** Read data, valid one cycle after read request */
    val rdData = Input(UInt(32.W))
  }

  /** Request port for the bus.
    * @param aw address width
    */
  sealed class RequestPort(aw: Width) extends Port(aw) {

    /** Apply a write request to the bus.
      * @param addr address
      * @param data data to write
      */
    def writeRequest(addr: UInt, data: UInt): Unit = {
      this.valid := 1.B
      this.op := Operation.write
      this.addr := addr
      this.wrData := data
    }

    /** Apply a read request to the bus.
      * @param addr address
      */
    def readRequest(addr: UInt): Unit = {
      this.valid := 1.B
      this.op := Operation.read
      this.addr := addr
      this.wrData := DontCare
    }

    /** Initialize the port signals to no request. */
    def init(): Unit = {
      this.valid := 0.B // no request

      // request signals don't matter
      this.op := DontCare
      this.addr := DontCare
      this.wrData := DontCare
    }
  }

  /** Response port for the bus.
    * @param aw address width
    */
  sealed class RespondPort(aw: Width) extends Port(aw) {

    /** Generate signal indicating whether there is a write request at the given address.
      * @param addr address
      * @return write request signal
      */
    def hasWriteRequestAt(addr: UInt): Bool =
      this.valid && this.op === Operation.write && this.addr === addr

    /** Generate signal indicating whether there is a read request at the given address.
      * @param addr address
      * @return read request signal
      */
    def hasReadRequestAt(addr: UInt): Bool =
      this.valid && this.op === Operation.read && this.addr === addr

    /** Initialize the port signals to no response. */
    def init(): Unit = {
      this.rdData := DontCare // read data can be anything
    }
  }

  object RespondPort {
    /** Create a response port with the given address width.
     * @param aw address width
     * @return the response port
     */
    def apply(aw: Width): RespondPort = Flipped(new RespondPort(aw))
  }

  object RequestPort {
    /** Create a request port with the given address width.
     * @param aw address width
     * @return the request port
     */
    def apply(aw: Width): RequestPort = new RequestPort(aw)
  }

}
