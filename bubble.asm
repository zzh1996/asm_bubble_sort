TOTAL equ 100000 ;total number

global main

extern printf
extern scanf
extern gettimeofday

section .data
    ;format strings
    sfmt: db '%d',0
    tfmt: db 'cpu cycle:%d',10,0
    pfmt: db '%d ',0
    timefmt: db 'real time: %dus',10,0

section .bss
    data: resd TOTAL ;data
    time1: resd 2 ;start time
    time2: resd 2 ;finish time

section .text
    main:

    ;read data

    mov ecx,0
    mov esi,data

    loop1:

    lea eax,[esi+4*ecx]
    push ecx
    push eax
    push sfmt
    call scanf
    add esp,8
    pop ecx

    inc ecx
    cmp ecx,TOTAL
    jl loop1

    ;get time
    push 0
    push time1
    call gettimeofday
    add esp,8

    rdtsc
    push eax

    ;sort
    mov eax,0
    loop2:
    mov ebx,eax
    inc ebx
    loop3:
    mov ecx,[esi+4*eax]
    mov edx,[esi+4*ebx]
    cmp ecx,edx
    jle done
    mov [esi+4*eax],edx ;swap
    mov [esi+4*ebx],ecx
    done:
    inc ebx
    cmp ebx,TOTAL
    jl loop3
    inc eax
    cmp eax,TOTAL-1
    jl loop2

    ;measure time
    rdtsc

    pop ebx
    sub eax,ebx
    push eax
    push tfmt
    call printf
    add esp,8

    push 0
    push time2
    call gettimeofday
    add esp,8

    mov eax,[time2]
    sub eax,[time1]
    mov ebx,1000000
    mul ebx
    add eax,[time2+4]
    sub eax,[time1+4]
    push eax
    push timefmt
    call printf
    add esp,8

    ;output result
    mov ecx,0

    loop4:

    mov eax,[esi+4*ecx]
    push ecx
    push eax
    push pfmt
    call printf
    add esp,8
    pop ecx

    inc ecx
    cmp ecx,TOTAL
    jl loop4

    ;return 0
    mov eax,0
    ret

