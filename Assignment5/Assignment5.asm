#
# assignment5.asm
# 
# Eric Chhun
# 10/19/22
#
# excerise 1
# This program uses subroutine recurise
#   



        .data
int_arr .space 80
pmt:    .asciiz "Enter 10 numbers \n"

        .text
        .globl main


main:
        li	$v0, 4 # print the prompt
        la	$a0, pmt # read the prompt
        syscall
        li      $v0, 5 # read the array
        syscall
        move    $t0, $v0 # move the array to the address
        nop
        sw      $t0, ($s0)
        nop
        addi    $s0, $s0, 4
        b       pmt
        nop
# sort the number using bubble sort 
sort:
        li      $t1, 0 # i = 0
        li      $t2, 1 # j = 1
        li      $t4, 10 # n = 10
        li      $t5, 0 # temp = 0
        li      $t6, 0 # swap = 0
# use a loop to let the user enter the numbers
loopit:
        slt     $t3, $t2, $t4 # let j < n
        nop
        bne	$t3, $zero,  continue
        nop
        j       loopEnd # loop will end when j >= n
        nop

continue:
        lw      $t7, ($t1) # temp = a[i]
        lw      $t8, ($t2) # a[i] = a[j]
        nop
        sw      $t8, ($t1)
        sw      $t7, ($t2)
        nop
        addi    $t1, $t1, 4 # i++
        addi    $t2, $t2, 1 # j++
        j       loopit # go back to beginning of loop
        nop
loopEnd:
        li	$v0, 1
        lw      $a0, ($s0)
        syscall
        addi    $s0, $s0, 4
        b	quit
        nop
quit:
        li	$v0, 10 # exit the program
        syscall


# end of program































        



