; Hello World.asmk
; IA-32 ASM program to print "Hello World"

;     Memory Diagram
; .--------------------.
; |     Text Section   |
; |       .text        |
; |--------------------|
; |                    |
; |     The code       |
; |                    |
; |--------------------|
; |    Data Section    |
; |       .data        |
; |--------------------|
; |                    |
; |   1)  Print        |
; |   "Hello World!"   |
; |      string        |
; |                    |
; |     2) Exit        |
; |    gracefully      |
; |____________________|


;=================================================

global _start

;=================================================

section .text

; the _start identifier is used to specify the entry point of the program
_start:

	;  _______________________________________________________________________________________
	; |                      Printing the "Hello World" string                                |
	; |                         System Call: __NR_write                                       |
	; |                         System Call Number: 4                                         |
	; |   Its wrapper function is ssize_t write(int fd, const void *buf, size_t count);       |
	;  ---------------------------------------------------------------------------------------
	
	mov eax, 0x4      ; the syscall number
	mov ebx, 0x1      ; stdout
	mov ecx, message  ; pointer to the string
	mov edx, 12       ; length of the string

	;  _______________________________________________________________________________________
	; |                              Exiting gracefully                                       |
	; |                            System Call: __NR_exit                                     |
	; |                              System Call Number: 1                                    |
	; |    Its wrapper function is ssize_t write(int fd, const void *buf, size_t count);      |
	;  ---------------------------------------------------------------------------------------

	mov eax, 0x1 ; The system call number
	mov ebx, 0x5 ; The return value

	; Triggering Kernel Mode by using the Trap Instruction 0x80
	int 0x80

;=================================================

section .data

;label  define byte
message: db "Hello World"

