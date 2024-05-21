global _start

section .data
    message db "Hello World!"
    length equ $-message

section .text
_start:
    ; Write message to stdout
    mov rax, 1          ; syscall: sys_write
    mov rdi, 1          ; file descriptor: stdout
    mov rsi, message    ; pointer to message
    mov rdx, length     ; message length
    syscall             ; invoke syscall

    ; Exit program
    mov rax, 60         ; syscall: sys_exit
    mov rdi, 0          ; exit status: 0
    syscall             ; invoke syscall
