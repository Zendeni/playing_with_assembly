; Hello World program using C printf() function to provide the output

option casemap:none
.data

fmtStr db "Hello World!", 0

.code

externdef printf:proc

public asmFunc
asmFunc proc

    sub rsp, 56
    lea rcx, fmtStr
    call printf

    add rsp, 56

    ret            

asmFunc endp
end
