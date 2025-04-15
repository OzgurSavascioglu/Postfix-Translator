.section .bss
input_buffer: .space 256

.section .data
//bin_str: .ascii "000000000000 "
bin_str: .ascii "000000000000"
add_f3: .ascii " 000"
add_x0: .ascii " 00000"
add_x1: .ascii " 00001"
add_x2: .ascii " 00010"
add_opcode: .ascii " 0110011\n"
imm_opcode: .ascii " 0010011\n"
imm: .ascii "0000100"
imm_add: .ascii "0000000"
f7_sub: .ascii "0100000"
f7_mul: .ascii "0000001"
f7_bxor: .ascii "0000100"
f7_band: .ascii "0000111"
f7_bor: .ascii "0000110"
nl: .ascii "\n"

.section .text
.global _start

_start:
    # Read input from standard input
    mov $0, %eax                    # syscall number for sys_read
    mov $0, %edi                    # file descriptor 0 (stdin)
    lea input_buffer(%rip), %rsi    # pointer to the input buffer
    mov $256, %edx                  # maximum number of bytes to read
    syscall                         # perform the syscall

    lea input_buffer(%rip), %r15     
    mov $0, %r14
    mov $0, %rax

read_input: 
    mov $0, %rbx             # Clear rbx
    mov $0, %r13            # Clear r13
    movb (%r15),%bl             # Read the first char
    cmp $' ', %rbx              # If space, create the number
    je increment
    cmp $'+', %rbx              # If +, go to addition function
    je addition
    cmp $'-', %rbx              # If -, go to substraction function
    je substraction
    cmp $'*', %rbx              # If *, go to multiplication function
    je multiplication
    cmp $'^', %rbx              # If ^, go to bitwise_xor function
    je bitwise_xor
    cmp $'&', %rbx              # If &, go to bitwise_and function
    je bitwise_and
    cmp $'|', %rbx              # If |, go to bitwise_or function
    je bitwise_or
    cmp $'\n', %rbx             # If newline, exit program
    je exit_program
    sub $'0', %bl             # Convert to digit from ASCII
    imull $10, %eax           # Multiply the exisiting figure in eax by 10
    movzbl %bl, %r13d
    addl %r13d, %eax            # Add current digit to the existing number           
    inc %r15                  # Move to the next character
    jmp read_input
increment:
    push %rax
    //inc %r13
    inc %r15
    mov $0, %rax
    jmp read_input

addition:
    //call clear_string
    mov $0, %r9
    //first operand
    pop %rbx
    mov %rbx, %r9
    mov %rbx, %r12             #r12 is used to dinary_transofmraiton calc
    mov $11, %rcx
    call neg_check

    lea bin_str(%rip), %rsi   # Number string address
    mov $12, %edx                # Number string length
    call print_string         # Print number string

    call clear_string

    lea add_x0(%rip), %rsi   # x0 string address
    mov $6, %edx                # x0 string length
    call print_string         # Print x0 string

    lea add_f3(%rip), %rsi   # f3 string address
    mov $4, %edx                # f3 string length
    call print_string         # Print f3 string

    lea add_x2(%rip), %rsi   # x2 string address
    mov $6, %edx                # x2 string length
    call print_string         # Print x2 string

    lea imm_opcode(%rip), %rsi   # op_code string address
    mov $9, %edx                # op_code string length
    call print_string         # Print op_code string
   
    //second operand
    pop %rbx
    add %rbx, %r9

    push %r9 #push the result to the stack
    mov %rbx, %r12             #r12 is used to dinary_transofmraiton calc
    mov $11, %rcx
    call neg_check

    lea bin_str(%rip), %rsi   # Number string address
    mov $12, %edx                # Number string length
    call print_string         # Print number string

    call clear_string

    lea add_x0(%rip), %rsi   # x0 string address
    mov $6, %edx                # x0 string length
    call print_string         # Print x0 string

    lea add_f3(%rip), %rsi   # f3 string address
    mov $4, %edx                # f3 string length
    call print_string         # Print f3 string

    lea add_x1(%rip), %rsi   # x1 string address
    mov $6, %edx                # x1 string length
    call print_string         # Print x1 string

    lea imm_opcode(%rip), %rsi   # op_code string address
    mov $9, %edx                # op_code string length
    call print_string         # Print op_code string

   //print the last part
    lea imm_add(%rip), %rsi   # Address of the output string
    mov $7, %edx                # Length of the string to print
    call print_string         # Call the print function
    
    lea add_x2(%rip), %rsi   # x2 string address
    mov $6, %edx                # x2 string length
    call print_string         # Print x2 string

    lea add_x1(%rip), %rsi   # x1 string address
    mov $6, %edx                # x1 string length
    call print_string         # Print x1 string
    
    lea add_f3(%rip), %rsi   # f3 string address
    mov $4, %edx                # f3 string length
    call print_string         # Print f3 string

    lea add_x1(%rip), %rsi   # x1 string address
    mov $6, %edx                # x1 string length
    call print_string         # Print x1 string

    lea add_opcode(%rip), %rsi   # op_code string address
    mov $9, %edx                # op_code string length
    call print_string         # Print op_code string             

    //inc %r13
    inc %r15
    mov $0, %rbx
    movb (%r15),%bl
    cmp $'\n', %rbx
    je exit_program
    cmp $' ', %rbx
    je skip
