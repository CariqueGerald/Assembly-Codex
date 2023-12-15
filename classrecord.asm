; CS 318 – Architecture and Organization

; Group Members: Group6_BSCS3A
;       Dimanarig, Arjun Rashid 
;       Carique, Gerald
;       Vinas, Christian Joseph


; Final Project (Computer Program Project) 
; This is a Class Record Progam intended to add, edit, delete and display student records of atleast 5 students 

section .data
    prompt_msg db 'Hi! This is a Class Record Program.', 10, 0 
    prompt_class db '========== CLASS RECORD ==========', 10,0
    prompt_exit db '[0] Exit', 10, 0 
    prompt_add db '[1] Add', 10, 0
    prompt_delete db '[2] Delete', 10, 0 
    prompt_edit db '[3] Edit', 10, 0
    prompt_displayAll db '[4] Display All', 10, 0
    prompt_displayRec db '[5] Display Section Student Record', 10, 0
    prompt_line db '===================================',10,0 

    select_opt db 'Select Option: ', 0   
    input_opt db '%s', 0

    ; adding a student record 
    student_info db 'Enter Student Information:', 10, 0
    prompt_name db 'Full Name: ', 0
    input_name db '%s', 0
    promptSection db 'Section (A,B,C): ', 0
    inputSection db '%s', 0
    prompt_birthday db 'Birthday (MM/DD/YYYY): ', 0
    index_names db 'Full Name: ', 0
    prompt_contact db 'Contact Number: ', 0
    input_contact db '%s', 0
    student_added db 'Student added successfully.', 10, 0
    prompt_addto db 'Add to Index [1-5]: ', 0
    input_add_to db '%s', 0
    
    ; deleting student records 
    prompt_delete_index db 'Enter the index of the student to delete (1-5): ', 0
    input_delete_index db '%s', 0
    deleted_success db 'Student Record deleted successfully.', 10, 0
    edit_error db "Student index 1 not found!", 0

    ; editing student records
    prompt_edit_index db 'Enter the index of the student to edit (1-5): ', 0
    input_edit_index db '%s', 0
    updated_info db 'Enter updated information: ', 10, 0
    update_success db 'Student Information updated successfully.', 10, 0

    ; displaying all and display section
    prompt_display_all_header db '======= All Student Records =======', 10, 0
    prompt_student1 db '[Index-1]', 10, 0
    prompt_student2 db '[Index-2]', 10, 0
    prompt_student3 db '[Index-3]', 10, 0
    prompt_student4 db '[Index-4]', 10, 0
    prompt_student5 db '[Index-5]', 10, 0  
    prompt_display_sect_header db '=== Section Student Records ===', 10, 0
    section_display db "Enter the section to display (A,B,C): ", 0
    input_displaySection db '%s', 0

    prompt_display_all_empty db 'No student records to display.', 10, 0

    ; prompt to display all the student info
    added_index1 db 'Name:     %s', 0xA
                db 'Section:  %s', 0xA
                db 'Birthday: %s', 0xA
                db 'Contact:  %s', 0xA, 0
    added_index2 db 'Name:     %s', 0xA
                db 'Section:  %s', 0xA
                db 'Birthday: %s', 0xA
                db 'Contact:  %s', 0xA, 0
    added_index3 db 'Name:     %s', 0xA
                db 'Section:  %s', 0xA
                db 'Birthday: %s', 0xA
                db 'Contact:  %s', 0xA, 0
    added_index4 db 'Name:     %s', 0xA
                db 'Section:  %s', 0xA
                db 'Birthday: %s', 0xA
                db 'Contact:  %s', 0xA, 0
    added_index5 db 'Name:     %s', 0xA
                db 'Section:  %s', 0xA
                db 'Birthday: %s', 0xA
                db 'Contact:  %s', 0xA, 0

    ; thank you msg and newline
    thank_you_msg db 'Thank you!', 10, 0
    newline db 10,0

    ; Error prompts
    invalid_opt_msg db "Selected option is not on the menu. Please enter a valid option.", 10, 0
    invalid_index db "Index didn't exist. Please enter a valid index.", 10,0

