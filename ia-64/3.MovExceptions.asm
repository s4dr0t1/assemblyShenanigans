global _start


section .text
	_start:
		mov RAX, 0x1234567812345678
		mov EAX, 0x12345678
		mov AX, 0x9999
		mov AH, 0x11
		mov AL, 0x22


		;;Exiting gracefully
		mov RAX, 60
		mov RDI, 1337
		syscall
