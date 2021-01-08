;This file holds the Global Descriptor Table

gdt:
	
	.start: equ $ - gdt
		dq 0x0

	.code:	equ $ - gdt
		dw 0xFFFF
		dw 0x0
		db 0x0
		db 10011010b
		db 11001111b
		db 0x0

	.data:	equ $ - gdt
		dw 0xFFFF
		dw 0x0
		db 0x0
		db 10010010b
		db 11001111b
		db 0x0
	
	.pointer:
		dw $ - gdt - 1
		dd gdt