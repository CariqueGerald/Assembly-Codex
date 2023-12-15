; CS 318 – Architecture and Organization
; Author: Group6_BSCS3A
;       _Dimanarig, Arjun Rashid 
;       _Carique, Gerald
;       _Vinas, Christian Joseph

; Learning Task (SAL Part 2 – Modular Programming)
; Assembly program that implements (1) pass-by-value.

section .data
    prompt_welcome db " Hi! This is Group-6, and we are here to help you determine the LCD and GCF for two-digit numbers (1 to 99)", 10, 0

    prompt_menu db " ==== LCD and GCF CALCULATOR by Gerald, Christian, Arjun ====", 0xA
                db " [0] Exit", 0xA
                db " [1] LCD", 0xA
                db " [2] GCF", 0xA, 0

    prompt_choice db " Enter choice: ", 0
    prompt_enter_choice db "%d", 0

    prompt_lcd db "     ==== LCD ====", 10, 0
    prompt_gcf db "     ==== GCF ====", 10, 0
 
    prompt_first db " Enter the first number: ", 0
    first_number db "%d", 0

    prompt_second db " Enter the second number: ", 0
    sec_number db "%d", 0

    result_lcd db " LCD: %d", 10, 0
    result_gcf db " GCF: %d", 10, 0
 
    invalid_choice_input db " Entered Choice is not on the menu. Please enter a valid choice.", 10, 0
    invalid_inputs db " Input should only be between 1 to 99. Please enter again a valid input.", 10, 0
    exit_msg db " Thank you! ", 0

    newline db 10, 0

;section that contains the buffer that will be used to store the user's input
section .bss
    firstnum resd 1
    secnum resd 1
    choice resd 1
    result resd 1  ; To store the result

;main program
section .text

; Function to handle string input error
handle_string_error:
    push prompt_enter_choice
    call _printf
    add esp, 4

    ; Clear the input buffer
    pusha
    mov eax, 0
    mov ebx, choice
    mov ecx, 1
    mov edx, prompt_enter_choice
    ; call _clear_input_buffer
    popa

    jmp menu_loop

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
    mov eax, [firstnum]  ; First number
    mov ebx, [secnum]  ; Second number
    push eax  ; Push the first number
    push ebx  ; Push the second number
    call _gcd

    pop ebx
    pop eax
    imul eax, ebx  ; Multiply the numbers
    idiv dword [result]  ; Divide by the GCD result

    ; Display the result
    push eax
    push result_lcd
    call _printf
    add esp, 8

    jmp menu_loop ; jump back to the menu loop

calculate_gcf:
    mov eax, [firstnum]  ; First number
    mov ebx, [secnum]  ; Second number
    push eax ; First number
    push ebx ; Second number
    call _gcd


    ; Display the result
    push dword [result]
    push result_gcf
    call _printf
    add esp, 8

    jmp menu_loop


invalid_choice:
   ; Check if the choice is valid (0-2) for the menu options.
    cmp dword [choice], 0
    jl invalid_choice
    cmp dword [choice], 2
    jl invalid_choice

    push invalid_choice_input ; display error message if conditions are met
    call _printf
    add esp, 4

    jmp menu_loop ; goes back to the menu after displaying error message


global _main
extern _printf
extern _scanf
extern _exit

_main:
    ; Display a welcome message.
    push prompt_welcome
    call _printf
    add esp, 4

menu_loop:
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
    je input_flcd_num
    cmp dword [choice], 2
    je input_first_gcfnum

    jmp invalid_choice ; jump to the error function for menu
    jmp menu_loop

input_flcd_num:
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
    jl invalid_input_flcd
    cmp dword [firstnum], 99
    jg invalid_input_flcd

    jmp input_seclcd_num

invalid_input_flcd:
    push invalid_inputs
    call _printf
    add esp, 4

    jmp input_flcd_num

input_seclcd_num:
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
    jl invalid_input_seclcd
    cmp dword [secnum], 99
    jg invalid_input_seclcd

    jmp calculate_lcd

invalid_input_seclcd:
    push invalid_inputs
    call _printf
    add esp, 4

    jmp input_seclcd_num

input_first_gcfnum:
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
    jl invalid_input_fgcf
    cmp dword [firstnum], 99
    jg invalid_input_fgcf

    jmp input_second_gcfnum

invalid_input_fgcf:
    push invalid_inputs
    call _printf
    add esp, 4

    jmp input_first_gcfnum

input_second_gcfnum:
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
    jl invalid_input_secgcf
    cmp dword [secnum], 99
    jg invalid_input_secgcf

    jmp calculate_gcf

invalid_input_secgcf:
    push invalid_inputs
    call _printf
    add esp, 4

    jmp input_second_gcfnum

exit:
    push newline
    call _printf
    add esp, 4

    push exit_msg
    call _printf
    add esp, 4

    push newline
    call _printf
    add esp, 4

    call _exit