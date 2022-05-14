global _start


section .text
	_start:
		;;Register arithmetic
		mov RAX, 0x01
		add RAX, 0x01

		mov RAX, 0xffffffffffffffff
		add RAX, 0x01

		mov RAX, 0x09
		sub RAX, 0x04

		;;Memory based arithmetic
		mov RAX, QWORD [var1]
		add QWORD [var4], RAX

		add QWORD [var4], 0x02

		;;Messing with the FLAG bits

		;;Clear carry bit
		clc
		;Set carry bit
		stc
		;;Complement carry bit
		cmc

		;;Exiting gracefully
		mov RAX, 60
		mov RDI, 1337
		syscall


section .data
	var1: dq 0x1
	var2: dq 0x1122334455667788
	var3: dq 0xffffffffffffffff
	var4: dq 0x0
