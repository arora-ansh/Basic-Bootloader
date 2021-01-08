# Basic-Bootloader
A simple bootloader which boots via legacy BIOS then first switches to protected mode and then displays a message with the contents of the CR0 register.

## Requirements
- QEMU Emulator
- NASM Assembler
- GNU Makefile support

## Testing
- Generate the boot binary file using 
```sh
make make_bin
```
- Run the generated binary in QEMU using
```sh
make run_bin
```
