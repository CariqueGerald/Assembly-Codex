; CS 318 – Architecture and Organization
; Author: Group6_BSCS3A
;       _Dimanarig, Arjun Rashid 
;       _Carique, Gerald
;       _Vinas, Christian Joseph

; Learning Task (SAL Part 2 – Modular Programming)
; Assembly program that implements (2) pass-by-reference.

section .data
    prompt_welcome db " Hi! This is Group-6, and we are here to help you determine the LCD and GCF for two-digit numbers (1 to 99)", 10, 0

    prompt_menu db " ==== LCD and GCF CALCULATOR by Gerald, Christian, Arjun ====", 0xA
                db " [0] Exit", 0xA
                db " [1] LCD", 0xA
                db " [2] GCF", 0xA, 0
    prompt_choice db " Enter choice: ", 0
    prompt_enter_choice db "%d", 0

    prompt_lcd db "    === LCD ===", 10, 0
    prompt_gcf db "    === GCF ===", 10, 0
 
    prompt_first db " Enter the first number: ", 0
    first_number db "%d", 0
    prompt_second db " Enter the second number: ", 0
    sec_number db "%d", 0


    result_lcd_fmt db " LCD: %d", 10, 0
    result_gcf_fmt db " GCF: %d", 10, 0

    invalid_choice_input db " Entered Choice is not on the menu. Please enter a valid choice", 10, 0
    invalid_inputs db " Input should only be between 1 to 99. Please enter again a valid input", 10, 0
    end db " Thank you! ", 0
    newline db 10, 0


;section that contains the buffer that will be used to store the user's input
section .bss
  firstnum resd 1
  secnum resd 1
  choice resd 1
  result resd 1  ; To store the result


;main program
section .text

_gcd:
    ; Calculate the GCD (Greatest Common Divisor) using the Euclidean algorithm.
    push ebp
    mov ebp, esp
    mov eax, [firstnum]  ; First number
    mov ebx, [secnum]  ; Second number
    gcd_loop:
        cmp ebx, 0
        je gcd_done
        xor edx, edx
        div ebx
        mov eax, ebx
        mov ebx, edx
        jmp gcd_loop
    gcd_done:
    mov [result], eax  ; Store the result
    pop ebp
    ret

calculate_lcd:
    ; Calculate the LCM using GCD
    push dword [firstnum] 
    push dword [secnum]
    call _gcd  ; Calculate GCD

    pop ebx
    pop eax
    imul eax, ebx  ; Multiply the numbers
    idiv dword [result]  ; Divide by the GCD result

    ; Display the result
    push eax
    push result_lcd_fmt
    call _printf
    add esp, 8

    jmp menu

calculate_gcf:
    ; Calculate the GCD directly
    push dword [firstnum]
    push dword [secnum]
    call _gcd  ; Calculate GCD

    ; Display the result
    push dword [result]
    push result_gcf_fmt
    call _printf
    add esp, 8

    jmp menu


invalid_choice:
   ; Check if the choice is valid (0-2 ).
    cmp dword [choice], 0
    jl invalid_choice
    cmp dword [choice], 2
    jl invalid_choice

   push invalid_choice_input
   call _printf
   add esp, 4

   jmp menu


global _main
extern _printf
extern _scanf
extern _exit


_main:
    ; Display a welcome message.
    push prompt_welcome
    call _printf
    add esp, 4

menu:
    ; Display options.
    push prompt_menu
    call _printf
    add esp, 4

    ; Display a prompt and get the user's choice.
    push prompt_choice
    call _printf
    add esp, 4

    push choice ; Push the address of user's choice
    push prompt_enter_choice
    call _scanf
    add esp, 8

    ; Check the user's choice.
    cmp dword [choice], 0
    je exit
    cmp dword [choice], 1
    je input_first_lcd_number
    cmp dword [choice], 2
    je input_first_gcf_number

    jmp invalid_choice

input_first_lcd_number:
    ; Display a message and get the first number.
    push prompt_lcd
    call _printf
    add esp, 4

    push prompt_first
    call _printf
    add esp, 4

    push firstnum
    push first_number
    call _scanf
    add esp, 8

    ; Check if the input is valid (1 to 99).
    cmp dword [firstnum], 1
    jl invalid_input_lcd_first
    cmp dword [firstnum], 99
    jg invalid_input_lcd_first

    jmp input_second_lcd_number

invalid_input_lcd_first:
    push invalid_inputs
    call _printf
    add esp, 4

    jmp input_first_lcd_number

input_second_lcd_number:
    ; Get the second number.
    push prompt_second
    call _printf
    add esp, 4

    push secnum
    push sec_number
    call _scanf
    add esp, 8

    ; Check if the second input is valid (1 to 99).
    cmp dword [secnum], 1
    jl invalid_input_lcd_second
    cmp dword [secnum], 99
    jg invalid_input_lcd_second

    jmp calculate_lcd


invalid_input_lcd_second:
    push invalid_inputs
    call _printf
    add esp, 4

    jmp input_second_lcd_number

input_first_gcf_number:
    ; Display a message and get the first number.
    push prompt_gcf
    call _printf
    add esp, 4

    push prompt_first
    call _printf
    add esp, 4

    push firstnum
    push first_number
    call _scanf
    add esp, 8

    ; Check if the input is valid (1 to 99).
    cmp dword [firstnum], 1
    jl invalid_input_gcf_first
    cmp dword [firstnum], 99
    jg invalid_input_gcf_first

    jmp input_second_gcf_number

invalid_input_gcf_first:
    push invalid_inputs
    call _printf
    add esp, 4

    jmp input_first_gcf_number

input_second_gcf_number:
    ; Get the second number.
    push prompt_second
    call _printf
    add esp, 4

    push secnum
    push sec_number
    call _scanf
    add esp, 8

    ; Check if the second input is valid (1 to 99).
    cmp dword [secnum], 1
    jl invalid_input_gcf_second
    cmp dword [secnum], 99
    jg invalid_input_gcf_second

    jmp calculate_gcf


invalid_input_gcf_second:
    push invalid_inputs
    call _printf
    add esp, 4

    jmp input_second_gcf_number


exit:
    push newline
    call _printf
    add esp, 4

    push end
    call _printf
    add esp, 4

    push newline
    call _printf
    add esp, 4

    call _exit
