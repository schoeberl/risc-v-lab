package lib

import lib.Executable.Section
import net.fornwall.jelf.ElfFile

import java.io.File

class Executable(
    name: String, // name of the executable
    elf: ElfFile // the ELF file
) {

  /**
    * Returns the section with the given name, e.g. ".text", ".data", ".rodata", etc.
    *
    * @param name name of the section
    * @return the section
    */
  def getSegment(name: String): Section =
    Executable.getSection(elf, name) match {
      case Some(s) => s
      case None        => throw new Executable.SegmentDoesNotExist(name)
    }

  /**
    * Returns the entry address of the executable.
    *
    * @return the entry address
    */
  def getEntryPoint: Long = elf.e_entry & 0xffffffffL
}

object Executable {

  case class Section(
      start: Long, // start address of the section
      data: Array[Byte] // data of the section
  ) {
    val end: BigInt = start + data.length

    def getBytes: Seq[Long] = data.map(_.toLong & 0xff)

    def getWords: Seq[Long] =
      data
        .grouped(4)
        .map {
          _.map(_.toLong & 0xff).zipWithIndex
            .map { case (b, i) => b << (8 * i) }
            .reduce(_ | _)
        }
        .toSeq
  }

  class NonRV32Exception extends Exception("Not a RV32I executable")

  class SegmentDoesNotExist(seg: String)
      extends Exception(s"Segment '$seg' does not exist")

  private def from(elf: ElfFile, name: String): Executable = {

    if (!elf.is32Bits() || elf.e_machine != 0xf3) throw new NonRV32Exception

    new Executable(name, elf)
  }

  def from(file: File): Executable = from(ElfFile.from(file), file.getName)

  def from(path: String): Executable = from(new File(path))

  private def getSection(elf: ElfFile, name: String): Option[Section] = {
    val section = elf.firstSectionByName(name)
    if (section == null) None
    else Some(Section(section.header.sh_addr & 0xffffffffL, section.getData))
  }
}