section .bss
    menu_option resb 5
    add_option resb 5
    edit_option resb 5
    deleted_index resb 5
    displaySection resb 5
    ; for index one
    userName1 resb 100
    userSection1 resb 100
    userBday1 resb 100 
    userContact1 resb 100
    ; for index two
    userName2 resb 100
    userSection2 resb 100
    userBday2 resb 100 
    userContact2 resb 100
    ; for index three
    userName3 resb 100
    userSection3 resb 100
    userBday3 resb 100 
    userContact3 resb 100
    ; for index four
    userName4 resb 100
    userSection4 resb 100
    userBday4 resb 100 
    userContact4 resb 100
    ; for index five
    userName5 resb 100
    userSection5 resb 100
    userBday5 resb 100 
    userContact5 resb 100

section .text
    global _main
    extern _atoi
    extern _printf
    extern _scanf
    extern _exit
    extern _gets

; function to add student information to index(1-5)
to_add_index:
    push prompt_addto
    call _printf
    add esp, 4

    push add_option
    push input_add_to
    call _scanf
    add esp, 8
    
    mov eax, [add_option]
    cmp eax, '1'  
    je index_one
    cmp eax, '2'      
    je index_two
    cmp eax, '3'       
    je index_three
    cmp eax, '4'      
    je index_four
    cmp eax, '5'       
    je index_five  
    jmp error_addindex

error_addindex:
     ; Display an error message for an invalid index
	cmp dword [input_add_to], 'a'
	je error_addindex
	cmp dword [input_add_to], '6'
	je error_addindex

	push invalid_index
	call _printf
	add esp, 4
    jmp to_add_index 

; function of editing student information in the records
to_edit_index:
    push prompt_edit_index
    call _printf
    add esp, 4

    push edit_option
    push input_edit_index
    call _scanf
    add esp, 8
    
    mov eax, [edit_option]
    cmp eax, '1'          
    je to_edit1
    cmp eax, '2'         
    je to_edit2
    cmp eax, '3'        
    je to_edit3
    cmp eax, '4'        
    je to_edit4
    cmp eax, '5'      
    je to_edit5 
    jmp error_edit_index

error_edit_index:
    ; Display an error message for an invalid index
	cmp dword [input_edit_index], 'a'
	je error_edit_index
	cmp dword [input_edit_index], '6'
	je error_edit_index

	push invalid_index
	call _printf
	add esp, 4
    jmp to_edit_index

; function of deleting student information from the records
to_delete_index:
   ; Display the prompt to enter the index of the student to delete
    push prompt_delete_index
    call _printf
    add esp, 4

    ; Read the index from the user 
    push deleted_index
    push input_delete_index
    call _scanf
    add esp, 8

    mov eax, [deleted_index]
    cmp eax, '1'    
    je delete_index1
    cmp eax, '2'    
    je delete_index2
    cmp eax, '3'   
    je delete_index3
    cmp eax, '4'    
    je delete_index4
    cmp eax, '5'  
    je delete_index5
    jmp error_delete_index
    
error_delete_index:
    ; Display an error message for an invalid index
    cmp dword [input_edit_index], 'a'
	je error_edit_index
	cmp dword [input_edit_index], '6'
	je error_edit_index

    push invalid_index
    call _printf
    add esp, 4
    jmp delete
  
; function of displaying the student records that stored in section A, B, C
to_displaySection:
    push section_display
    call _printf
    add esp, 4

    push displaySection
    push input_displaySection
    call _scanf
    add esp, 8

    mov eax, [displaySection]
    cmp eax, 'A'    
    je check_student1
    cmp eax, 'B'    
    je check_student1
    cmp eax, 'C'   
    je check_student1
    jmp error_display_section
    
error_display_section:
    ; Display an error message for an invalid index
    cmp dword [input_edit_index], 'a'
	je error_edit_index
	cmp dword [input_edit_index], '6'
	je error_edit_index

    push invalid_index
    call _printf
    add esp, 4
    jmp to_displaySection




_main:
    ; Display the program name and options
    push prompt_msg      
    call _printf
    add esp, 4
