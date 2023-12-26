OUTPUT_ARCH( "riscv" )
ENTRY(_start)

SECTIONS
{
  /DISCARD/ : { *(.note.gnu.build-id) }
  . = 0x80000000;
  .text : { *(.text) }
  . = ALIGN(0x1000);
  .data : { *(.data) }
  .bss : { *(.bss) }
  . = 0xF0000000;
  .tohost : { *(.tohost) }
  _end = .;
}

        