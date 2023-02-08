#
# Assignment4.asm
#
# Eric Chhun
# 10/17/2
#
# Assignment4
# Excerise6
#

        .data
array:  .space 40
prompt:  .asciiz "Enter a number "
tab:    .asciiz "\t"
newline:   .asciiz "\n"
dmegs:  .asciiz "done"

        .text
        .globl main

main:
        la      $t0, array # let $t0 points to a pointer points to an array[0]
        li      $t0, 0 # counter for index
        li      $t2, 10  # maximum index of the array
        li      $v0, 4  # print the prompt
        la      $a0, prompt
        syscall
        li      $v0, 5 # get the number 
        syscall
# get the number
gnum:
        beq     $t1, $t2, nextnum # stop reading if the counter is at max index
        nop
        sw      $v0, ($t0) # store the number in the array
        nop
        addi    $t1, $t1, 1 # then increment the counter
        addi    $t0, $t0, 4 # increase pointer up to 4 bytes to next integer
        j       gnum # until counter == 10
        nop

# print the array before swapping the values
nextnum: 
        li      $t1, 0 # counter for index
        li      $v0, 4 # go to the next line
        la      $a0, endl
        syscall
        la      $t3, array # let $t3 points to a array
        li      $t2, 10 # max the index for the array

nextnum2: 
        beq    $t1, $t2, rev # print the array 
        nop
        lw      $t4, 0($t3)
        nop
        move    $v0, $t4
        or      $a0, $t4, $zero # return the value 
        li      $v0, 1 # for syscall 
        syscall
        li      $v0, 4
        la      $a0, tab
        addiu   $t4, $t3, 4
        addu    $t3, $t3, 4
        addi    $t1, $t1, 1 # get $t1 to point to the next array 
        j	nextnum2
        nop
rev: 
        addi    $t0, $t0, -4    # $t0 points to the array
        add	$t1, $t1, 1
        li      $t1, 0
        la      $t3, array
        la      $a0, endl
        syscall
# swao the numbers 
 swap:
        bge     $t3, $t0, end # compare the address and then
        # stop when its done
        nop
        lw      $t4, ($t0) # counter the index
        nop
        lw      $t5, ($t3)
        nop
        move    $v0, $t5
        sw      $t4, ($t3)
        nop
        sw      $t5, ($t0)
        nop
        addiu   $t0, $t0, -4 # move to the previous element
        addiu   $t3, $t3, 4 # then move to the next element
        b       swap
        nop
end:
        la      $t3, array 
        li      $t2, 10 # max index for the array 

# nextnum3:
#         beq     $t1, $t2, quit
#         nop
#         lw      $t4, ($t3)
#         nop
#         or      $a0, $t4, $zero
#         li	$v0, 1		# for syscall
# 	syscall
# 	li	$v0, 4
# 	la	$a0, tab	# reusing the $a0 register
# 	syscall
# 	addi	$t3, $t3, 4	# point to the next element in the array
# 	addi	$t1, $t1, 1	# increement the pointer
# 	j	numnext3 # j to the next2
# 	nop
# prints: lw	$a0, ($t0)	# print each value in array
# 	li	$v0, 1
# 	syscall
# 	la	$a0, tab	# print tab
# 	li	$v0, 4
# 	syscall
	
# 	addi	$t0, $t0, 4	
# 	addi	$t1, $t1, 1
# 	blt	$t1, $t2, prints
# 	nop
quit:
        li	$v0, 10 # end the program 
        syscall 

        

## End of program    



