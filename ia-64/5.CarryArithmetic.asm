global _start

section .text
	_start:
		;;Add with carry
		mov RAX, 0
		stc
		adc RAX, 0x1
		stc
		adc RAX, 0x4

		;;Increment and decrement
		mov RBX, 0x0
		inc RBX
		inc RBX
		dec RBX


		;;Exiting the program gracefully
		mov RAX, 0x3c
		mov RDI, 0
		syscall
