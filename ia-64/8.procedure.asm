global _start

section .data

section .text
	printSomething:
		mov RAX, 1
		mov RDI, 1
		mov RSI, string
		mov RDX, length_string
		syscall
		ret

	exitThisShit:
			mov RAX, 60
			mov RDI, 1337
			syscall

	_start:
		call printSomething
		call exitThisShit


section .data
	string: db "Hello there!"
	length_string: equ $-string
