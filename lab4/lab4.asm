#
# lab4.asm
# 
# Eric Chhun
# 10/10/22
#
# lab4
# implement an unsigned multiplication by using the shifting and add algorithm. 
#

        .data
x:      .word   0
y:      .word   0
result: .word   0
prompt1: .asciiz "\n Enter an intger: "
prompt2: .asciiz "\n Enter another intger: "
ans:    .asciiz "\n The output is: "
ans1:   .asciiz "\n The output is: "  
        .text   
        .globl main

main:  
        li      $v0, 4 # get the prompt by printing the string
        la      $a0, prompt1
        syscall
        li      $v0, 5 # read the string
        syscall
        sw      $v0, x
        nop
        sw      $v1, y
        nop
        sll     $t1, $t0, 1
        srl     $t2, $t1, 8
        mult    $t2, $t1
        nop
        sw      $t1, prompt1
        nop
        li      $v0, 4
        la      $a0, prompt2
        syscall
        sw      $t1, prompt2
        nop
        mult	$t1, $t0
        li      $v0, 10 
        syscall

# end of file
        





