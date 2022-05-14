global _start


section .text
	_start:
		;;Moving immediate data to the register
		mov AL, 0xaa
		mov AH, 0xbb

		;;Moving data between register to register 
		mov BX, AX

		;;Moving data from memory into the register 
		mov RSI, [sample2]
		mov DIL, [sample]
		mov r14b, [sample]

		;;Moving data from register into the memory
		mov RAX, [sample2]
		mov byte [sample2], AL

		;;Exiting gracefully
		mov RAX, 60
		mov RDI, 1337
		syscall

section .data
	sample: db 0xaa, 0xbb, 0xcc, 0xdd, 0xee, 0xff, 0x11, 0x22
	sample2: dq 0x1122334455667788
	sample3: times 8 db 0x00