skip:
    inc %r15
    mov $0, %rax
    jmp read_input

substraction:
    //call clear_string
    mov $0, %r9
    //first operand
    pop %rbx
    mov %rbx, %r9
    mov %rbx, %r12             #r12 is used to dinary_transofmraiton calc
    mov $11, %rcx
    call neg_check

    lea bin_str(%rip), %rsi   # Number string address
    mov $12, %edx                # Number string length
    call print_string         # Print number string

    call clear_string

    lea add_x0(%rip), %rsi   # x0 string address
    mov $6, %edx                # x0 string length
    call print_string         # Print x0 string

    lea add_f3(%rip), %rsi   # f3 string address
    mov $4, %edx                # f3 string length
    call print_string         # Print f3 string

    lea add_x2(%rip), %rsi   # x2 string address
    mov $6, %edx                # x2 string length
    call print_string         # Print x2 string

    lea imm_opcode(%rip), %rsi   # op_code string address
    mov $9, %edx                # op_code string length
    call print_string         # Print op_code string
   
    //second operand
    pop %rbx
    mov %rbx, %r12 
    mov $11, %rcx
    call neg_check

    mov %rbx, %r8 
    sub %r9, %r8
    mov %r8, %r9

    push %r9 #push the result to the stack 

    lea bin_str(%rip), %rsi   # Number string address
    mov $12, %edx                # Number string length
    call print_string         # Print number string

    call clear_string

    lea add_x0(%rip), %rsi   # x0 string address
    mov $6, %edx                # x0 string length
    call print_string         # Print x0 string

    lea add_f3(%rip), %rsi   # f3 string address
    mov $4, %edx                # f3 string length
    call print_string         # Print f3 string

    lea add_x1(%rip), %rsi   # x1 string address
    mov $6, %edx                # x1 string length
    call print_string         # Print x1 string

    lea imm_opcode(%rip), %rsi   # op_code string address
    mov $9, %edx                # op_code string length
    call print_string         # Print op_code string

   //print the last part
    lea f7_sub(%rip), %rsi   # Address of the output string
    mov $7, %edx                # Length of the string to print
    call print_string         # Call the print function
    
    lea add_x2(%rip), %rsi   # x2 string address
    mov $6, %edx                # x2 string length
    call print_string         # Print x2 string

    lea add_x1(%rip), %rsi   # x1 string address
    mov $6, %edx                # x1 string length
    call print_string         # Print x1 string
    
    lea add_f3(%rip), %rsi   # f3 string address
    mov $4, %edx                # f3 string length
    call print_string         # Print f3 string

    lea add_x1(%rip), %rsi   # x1 string address
    mov $6, %edx                # x1 string length
    call print_string         # Print x1 string

    lea add_opcode(%rip), %rsi   # op_code string address
    mov $9, %edx                # op_code string length
    call print_string         # Print op_code string             

    //inc %r13
    inc %r15
    mov $0, %rbx
    movb (%r15),%bl
    cmp $'\n', %rbx
    je exit_program
    cmp $' ', %rbx
    je sub_skip

sub_skip:
    inc %r15
    mov $0, %rax
    jmp read_input