menu_loop:
    push prompt_class
    call _printf
    add esp, 4

    push prompt_exit
    call _printf
    add esp, 4

    push prompt_add
    call _printf
    add esp, 4

    push prompt_delete
    call _printf
    add esp, 4

    push prompt_edit
    call _printf
    add esp, 4

    push prompt_displayAll
    call _printf
    add esp, 4

    push prompt_displayRec
    call _printf
    add esp, 4

    ; Display the select_opt prompt
enter_option:
    push select_opt
    call _printf
    add esp, 4

    ; Read the input_opt
    push menu_option
    push input_opt
    call _scanf
    add esp, 8
    
    ; Check the input choice
    mov eax, [menu_option]
    cmp eax, '1'           ; Add
    je add
    cmp eax, '2'          ; Delete
    je delete
    cmp eax, '3'          ; Edit
    je edit
    cmp eax, '4'          ; Display All
    je displayAll
    cmp eax, '5'          ; Display Section Student Record
    je displayRec          
    cmp eax, '0'          ; Exit
    je exit
    jmp error_prompt

error_prompt:
    ; Invalid option, display a message and loop again
	cmp dword [input_opt], 'a'
	je error_prompt
	cmp dword [input_opt], '6'
	je error_prompt

	push invalid_opt_msg
	call _printf
	add esp, 4
    jmp enter_option    ; ask the user to "Select Option: " again

add:
    jmp to_add_index
    add esp, 8

index_one:
    push newline
    call _printf
    add esp, 8
   ; Prompt the user to enter student information
    push student_info
    call _printf
    add esp, 4
    ; Prompt the user to enter the name
    push prompt_name
    call _printf
    call _gets
    add esp, 4
    push userName1
    call _gets
    add esp, 8
    ; Prompt the user to enter section
    push promptSection
    call _printf
    add esp, 4
    push userSection1
    call _gets
    add esp, 8
    ; Prompt the user to enter birthday
    push prompt_birthday
    call _printf
    add esp, 4
    push userBday1
    call _gets
    add esp, 8
    ; Prompt the user to enter contact
    push prompt_contact
    call _printf
    add esp, 4
    push userContact1
    call _gets
    add esp, 8
    push newline
    call _printf
    add esp, 8
    push student_added
    call _printf
    add esp, 4
    push newline
    call _printf
    add esp, 8
to_display_one:
    push userContact1
    push userBday1
    push userSection1
    push userName1
    push added_index1
    call _printf
    add esp, 16
    jmp menu_loop

index_two:
    push newline
    call _printf
    add esp, 8
   ; Prompt the user to enter student information
    push student_info
    call _printf
    add esp, 4
    ; Prompt the user to enter name
    push index_names
    call _printf
    push prompt_name
    call _printf
    call _gets  
    add esp, 4
    push userName2
    call _gets
    add esp, 8
    ; Prompt the user to enter section
    push promptSection
    call _printf
    add esp, 4
    push userSection2
    call _gets
    add esp, 8
    ; Prompt the user to enter birthday
    push prompt_birthday
    call _printf
    add esp, 4
    push userBday2
    call _gets
    add esp, 8
    ; Prompt the user to enter contact
    push prompt_contact
    call _printf
    add esp, 4
    push userContact2
    call _gets
    add esp, 8
    push newline
    call _printf
    add esp, 8
    push student_added
    call _printf
    add esp, 4
    push newline
    call _printf
    add esp, 8
to_display_two:
    push userContact2
    push userBday2
    push userSection2
    push userName2
    push added_index2
    call _printf
    add esp, 16
    jmp menu_loop

