; http_server.asm - A simple HTTP server in x86 assembly

section .data
; IP address and port
ip_address db 0        ; INADDR_ANY
port dw 8080           ; Port 8080

; Response message
response db "HTTP/1.1 200 OK", 13, 10
response db "Content-Length: 42", 13, 10
response db "Content-Type: text/html", 13, 10
response db 13, 10
response db "<html><body><h1>Hello, World!</h1></body></html>", 13, 10
response_len equ $ - response

section .bss
sockfd resd 1
clientfd resd 1
buffer resb 1024

section .text
global _start

_start:
    ; Create a socket
    mov eax, 102         ; SYS_socketcall
    mov ebx, 1           ; SYS_socket
    lea ecx, [esp + 4]   ; Arguments (domain, type, protocol)
    push 0               ; Protocol (IP)
    push 1               ; Type (SOCK_STREAM)
    push 2               ; Domain (AF_INET)
    int 0x80
    mov [sockfd], eax

    ; Bind the socket
    mov eax, 102         ; SYS_socketcall
    mov ebx, 2           ; SYS_bind
    lea ecx, [esp + 4]   ; Arguments (sockfd, sockaddr, addrlen)
    push 16              ; Length of sockaddr_in
    push ip_address      ; Address
    push port            ; Port
    push word 2          ; Family (AF_INET)
    push dword [sockfd]  ; Socket file descriptor
    int 0x80

    ; Listen for connections
    mov eax, 102         ; SYS_socketcall
    mov ebx, 4           ; SYS_listen
    lea ecx, [esp + 4]   ; Arguments (sockfd, backlog)
    push 10              ; Backlog
    push dword [sockfd]  ; Socket file descriptor
    int 0x80

accept_loop:
    ; Accept a connection
    mov eax, 102         ; SYS_socketcall
    mov ebx, 5           ; SYS_accept
    lea ecx, [esp + 4]   ; Arguments (sockfd, addr, addrlen)
    push 0               ; addrlen
    push 0               ; addr
    push dword [sockfd]  ; Socket file descriptor
    int 0x80
    mov [clientfd], eax

    ; Receive data (HTTP request)
    mov eax, 3           ; SYS_read
    mov ebx, [clientfd]  ; Client file descriptor
    lea ecx, [buffer]    ; Buffer to store data
    mov edx, 1024        ; Buffer size
    int 0x80

    ; Send response
    mov eax, 4           ; SYS_write
    mov ebx, [clientfd]  ; Client file descriptor
    mov ecx, response    ; Response message
    mov edx, response_len; Response length
    int 0x80

    ; Close client connection
    mov eax, 6           ; SYS_close
    mov ebx, [clientfd]  ; Client file descriptor
    int 0x80

    jmp accept_loop      ; Loop back to accept more connections

_exit:
    ; Exit program
    mov eax, 1           ; SYS_exit
    xor ebx, ebx         ; Exit code 0
    int 0x80