multiplication:
    //call clear_string
    mov $0, %r9
    //first operand
    pop %rbx
    mov %rbx, %r9
    mov %rbx, %r12             #r12 is used to dinary_transofmraiton calc
    mov $11, %rcx
    call neg_check

    lea bin_str(%rip), %rsi   # Number string address
    mov $12, %edx                # Number string length
    call print_string         # Print number string

    call clear_string

    lea add_x0(%rip), %rsi   # x0 string address
    mov $6, %edx                # x0 string length
    call print_string         # Print x0 string

    lea add_f3(%rip), %rsi   # f3 string address
    mov $4, %edx                # f3 string length
    call print_string         # Print f3 string

    lea add_x2(%rip), %rsi   # x2 string address
    mov $6, %edx                # x2 string length
    call print_string         # Print x2 string

    lea imm_opcode(%rip), %rsi   # op_code string address
    mov $9, %edx                # op_code string length
    call print_string         # Print op_code string
   
    //second operand
    pop %rbx
    imulq %rbx, %r9

    push %r9 #push the result to the stack
    mov %rbx, %r12             #r12 is used to dinary_transofmraiton calc
    mov $11, %rcx
    call neg_check

    lea bin_str(%rip), %rsi   # Number string address
    mov $12, %edx                # Number string length
    call print_string         # Print number string

    call clear_string

    lea add_x0(%rip), %rsi   # x0 string address
    mov $6, %edx                # x0 string length
    call print_string         # Print x0 string

    lea add_f3(%rip), %rsi   # f3 string address
    mov $4, %edx                # f3 string length
    call print_string         # Print f3 string

    lea add_x1(%rip), %rsi   # x1 string address
    mov $6, %edx                # x1 string length
    call print_string         # Print x1 string

    lea imm_opcode(%rip), %rsi   # op_code string address
    mov $9, %edx                # op_code string length
    call print_string         # Print op_code string

   //print the last part
    lea f7_mul(%rip), %rsi   # Address of the output string
    mov $7, %edx                # Length of the string to print
    call print_string         # Call the print function
    
    lea add_x2(%rip), %rsi   # x2 string address
    mov $6, %edx                # x2 string length
    call print_string         # Print x2 string

    lea add_x1(%rip), %rsi   # x1 string address
    mov $6, %edx                # x1 string length
    call print_string         # Print x1 string
    
    lea add_f3(%rip), %rsi   # f3 string address
    mov $4, %edx                # f3 string length
    call print_string         # Print f3 string

    lea add_x1(%rip), %rsi   # x1 string address
    mov $6, %edx                # x1 string length
    call print_string         # Print x1 string

    lea add_opcode(%rip), %rsi   # op_code string address
    mov $9, %edx                # op_code string length
    call print_string         # Print op_code string             

    //inc %r13
    inc %r15
    mov $0, %rbx
    movb (%r15),%bl
    cmp $'\n', %rbx
    je exit_program
    cmp $' ', %rbx
    je mul_skip
mul_skip:
    inc %r15
    mov $0, %rax
    jmp read_input

bitwise_xor:
    //call clear_string
    mov $0, %r9
    //first operand
    pop %rbx
    mov %rbx, %r9
    mov %rbx, %r12             #r12 is used to dinary_transofmraiton calc
    mov $11, %rcx
    call neg_check

    lea bin_str(%rip), %rsi   # Number string address
    mov $12, %edx                # Number string length
    call print_string         # Print number string

    call clear_string

    lea add_x0(%rip), %rsi   # x0 string address
    mov $6, %edx                # x0 string length
    call print_string         # Print x0 string

    lea add_f3(%rip), %rsi   # f3 string address
    mov $4, %edx                # f3 string length
    call print_string         # Print f3 string

    lea add_x2(%rip), %rsi   # x2 string address
    mov $6, %edx                # x2 string length
    call print_string         # Print x2 string

    lea imm_opcode(%rip), %rsi   # op_code string address
    mov $9, %edx                # op_code string length
    call print_string         # Print op_code string
   
    //second operand
    pop %rbx
    xor %rbx, %r9

    push %r9 #push the result to the stack
    mov %rbx, %r12             #r12 is used to dinary_transofmraiton calc
    mov $11, %rcx
    call neg_check

    lea bin_str(%rip), %rsi   # Number string address000000000001 000001000 00010 0110011
    mov $12, %edx                # Number string length
    call print_string         # Print number string
    
    call clear_string

    lea add_x0(%rip), %rsi   # x0 string address
    mov $6, %edx                # x0 string length
    call print_string         # Print x0 string

    lea add_f3(%rip), %rsi   # f3 string address
    mov $4, %edx                # f3 string length
    call print_string         # Print f3 string

    lea add_x1(%rip), %rsi   # x1 string address
    mov $6, %edx                # x1 string length
    call print_string         # Print x1 string

    lea imm_opcode(%rip), %rsi   # op_code string address
    mov $9, %edx                # op_code string length
    call print_string         # Print op_code string

   //print the last part
    lea f7_bxor(%rip), %rsi   # Address of the output string
    mov $7, %edx                # Length of the string to print
    call print_string         # Call the print function
    
    lea add_x2(%rip), %rsi   # x2 string address
    mov $6, %edx                # x2 string length
    call print_string         # Print x2 string

    lea add_x1(%rip), %rsi   # x1 string address
    mov $6, %edx                # x1 string length
    call print_string         # Print x1 string
    
    lea add_f3(%rip), %rsi   # f3 string address
    mov $4, %edx                # f3 string length
    call print_string         # Print f3 string

    lea add_x1(%rip), %rsi   # x1 string address
    mov $6, %edx                # x1 string length
    call print_string         # Print x1 string

    lea add_opcode(%rip), %rsi   # op_code string address
    mov $9, %edx                # op_code string length
    call print_string         # Print op_code string             

    //inc %r13
    inc %r15
    mov $0, %rbx
    movb (%r15),%bl
    cmp $'\n', %rbx
    je exit_program
    cmp $' ', %rbx
    je bxor_skip
