MEMORY
{
  RAM : ORIGIN = 0x20000000, LENGTH = 128K
  FLASH : ORIGIN = 0x08000000, LENGTH = 512K
}

SECTIONS
{
  .text :
  {
    *(.vectors)
    . += 0x00000198;
    *(.text)
  } > FLASH
}