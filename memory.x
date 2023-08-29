MEMORY
{
  /* NOTE 1 K = 1 KiBi = 1024 bytes */
  BOOT2      : ORIGIN = 0x10000000, LENGTH = 0x100
  FLASH      : ORIGIN = 0x10000100, LENGTH = 0x60000 - LENGTH(BOOT2)
  RAM        : ORIGIN = 0x20030000, LENGTH = 0xF000

  SHARED_RAM : ORIGIN = 0x2003F000, LENGTH = 0x1000
  APP_FLASH  : ORIGIN = ORIGIN(FLASH) + LENGTH(FLASH),
               LENGTH = 2M - (LENGTH(FLASH) + LENGTH(BOOT2))
  APP_RAM    : ORIGIN = 0x20000000,
               LENGTH = 256k - (LENGTH(RAM) + LENGTH(SHARED_RAM))
}

SECTIONS {
  .logs (NOLOAD) : ALIGN(4)
  {
    PROVIDE(_log_buffer = .);
    /* Consume remaining shared ram */
    . = ORIGIN(SHARED_RAM) + LENGTH(SHARED_RAM);
    PROVIDE(_log_buffer_end = .);
  } > SHARED_RAM
}