index_three:
    push newline
    call _printf
    add esp, 8
   ; Prompt the user to enter student information
    push student_info
    call _printf
    add esp, 4
    ; Prompt the user to enter name
    push index_names
    call _printf
    push prompt_name
    call _printf
    call _gets
    add esp, 4
    push userName3
    call _gets
    add esp, 8
    ; Prompt the user to enter section
    push promptSection
    call _printf
    add esp, 4
    push userSection3
    call _gets
    add esp, 8
    ; Prompt the user to enter birthday
    push prompt_birthday
    call _printf
    add esp, 4
    push userBday3
    call _gets
    add esp, 8
    ; Prompt the user to enter contact
    push prompt_contact
    call _printf
    add esp, 4
    push userContact3
    call _gets
    add esp, 8
    push newline
    call _printf
    add esp, 8
    push student_added
    call _printf
    add esp, 4
    push newline
    call _printf
    add esp, 8
to_display_three:
    push userContact3
    push userBday3
    push userSection3
    push userName3
    push added_index3
    call _printf
    add esp, 16
    jmp menu_loop

index_four:
    push newline
    call _printf
    add esp, 8
   ; Prompt the user to enter student information
    push student_info
    call _printf
    add esp, 4
    ; Prompt the user to enter name
    push index_names
    call _printf
    push prompt_name
    call _printf
    call _gets
    add esp, 4
    push userName4
    call _gets
    add esp, 8
    ; Prompt the user to enter section
    push promptSection
    call _printf
    add esp, 4
    push userSection4
    call _gets
    add esp, 8
    ; Prompt the user to enter birthday
    push prompt_birthday
    call _printf
    add esp, 4
    push userBday4
    call _gets
    add esp, 8
    ; Prompt the user to enter contact
    push prompt_contact
    call _printf
    add esp, 4
    push userContact4
    call _gets
    add esp, 8
    push newline
    call _printf
    add esp, 8
    push student_added
    call _printf
    add esp, 4
    push newline
    call _printf
    add esp, 8
to_display_four:
    push userContact4
    push userBday4
    push userSection4
    push userName4
    push added_index4
    call _printf
    add esp, 16
    jmp menu_loop

index_five:
    push newline
    call _printf
    add esp, 8
   ; Prompt the user to enter student information
    push student_info
    call _printf
    add esp, 4
    ; Prompt the user to enter name
    push index_names
    call _printf
    push prompt_name
    call _printf
    call _gets
    add esp, 4
    push userName5
    call _gets
    add esp, 8
    ; Prompt the user to enter section
    push promptSection
    call _printf
    add esp, 4
    push userSection5
    call _gets
    add esp, 8
    ; Prompt the user to enter birthday
    push prompt_birthday
    call _printf
    add esp, 4
    push userBday5
    call _gets
    add esp, 8
    ; Prompt the user to enter contact
    push prompt_contact
    call _printf
    add esp, 4
    push userContact5
    call _gets
    add esp, 8
    push newline
    call _printf
    add esp, 8
    push student_added
    call _printf
    add esp, 4
    push newline
    call _printf
    add esp, 8
to_display_five:
    push userContact5
    push userBday5
    push userSection5
    push userName5
    push added_index5
    call _printf
    add esp, 16
    jmp menu_loop

delete:
    ; Delete function
    jmp to_delete_index
    add esp, 8

delete_index1:
    ; Clear the data associated with index 1
    mov dword [userName1], 0
    mov dword [userSection1], 0
    mov dword [userBday1], 0
    mov dword [userContact1], 0
    ; Display deletion success message
    jmp prompt_deleted_success

delete_index2:
    ; Clear the data associated with index 1
    mov dword [userName2], 0
    mov dword [userSection2], 0
    mov dword [userBday2], 0
    mov dword [userContact2], 0
    ; Display deletion success message
    jmp prompt_deleted_success

delete_index3:
    ; Clear the data associated with index 1
    mov dword [userName3], 0
    mov dword [userSection3], 0
    mov dword [userBday3], 0
    mov dword [userContact3], 0
    ; Display deletion success message
    jmp prompt_deleted_success

delete_index4:
    ; Clear the data associated with index 1
    mov dword [userName4], 0
    mov dword [userSection4], 0
    mov dword [userBday4], 0
    mov dword [userContact4], 0
    ; Display deletion success message
    jmp prompt_deleted_success

delete_index5:
    ; Clear the data associated with index 1
    mov dword [userName5], 0
    mov dword [userSection5], 0
    mov dword [userBday5], 0
    mov dword [userContact5], 0
    jmp prompt_deleted_success

    ; Display deletion success message
