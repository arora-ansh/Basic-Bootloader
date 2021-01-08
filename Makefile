make_bin:
	nasm -f bin boot.asm

run_bin: make_bin
	qemu-system-x86_64 boot

clear:
	rm boot