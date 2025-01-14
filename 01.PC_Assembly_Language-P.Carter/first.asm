; file: first.asm
; This program asks for two integers as input and prints out their sum.
;
; To create executable using Linux and gcc:
; nasm -f win32 first.asm
; nasm -f win32 asm_io.asm
; gcc -m32 -c driver.c -o driver.o
; gcc -m32 -o first.exe first.obj driver.o asm_io.obj
%include "asm_io.inc"
;
; initialized data is put in the .data segment
;
segment .data
;
; These labels refer to strings used for output
;
prompt1 db "Enter a number: ", 0
prompt2 db "Enter another number: ", 0
outmsg1 db "You entered ", 0
outmsg2 db " and ", 0
outmsg3 db ", the um of these is ", 0

;
; uninitialized data is put in the .bss segment
;
segment .bss
;
; These labels refer to double words used to store the inputs
;
input1 resd 1
input2 resd 1

;
; code is put in the .text segment
;
segment .text
        global _asm_main
_asm_main:
        enter 0,0               ; setup routine
        pusha

        mov eax, prompt1        ; print out prompt
        call print_string

        call read_int           ; read integer
        mov [input1], eax       ; store into input1

        mov eax, prompt2        ; print out prompt
        call print_string

        call read_int
        mov [input2], eax       ; store into input2

        mov eax, [input1]       ; eax = dword at input1
        add eax, [input2]       ; eax += dword at input2
        mov ebx, eax            ; ebs = eax

        dump_regs 1             ; print out register values
        dump_mem 2, outmsg1, 1  ; print out memory
;
; next print out result message as series of steps
;
        mov eax, outmsg1
        call print_string       ; print out first message
        mov eax, [input1]
        call print_int          ; print out input1
        mov eax, outmsg2
        call print_string       ; print out second message
        mov eax, [input2]
        call print_int          ; print out input2
        mov eax, outmsg3
        call print_string       ; print out third message
        mov eax, ebx
        call print_int          ; print out sum (ebx)
        call print_nl           ; print new-line

        popa
        mov eax, 0            ; return back to C
        leave
        ret