prompt_deleted_success:
    push newline
    call _printf
    add esp, 4
    push deleted_success
    call _printf
    add esp, 4
    push newline
    call _printf
    add esp, 4
    jmp menu_loop 


edit:
    ; Edit Function
    jmp to_edit_index
    add esp, 8

to_edit1:
    push newline
    call _printf
    add esp, 8
    ; Prompt the user to enter updated student information for index-1
    push updated_info
    call _printf
    add esp, 4
    push index_names
    call _printf
    push prompt_name
    call _printf
    call _gets
    add esp, 4
    push userName1
    call _gets
    add esp, 8
    push promptSection
    call _printf
    add esp, 4
    push userSection1
    call _gets
    add esp, 8
    push prompt_birthday
    call _printf
    add esp, 4
    push userBday1
    call _gets
    add esp, 8
    push prompt_contact
    call _printf
    add esp, 4
    push userContact1
    call _gets
    add esp, 8
    push newline
    call _printf
    add esp, 8
    push update_success
    call _printf
    add esp, 4
    push newline
    call _printf
    add esp, 8
    jmp menu_loop

to_edit2:
    push newline
    call _printf
    add esp, 8
    ; Prompt the user to enter updated student information for index-2
    push updated_info
    call _printf
    add esp, 4
    push index_names
    call _printf
    push prompt_name
    call _printf
    call _gets
    add esp, 4
    push userName2
    call _gets
    add esp, 8
    push promptSection
    call _printf
    add esp, 4
    push userSection2
    call _gets
    add esp, 8
    push prompt_birthday
    call _printf
    add esp, 4
    push userBday2
    call _gets
    add esp, 8 
    push prompt_contact
    call _printf
    add esp, 4
    push userContact2
    call _gets
    add esp, 8
    push newline
    call _printf
    add esp, 8
    push update_success
    call _printf
    add esp, 4
    push newline
    call _printf
    add esp, 8
    jmp menu_loop

to_edit3:
    push newline
    call _printf
    add esp, 8
    ; Prompt the user to enter updated student information for index-3
    push updated_info
    call _printf
    add esp, 4
    push index_names
    call _printf
    push prompt_name
    call _printf
    call _gets
    add esp, 4
    push userName3
    call _gets
    add esp, 8
    push promptSection
    call _printf
    add esp, 4
    push userSection3
    call _gets
    add esp, 8
    push prompt_birthday
    call _printf
    add esp, 4
    push userBday3
    call _gets
    add esp, 8
    push prompt_contact
    call _printf
    add esp, 4
    push userContact3
    call _gets
    add esp, 8
    push newline
    call _printf
    add esp, 8
    push update_success
    call _printf
    add esp, 4
    push newline
    call _printf
    add esp, 8
    jmp menu_loop

to_edit4:
    push newline
    call _printf
    add esp, 8
    ; Prompt the user to enter updated student information for index-1
    push updated_info
    call _printf
    add esp, 4
    push index_names
    call _printf
    push prompt_name
    call _printf
    call _gets
    add esp, 4
    push userName4
    call _gets
    add esp, 8
    push promptSection
    call _printf
    add esp, 4
    push userSection4
    call _gets
    add esp, 8
    push prompt_birthday
    call _printf
    add esp, 4
    push userBday4
    call _gets
    add esp, 8
    push prompt_contact
    call _printf
    add esp, 4
    push userContact4
    call _gets
    add esp, 8
    push newline
    call _printf
    add esp, 8
    push update_success
    call _printf
    add esp, 4
    push newline
    call _printf
    add esp, 8
    jmp menu_loop

to_edit5:
    push newline
    call _printf
    add esp, 8
    ; Prompt the user to enter updated student information for index-5
    push updated_info
    call _printf
    add esp, 4
    push index_names
    call _printf
    push prompt_name
    call _printf
    call _gets
    add esp, 4
    push userName5
    call _gets
    add esp, 8
    push promptSection
    call _printf
    add esp, 4
    push userSection5
    call _gets
    add esp, 8
    push prompt_birthday
    call _printf
    add esp, 4
    push userBday5
    call _gets
    add esp, 8
    push prompt_contact
    call _printf
    add esp, 4
    push userContact5
    call _gets
    add esp, 8
    push newline
    call _printf
    add esp, 8
    push update_success
    call _printf
    add esp, 4
    push newline
    call _printf
    add esp, 8
    jmp menu_loop

