global _start
extern printf, scanf				; import library functions

section .data
	message db "Fibonacci Sequence:", 0x0a	; define message
	msg_len equ $ - message			; define message length
	
	input_msg db "Enter a Number:", 0x0a	; define input message
	input_msg_len equ $ - input_msg		; define input message length
	
	out_format db "%d", 0x0a, 0x00		; define output format
	in_format db "%d", 0x00			; define input format

section .bss
	userInput resb 1			; align 1 byte buffer for user input

section .text
_start:
	; procedure calls
	
	call getInput
	call printMessage
	call initLoopFib
	call loopfib
	call Exit

getInput:
	; print message to inform user
	
	mov rax, 1		; syscall code 1 -> print
	mov rdi, 1		; print destination -> stdout
	mov rsi, input_msg	; 1st argument -> message
	mov rdx, input_msg_len	; 2nd argument -> message length
	syscall			; syscall for print
	
	; get input from user
	
	mov rdi, in_format	; 1st argument -> input format
	mov rsi, userInput	; 2nd argument -> buffer for user input
	sub rsp, 8		; align stack
	call scanf		; call scanf function
	add rsp, 8		; restore stack alignment
	ret			; return

printMessage:
	mov rax, 1 		; syscall code 1 -> print
	mov rdi, 1		; print destination -> stdout
	mov rsi, message	; 1st argument -> message
	mov rdx, msg_len	; 2nd argument -> message length
	syscall			; syscall for print
	ret			; return
	
initLoopFib:	
	xor rax, rax		; initialize rax 0
	xor rbx, rbx		; initialize rbx 0
	inc rbx			; increment rbx to 1
	ret			; return

loopfib:
	call printFib		
	add rax, rbx		; add rbx to rax
	xchg rax, rbx		; exchange rax and rbx
	cmp rbx, [userInput]	; compare rbx and userInput
	js loopfib 		; rbx < userInput, jump loopfib
	jz loopfib		; rbx == userInput, jump loopfib
	ret			; return
	
printFib:
	push rax
	push rbx
	mov rdi, out_format	; 1st argument -> input format
	mov rsi, rbx		; 2nd argument -> message
	call printf		; printf(out_format, rbx)
	pop rbx			
	pop rax
	ret

Exit:
	mov rax, 60		; syscall code 60 -> exit
	xor rdi, rdi		; exit code: 0
	syscall			; syscall for exit
