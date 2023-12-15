section .data
    prompt_welcome db 'Hi! This is Gerald, and I am here to help you perform operations for 2 signed two-digit numbers (-99 to 99).', 10, 0
    prompt_header db '==== SIMPLE CALCULATOR by Gerald ====', 10, 0
    prompt_exit db  '[0] Exit', 10, 0
    prompt_add db   '[1] Add', 10, 0
    prompt_sub db   '[2] Subtract', 10, 0
    prompt_mul db   '[3] Multiply', 10, 0
    prompt_div db   '[4] Divide', 10, 0
    choice db 'Enter choice: ', 0
    input_choice db '%d', 0

    prompt_invalid db 'Sorry invalid input, try again!', 10, 0

    prompt_addition db '==== Addition ====', 10, 0
    prompt_subtraction db '==== Subtraction ====', 10, 0
    prompt_multiplication db '==== Multiplacation ====', 10, 0
    prompt_division db '==== Division ====', 10, 0

    prompt_first_num db 'Enter the first number: ', 0
    prompt_second_num db 'Enter the second number: ', 0
    input_number db '%d', 0

    sum db 'Sum: %d', 10, 0
    diff db 'Difference: %d', 10, 0
    prod db 'Product: %d', 10, 0
    quotient db 'Quotient: %d', 10, 0
    remainder db 'Remainder: %d', 10, 0
    div_zero db 'You cannot divide by 0. Please enter a valid divisor.', 10, 0

    prompt_thankyou db 'Thank you!', 0

section .bss
    menu resb 100
    first_num resd 1
    second_num resd 1

section .text
    global _main
    extern _printf, _scanf, _atoi, _exit

_main:
    push prompt_welcome
    call _printf
    add esp, 4

    ; Menu
.menu_loop:
    push prompt_header
    call _printf
    add esp, 4

    push prompt_exit
    call _printf
    add esp, 4

    push prompt_add
    call _printf
    add esp, 4

    push prompt_sub
    call _printf
    add esp, 4

    push prompt_mul
    call _printf
    add esp, 4

    push prompt_div
    call _printf
    add esp, 4

    push choice
    call _printf
    add esp, 4

    ; Read menu
    push menu
    push input_choice
    call _scanf
    add esp, 8

    ; Check input in the menu
    mov eax, [menu]
    cmp eax, 1 ; Add
    je .addition
    cmp eax, 2 ; Subtract
    je .subtraction
    cmp eax, 3 ; Multiply
    je .multiplication
    cmp eax, 4 ; Divide
    je .division
    cmp eax, 0 ; Exit
    je .exit
    ; Invalid choice, loop again
    push prompt_invalid
    call _printf
    add esp, 4

    jmp .menu_loop

.exit:
    push prompt_thankyou
    call _printf
    add esp, 4

    call _exit

.addition:
    push prompt_addition
    call _printf
    add esp, 4

    push prompt_first_num
    call _printf
    add esp, 4

    push first_num
    push input_number
    call _scanf
    add esp, 8

    push prompt_second_num
    call _printf
    add esp, 4

    push second_num
    push input_number
    call _scanf
    add esp, 8

    ; Perform addition
    mov eax, [first_num]
    add eax, [second_num]

    push eax
    push sum
    call _printf
    add esp, 8
    
    jmp .menu_loop

.subtraction:
    push prompt_subtraction
    call _printf
    add esp, 4

    push prompt_first_num
    call _printf
    add esp, 4

    push first_num
    push input_number
    call _scanf
    add esp, 8

    push prompt_second_num
    call _printf
    add esp, 4

    push second_num
    push input_number
    call _scanf
    add esp, 8

    ; Perform subtraction
    mov eax, [first_num]
    sub eax, [second_num]

    push eax
    push diff
    call _printf
    add esp, 8
    
    jmp .menu_loop

.multiplication:
    push prompt_multiplication
    call _printf
    add esp, 4

    push prompt_first_num
    call _printf
    add esp, 4

    push first_num
    push input_number
    call _scanf
    add esp, 8

    push prompt_second_num
    call _printf
    add esp, 4

    push second_num
    push input_number
    call _scanf
    add esp, 8

    ; Perform multiplication
    mov eax, [first_num]
    imul eax, [second_num]

    push eax
    push prod
    call _printf
    add esp, 8

    jmp .menu_loop

.division:
    push prompt_division
    call _printf
    add esp, 4

    push prompt_first_num
    call _printf
    add esp, 4

    push first_num
    push input_number
    call _scanf
    add esp, 8

    push prompt_second_num
    call _printf
    add esp, 4

    push second_num
    push input_number
    call _scanf
    add esp, 8

    ; Check for division by zero
    mov eax, [second_num]
    cmp eax, 0
    je .division_zero

    ; Perform division
    mov eax, [first_num]
    cdq  ; Sign-extend eax into edx
    mov ebx, [second_num]
    idiv ebx

    ; Quotient
    push eax
    push quotient
    call _printf
    add esp, 8

    ; Calculate and display the remainder
    mov eax, dword [first_num]
    add eax, dword [second_num]
    mov edx, 0
    div ebx

    ; Remainder
    push edx
    push remainder
    call _printf
    add esp, 8

    jmp .menu_loop

.division_zero:

    push div_zero
    call _printf
    add esp, 4

    ; Read a valid divisor
    push prompt_second_num
    call _printf
    add esp, 4

    push second_num  ; Store the new divisor
    push input_number
    call _scanf
    add esp, 8

    ; Check for division by zero again
    mov eax, [second_num]
    cmp eax, 0
    je .division_zero

    ; Perform division with the valid divisor
    mov eax, [first_num]
    cdq  ; Sign-extend eax into edx
    mov ebx, [second_num]
    idiv ebx

    ; Quotient
    push eax
    push quotient
    call _printf
    add esp, 8

    ; Calculate and display the remainder
    mov eax, dword [first_num]
    add eax, dword [second_num]
    mov edx, 0
    div ebx

    ; Remainder
    push edx
    push remainder
    call _printf
    add esp, 8

    jmp .menu_loop