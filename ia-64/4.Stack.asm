global _start

section .text
	_start:
		mov RAX, 0x1122334455667788

		;;Bunch of push instructions
		push RAX
		push label
		push QWORD [label]

		;;Bunch of pop instructions
		pop R8
		pop R9
		pop R10

		;;Exiting gracefully
		mov RAX, 60
		mov RDI, 1337
		syscall


section .data
	label: dq 0xaabbccdd

