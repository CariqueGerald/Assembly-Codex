; CS 318 – Architecture and Organization
; Author: Group6_BSCS3A
;       Dimanarig, Arjun Rashid 
;       Carique, Gerald
;       Vinas, Christian Joseph

; Learning Task (Strings)
; Assembly program that changes all the vowels in the given string to 'e'.

section .data
    prompt_welcome db "Hi! We are Group 6", 10, "This program is intended to change all the vowels in the given string to 'e'.", 10,0
    prompt_input   db "Input String: ", 0
    prompt_instring db '%s', 0
    prompt_output  db "Output String: ", 0
    prompt_outstring db '%s', 0
    prompt_continue db "Continue? (Y/N): ", 0
    prompt_choice db '%s', 0
    vowels db 'aeiouAEIOU', 0  ; String containing vowels
    exit_msg db "Thank You!", 10, 0
    newline db  10, 0

    error_msg db "===== Error! Invalid input. Please enter 'Y' or 'N' ======", 10, 0
    line db "==============================", 10, 0

section .bss
    input_string resb 1024
    output_string resb 1024
    choice resb 2

section .text
    global _main
    extern _printf
    extern _scanf
    extern _exit
    extern _gets

error_function:
    push error_msg
    call _printf
    add esp, 4
    ret

_main:
    ; Display welcome message
    push prompt_welcome
    call _printf
    add esp, 4

    ; Start the main loop
main_loop:
    push line
    call _printf
    add esp, 4
    ; Get user input
    push prompt_input
    call _printf
    add esp, 4

    push input_string
    call _gets
    add esp, 8

    ; Process the input string
    lea esi, [input_string]  ; Load address of input string into esi
    lea edi, [output_string] ; Load address of output string into edi

    process_string_loop:
        lodsb  ; Load character from esi into AL, and increment esi
        cmp al, 0  ; Check if end of string
        je end_process_string
        cmp al, 'a'
        je replace_with_e
        cmp al, 'e'
        je replace_with_e
        cmp al, 'i'
        je replace_with_e
        cmp al, 'o'
        je replace_with_e
        cmp al, 'u'
        je replace_with_e
        cmp al, 'A'
        je replace_with_e
        cmp al, 'E'
        je replace_with_e
        cmp al, 'I'
        je replace_with_e
        cmp al, 'O'
        je replace_with_e
        cmp al, 'U'
        je replace_with_e
        jmp copy_character

    replace_with_e:
        cmp al, 'a'
        jl not_lowercase_vowel
        cmp al, 'z'
        jg not_lowercase_vowel
        ; It's a lowercase vowel, replace with 'e'
        mov al, 'e' 
        jmp after_replace

    not_lowercase_vowel:
        cmp al, 'A'
        jl not_lowercase_vowel
        cmp al, 'Z'
        jg not_lowercase_vowel
        ; It's a lowercase vowel, replace with 'e'
        mov al, 'E' 
        jmp after_replace

    not_uppercase_vowel:
        ; Not a vowel, do not replace
        jmp copy_character

    after_replace:
        ; Continue to copy the character
        ; jmp copy_character
        stosb
        jmp process_string_loop

    copy_character:
        stosb  ; Store the character in AL into the destination (edi), and increment edi
        jmp process_string_loop

    end_process_string:
        mov dword [edi], 0
        mov esi, 0
        mov edi, 0

        ; Display the output string
        push prompt_output
        call _printf
        add esp, 4

        push output_string
        push prompt_outstring
        call _printf
        add esp, 8

        push newline
        call _printf
        add esp, 4

        jmp continue_prompt

    continue_prompt:
        push line
        call _printf
        add esp, 4
        ; Ask if the user wants to continue
        push prompt_continue
        call _printf
        add esp, 4

        push choice
        push prompt_choice
        call _scanf
        add esp, 8

        ; Consume remaining characters in the input buffer
        push input_string
        call _gets
        add esp, 4

        cmp byte [choice], 'N'
        je exit_program
        cmp byte [choice], 'n'
        je exit_program

        cmp byte [choice], 'Y'
        je next_iteration
        cmp byte [choice], 'y'
        je next_iteration

        ; Display an error message and go back to continue_prompt
        call error_function
        jmp continue_prompt

        ; jmp main_loop
    next_iteration:
        ; Add a newline before restarting the loop
        jmp main_loop

exit_program:
    push newline
    call _printf
    add esp, 4

    ; Display thank you message and exit
    push exit_msg
    call _printf
    add esp, 4

    call _exit
