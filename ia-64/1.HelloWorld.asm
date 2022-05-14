global _start

section .text
	_start:
		mov RAX, 1
		mov RDI, 1
		mov RSI, string
		mov RDX, length_string
		syscall


		mov RAX, 60
		mov RDI, 1337
		syscall

section .data
	string: db "Hello there!"
	length_string: equ $-string

