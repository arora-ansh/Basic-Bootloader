; Name Ansh Arora 		Roll No. 2019022

bits 16
org 0x7c00

boot:
	mov ax, 0x2401
	int 0x15
	mov ax, 0x3
	int 0x10
	call protected_mode

%include "gdt.asm"

;The following code takes the bootloader into 32-bit ptotected mode, by switching the cr0
protected_mode:	
	cli
	lgdt [gdt.pointer]
	mov eax, cr0
	or eax,0x1 ;eax value is changed and then assigned to cr0 to switch to protected mode
	mov cr0, eax
	jmp gdt.code:boot2

bits 32
boot2:
	mov  ax, gdt.data ;Passing GDT's data section
	call set_segment_registers
	call say_hello

set_segment_registers:
	mov gs, ax
	mov fs, ax
	mov ss, ax
	mov ds, ax
	mov es, ax
	ret

say_hello:
	mov esi, msg
	mov edx, 0xb8000 ;Location where VGA Text buffer is held
	jmp hello_loop

hello_loop:	;loop to keep repeating until whole message is displayed on VGA display
	lodsb
	or al,al
	jz regs
	or eax,0x1F00; white on blue colour
	mov word [edx], ax
	add edx,2
	jmp hello_loop

regs:	;this part shows the value of cr0 register on the VGA Text buffer, held inside 0xb8000
	mov eax, cr0
	or 	eax, 0x1F00
	mov [edx], eax
	jmp end

end:
	cli
	hlt

msg: db "Hello world! Value of cr0 register: ",0

; The 510 zeroes followed by hexcode to initialize boot and load into BIOS
times 510 - ($-$$) db 0
dw 0xaa55