bxor_skip:
    inc %r15
    mov $0, %rax
    jmp read_input

bitwise_and:
    //call clear_string
    mov $0, %r9
    //first operand
    pop %rbx
    mov %rbx, %r9
    mov %rbx, %r12             #r12 is used to dinary_transofmraiton calc
    mov $11, %rcx
    call neg_check

    lea bin_str(%rip), %rsi   # Number string address
    mov $12, %edx                # Number string length
    call print_string         # Print number string

    call clear_string

    lea add_x0(%rip), %rsi   # x0 string address
    mov $6, %edx                # x0 string length
    call print_string         # Print x0 string

    lea add_f3(%rip), %rsi   # f3 string address
    mov $4, %edx                # f3 string length
    call print_string         # Print f3 string

    lea add_x2(%rip), %rsi   # x2 string address
    mov $6, %edx                # x2 string length
    call print_string         # Print x2 string

    lea imm_opcode(%rip), %rsi   # op_code string address
    mov $9, %edx                # op_code string length
    call print_string         # Print op_code string
   
    //second operand
    pop %rbx
    and %rbx, %r9

    push %r9 #push the result to the stack
    mov %rbx, %r12             #r12 is used to dinary_transofmraiton calc
    mov $11, %rcx
    call neg_check

    lea bin_str(%rip), %rsi   # Number string address
    mov $12, %edx                # Number string length
    call print_string         # Print number string

    call clear_string

    lea add_x0(%rip), %rsi   # x0 string address
    mov $6, %edx                # x0 string length
    call print_string         # Print x0 string

    lea add_f3(%rip), %rsi   # f3 string address
    mov $4, %edx                # f3 string length
    call print_string         # Print f3 string

    lea add_x1(%rip), %rsi   # x1 string address
    mov $6, %edx                # x1 string length
    call print_string         # Print x1 string

    lea imm_opcode(%rip), %rsi   # op_code string address
    mov $9, %edx                # op_code string length
    call print_string         # Print op_code string

   //print the last part
    lea f7_band(%rip), %rsi   # Address of the output string
    mov $7, %edx                # Length of the string to print
    call print_string         # Call the print function
    
    lea add_x2(%rip), %rsi   # x2 string address
    mov $6, %edx                # x2 string length
    call print_string         # Print x2 string

    lea add_x1(%rip), %rsi   # x1 string address
    mov $6, %edx                # x1 string length
    call print_string         # Print x1 string
    
    lea add_f3(%rip), %rsi   # f3 string address
    mov $4, %edx                # f3 string length
    call print_string         # Print f3 string

    lea add_x1(%rip), %rsi   # x1 string address
    mov $6, %edx                # x1 string length
    call print_string         # Print x1 string

    lea add_opcode(%rip), %rsi   # op_code string address
    mov $9, %edx                # op_code string length
    call print_string         # Print op_code string             

    //inc %r13
    inc %r15
    mov $0, %rbx
    movb (%r15),%bl
    cmp $'\n', %rbx
    je exit_program
    cmp $' ', %rbx
    je band_skip
band_skip:
    inc %r15
    mov $0, %rax
    jmp read_input

