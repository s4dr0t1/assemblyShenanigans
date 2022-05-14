global _start

section .text
	_start:
		mov RAX, 1
		mov RDI, 1

;;	mov RSI, label
		lea RBX, [label]
		lea RSI, [RBX]

		mov RDX, length
		syscall


		mov RAX, 60
		mov RDI, 1337
		syscall
		

section .data
	label: db "ROHIT!!"
	length: equ $-label
