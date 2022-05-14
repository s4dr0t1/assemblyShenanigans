global _start

section .text
	_start:
		;;Initlalization the counter register
		mov RCX, 0x5

		;;Defining what is supposed to be iterated
		loopLabel:
			push RCX
			mov RAX, 1
			mov RDI, 1
			mov RSI, string
			mov RDX, strlen
			syscall
			pop RCX

		;;Starting the iteration proces
		loop loopLabel
			

		;;Exiting gracefully
		mov RAX, 60
		mov RDI, 11
		syscall




section .data
	string: db "nigga"
	strlen: equ $-string