displayAll:
    ; Display all function
    push newline
    call _printf
    add esp, 4
    ; Display header
    push prompt_display_all_header
    call _printf
    add esp, 4
    ; prompt to display index 1
    push prompt_student1
    call _printf
    add esp, 4
    push userContact1
    push userBday1
    push userSection1
    push userName1
    push added_index1
    call _printf
    add esp, 16
    push newline
    call _printf
    add esp, 8
    ; prompt to display index 2
    push prompt_student2
    call _printf
    add esp, 4
    push userContact2
    push userBday2
    push userSection2
    push userName2
    push added_index2
    call _printf
    add esp, 16
    push newline
    call _printf
    add esp, 8
    ; prompt to display index 3  
    push prompt_student3
    call _printf
    add esp, 4
    push userContact3
    push userBday3
    push userSection3
    push userName3
    push added_index3
    call _printf
    add esp, 16
    push newline
    call _printf
    add esp, 8
    ; prompt to display index 4  
    push prompt_student4
    call _printf
    add esp, 4
    push userContact4
    push userBday4
    push userSection4
    push userName4
    push added_index4
    call _printf
    add esp, 16
    push newline
    call _printf
    add esp, 8
    ; prompt to display index 5  
    push prompt_student5
    call _printf
    add esp, 4
    push userContact5
    push userBday5
    push userSection5
    push userName5
    push added_index5
    call _printf
    add esp, 16
    push newline
    call _printf
    add esp, 8
    jmp menu_loop

displayRec:
    jmp to_displaySection
    add esp, 8

    push newline
    call _printf
    push prompt_display_sect_header

    push newline
    call _printf
    add esp, 4

check_student1:
        ; Display student records for the entered section
        ; Check and display student 1
        mov eax, [userSection1]
        cmp eax, [displaySection]
        je display_student1

        jmp check_student2
    
check_student2:
        ; Check and display student 2
        mov eax, [userSection2]
        cmp eax, [displaySection]
        je display_student2
    
        jmp check_student3
    
check_student3:
        ; Check and display student 3
        mov eax, [userSection3]
        cmp eax, [displaySection]
        je display_student3
    
        jmp check_student4
    
check_student4:
        ; Check and display student 4
        mov eax, [userSection4]
        cmp eax, [displaySection]
        je display_student4
    
        jmp check_student5
    
check_student5:
        ; Check and display student 2
        mov eax, [userSection5]
        cmp eax, [displaySection]
        je display_student5
        
display_student1:
    push newline
    call _printf
    add esp, 4
    push userContact1
    push userBday1
    push userSection1
    push userName1
    push added_index1
    call _printf
    add esp, 16
    jmp menu_loop
    
display_student2:
    push newline
    call _printf
    add esp, 4
    push userContact2
    push userBday2
    push userSection2
    push userName2
    push added_index2
    call _printf
    add esp, 16
    jmp menu_loop
        
display_student3:
    push newline
    call _printf
    add esp, 4
    push userContact3
    push userBday3
    push userSection3
    push userName3
    push added_index3
    call _printf
    add esp, 16
    jmp menu_loop
    
display_student4:
    push newline
    call _printf
    add esp, 4
    push userContact4
    push userBday4
    push userSection4
    push userName4
    push added_index4
    call _printf
    add esp, 16
    jmp menu_loop
    
display_student5:
    push newline
    call _printf
    add esp, 4
    push userContact5
    push userBday5
    push userSection5
    push userName5
    push added_index5
    call _printf
    add esp, 16
    jmp menu_loop

exit:
    push prompt_line
    call _printf
    add esp, 4

    push thank_you_msg
    call _printf
    add esp, 4
    call _exit 





