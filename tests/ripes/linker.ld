OUTPUT_ARCH( "riscv" )

SECTIONS
{
  /DISCARD/ : { *(.note.gnu.build-id) }
  . = 0x00000000;
  .text : { *(.text) }
  . = ALIGN(0x1000);
  .data : { *(.data) }
}

        