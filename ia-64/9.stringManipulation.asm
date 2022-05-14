global _start


section .text
	_start:
		;;SCAS(X) = Comparison between what is stored at the accumulator and a memory address
		;;First operand is the accumulator <implied addressing mode>, and the other operand will be the RDI register
		;;Direction flags are used here

		cld
		mov RAX, 0x1234567890abcdef
		lea RDI, [varA]
		SCASQ

		lea RDI, [varB]
		SCASQ


		;;CMPS(X)
		;;The first operand is pointed to, by RSI, and the other one by RDI
		cld
		lea RSI, [varA]
		lea RDI, [varC]
		CMPSQ 

		;;Exiting gradefully
		mov RAX, 60
		mov RDI, 1337
		syscall


section .data
	varA: dq 0x1234567890abcdef
	varB: dq 0xfedcba1234567890
	varC: dq 0x1234567890abcdef
	
