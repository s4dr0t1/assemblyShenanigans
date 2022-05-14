global _start


section .text
	_start:
		mov AL, 0xFF
		xor BL, BL
		or AL, BL

		and AL, BL

		mov AL, 0xFF
		mov BL, 0x12
		xor AL, BL

		not AL

		mov RAX, 60
		mov RDI, 1337
		syscall
