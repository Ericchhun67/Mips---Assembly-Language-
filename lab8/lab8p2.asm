#
# lab8.asm
#
# Eric Chhun
# 11/19/22
#
# part2
# Using frame - based convention to computes the square of an integer n
# equal to a triangle
#
	
	
	
	.data
prompt:	.asciiz	"Please enter a number to compute square: "
result:	.asciiz	"The square of the number is: "

	.text
	.globl main
main:
	la	$a0, prompt		# load the address of the prompt
	li	$v0, 4			# system call code for print string
	syscall
	li	$v0, 5			# system call code for read an integer
	syscall
	addiu	$sp, $sp, -4		# allocate space on the stack
	sw	$v0, ($sp)		# save  N onto the stack
	nop
	jal	square			# call square subroutine 
	nop
	addiu	$sp, $sp, 4		# deallocate space for parameter
	move	$s0, $v0		# save the returned value to $s0
	la	$a0, result		# load the address of the result
	li	$v0, 4			# system call code for print string
	jal	triangle
	nop
	syscall
	move	$a0, $s0		# $a0=$s0
	li	$v0, 1			# system call code for print integer
	syscall
	li	$v0, 10			# Exit the program
	syscall

triangle:
	addiu	$sp, $sp, -4		# allocate space on the stack
	sw	$ra, ($sp)		# push $ra
	nop
	addiu	$sp, $sp, -4		# allocate space on the stack
	sw	$fp, ($sp)		# push $fp
	nop
	addiu	$sp, $sp, -4		# allocate space on the stack
	sw	$s0, ($sp)		
	nop
	move	$fp, $sp		# initialize the frame pointer
	lw	$s0, 12($fp)		# get the argument using stack pointer	
	li	$t0, 1			
	bgt	$s0, $t0, loopit	# branch to loop if N>1
	nop
	li	$v0, 1			# return value = 1
	b	endit
	nop
loopit:
	addiu	$t0, $s0, -1		# new argument = N-1
	addiu	$sp, $sp, -4		# allocate space on the stack
	sw	$t0, ($sp)		# push the argument onto the stack
	jal	triangle		
	nop
	addiu	$sp, $sp, 4		# deallocate space for variables
	lw	$t0, ($sp)		# we pop it
	add	$v0, $s0, $v0		# return value = $s0+triangle($t0)
	
endit:
	move	$sp, $fp		# $sp=$fp
	lw	$s0, ($sp)		# pop $s0
	addiu	$sp, $sp, 4		
	lw	$fp, ($sp)		# pop $s0
	addiu	$sp, $sp, 4		
	lw	$ra, ($sp)		# pop $s0
	addiu	$sp, $sp, 4		
	jr	$ra
	nop
# get the result of square numbers 
square: 
	addiu	$sp, $sp, -4		# allocate space on the stack
	sw	$ra, ($sp)		# push callers $ra on stack
	nop
	addiu	$sp, $sp, -4		# allocate space on the stack
	sw	$fp, ($sp)		# push callers $fp on stack
	nop
	addiu	$fp, $sp, -8		# space for two words to store results
	move	$sp, $fp		# $fp= $sp
	lw	$t0, 16($fp)		# get the user data
	nop
	ble	$t0, 1, return		# return if N <= 1
	nop
	addiu	$sp, $sp, -4		# space for the argument
	sw	$t0, ($sp)		# for triangle subroutine
	nop
	jal	triangle
	nop
	addiu	$sp, $sp, 4 		# we no longer need 
	sw	$v0, 4($fp)		# utilizing already saved space on stack
	nop

	lw	$t0, 16($fp)		# get the user data
	nop
	addi	$t0, $t0, -1		# this gives n-1
	addiu	$sp, $sp, -4		# space for the argument
	sw	$t0, ($sp)		# for triangle subroutine
	nop
	jal	triangle
	nop
	addiu	$sp, $sp, 4 		# we no longer need it 
	sw	$v0, ($fp)		# utilizing already saved space on stack
	nop
	lw	$t0, 4($fp)
	nop
	add	$v0, $v0, $t0
	b 	toUser
	nop

return:	li	$v0, 1			# return 1 if N <= 1 

toUser:	
	addiu	$sp, $fp, 8	        # deallocation of space for local variables
	lw	$fp, ($sp)		# caller's $fp
	nop
	addiu	$sp, $sp, 4
	lw	$ra, ($sp)		# caller's return address
	nop
	addiu	$sp, $sp, 4
	jr	$ra			# return
	nop