bitwise_or:
    //call clear_string
    mov $0, %r9
    //first operand
    pop %rbx
    mov %rbx, %r9
    mov %rbx, %r12             #r12 is used to dinary_transofmraiton calc
    mov $11, %rcx
    call neg_check

    lea bin_str(%rip), %rsi   # Number string address
    mov $12, %edx                # Number string length
    call print_string         # Print number string

    call clear_string

    lea add_x0(%rip), %rsi   # x0 string address
    mov $6, %edx                # x0 string length
    call print_string         # Print x0 string

    lea add_f3(%rip), %rsi   # f3 string address
    mov $4, %edx                # f3 string length
    call print_string         # Print f3 string

    lea add_x2(%rip), %rsi   # x2 string address
    mov $6, %edx                # x2 string length
    call print_string         # Print x2 string

    lea imm_opcode(%rip), %rsi   # op_code string address
    mov $9, %edx                # op_code string length
    call print_string         # Print op_code string
   
    //second operand
    pop %rbx
    or %rbx, %r9

    push %r9 #push the result to the stack
    mov %rbx, %r12             #r12 is used to dinary_transofmraiton calc
    mov $11, %rcx
    call neg_check

    lea bin_str(%rip), %rsi   # Number string address
    mov $12, %edx                # Number string length
    call print_string         # Print number string

    call clear_string

    lea add_x0(%rip), %rsi   # x0 string address
    mov $6, %edx                # x0 string length
    call print_string         # Print x0 string

    lea add_f3(%rip), %rsi   # f3 string address
    mov $4, %edx                # f3 string length
    call print_string         # Print f3 string

    lea add_x1(%rip), %rsi   # x1 string address
    mov $6, %edx                # x1 string length
    call print_string         # Print x1 string

    lea imm_opcode(%rip), %rsi   # op_code string address
    mov $9, %edx                # op_code string length
    call print_string         # Print op_code string

   //print the last part
    lea f7_bor(%rip), %rsi   # Address of the output string
    mov $7, %edx                # Length of the string to print
    call print_string         # Call the print function
    
    lea add_x2(%rip), %rsi   # x2 string address
    mov $6, %edx                # x2 string length
    call print_string         # Print x2 string

    lea add_x1(%rip), %rsi   # x1 string address
    mov $6, %edx                # x1 string length
    call print_string         # Print x1 string
    
    lea add_f3(%rip), %rsi   # f3 string address
    mov $4, %edx                # f3 string length
    call print_string         # Print f3 string

    lea add_x1(%rip), %rsi   # x1 string address
    mov $6, %edx                # x1 string length
    call print_string         # Print x1 string

    lea add_opcode(%rip), %rsi   # op_code string address
    mov $9, %edx                # op_code string length
    call print_string         # Print op_code string             

    //inc %r13
    inc %r15
    mov $0, %rbx
    movb (%r15),%bl
    cmp $'\n', %rbx
    je exit_program
    cmp $' ', %rbx
    je bor_skip
bor_skip:
    inc %r15
    mov $0, %rax
    jmp read_input


print_string:
    mov $1, %rax                # syscall number for sys_write
    mov $1, %rdi                # File descriptor 1 (stdout)
    syscall
    ret

clear_string:
    mov %rbx, %r12             #r12 is used to dinary_transofmraiton calc
    mov $11, %rcx
fill_zeros:
    movb $'0', bin_str(%rcx)
    dec %rcx
    cmp $-1, %rcx
    jne fill_zeros 
    ret            # Continue until r12=0

neg_check:
    testq %r12, %r12
    js neg_int
    jns int_to_binary
    ret

neg_int:
    notq %r12
    addq $1, %r12
    mov $11, %rcx
    call int_to_binary

    mov $12, %rcx
    call switch_all

    call complement_add
    ret

switch_all:
    mov %rbx, %r12             #r12 is used to dinary_transofmraiton calc
    mov $11, %rcx

digitby:
    cmpb $'0', bin_str(%rcx)
    je make1
    jne make0

c_loop:
    dec %rcx
    cmp $-1, %rcx
    jne digitby 
    ret            # Continue until r12=0

make0:
    movb $'0', bin_str(%rcx)
    jmp c_loop
make1:
    movb $'1', bin_str(%rcx)
    jmp c_loop

complement_add:
    mov %rbx, %r12             #r12 is used to dinary_transofmraiton calc
    mov $11, %rcx

dbay:
    cmpb $'0', bin_str(%rcx)
    je add1
    jne carry

cadd_loop:
    dec %rcx
    cmp $-1, %rcx
    jne dbay

end_cadd: 
    ret            # Continue until r12=0

carry:
    movb $'0', bin_str(%rcx)
    jmp cadd_loop
add1:
    movb $'1', bin_str(%rcx)
    jmp end_cadd

int_to_binary:
    cmp $0, %r12
    je end_of
    shrq $1, %r12               # Shift right by 1 (divide by 2)
    mov $0, %r14 
    adcb $'0', %r14b              # Add the carry flag (1 or 0) to r14
    movb %r14b, bin_str(%rcx)
    dec %rcx
    jmp int_to_binary            # Continue until r12=0
end_of:
    ret

exit_program:
    # Exit the program
    mov $60, %eax               # syscall number for sys_exit
    xor %edi, %edi              # exit code 0
    syscall
