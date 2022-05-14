global _start

section .text
	_start:
		mov RAX, 1
		mov RDI, 1
		mov RSI, string
		mov RDX, length_string
		syscall

		mov RAX, [var1]
		mov RBX, [var2]


		mov RAX, 60
		mov RDI, 1337
		syscall

section .data
	string: db "Hello there!"
	length_string: equ $-string

	var1: db 0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 0x88
	var2: db 0x88, 0x77, 0x66, 0x55, 0x44, 0x33, 0x22, 0x11

