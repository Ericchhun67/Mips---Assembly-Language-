#
# lab7.asm
#
# Eric Chhun
# 11/3/22
#
# lab7
# using 32 precision, prompt for three values - Turn off Bare Machine
#

           
       
        .data
aa:	.space 0
bb:	.space 0
cc:	.space 0 
v1:     .asciiz "prompt for a : "
v2:     .asciiz "prompt for b : "
v3:     .asciiz "prompt for c : "
res:    .asciiz " The result for 3ab - 2bc - 5a + 20ac – 16 = : "
        .text
        .globl main

main:
        # prompt for value a 
        la	$a0, v1 # pass to the function
        jal     getVal # get the value of a 
        nop
        sw     $t0, aa # save the value from $f0 to aa
        la	$a0, v2 # pass to the function
        jal     getVal # get the value of a 
        nop
        sw     $t0, bb  # save $f0 to bb
        
        la	$a0, v3 # pass to the function
        jal     getVal # get the value of a 
        nop
        sw     $t0, cc

        jal	solveeq
	li	$v0, 4 # get the result 
	la	$a0, res
	syscall
	li	$v0, 2
	syscall
	li	$v0, 10 # exit the programm
	syscall
getVal:
        li	$v0, 4 # prompt for the value a, b, c
	syscall
	li	$v0,6  # get a integer
	syscall
	jr	$ra # return address
	nop
# now push the value to the stack
solveeq:
        li	$t0, -16	# $t0 = -16
	addiu	$sp, $sp, -4
	sw	$t0, ($sp)	# push -16 to stack
        addiu	$sp, $sp, 4
	nop

	li	$t0, 20 	# $t0 = 20	
	lw	$t2, aa		# $t2 = a
	nop
	mul	$t0, $t0, $t2	# $t0 = 20a
	addiu	$sp, $sp, -4
	sw	$t0, ($sp)	# push 20a to stack  'intermediate value'
	nop
	lw	$t0, ($sp)	# poping 20a form stack and now multiply with c
	addiu	$sp, $sp, 4	# back off stack pointer
	lw	$t2, cc
	nop
	mul	$t0, $t0, $t2	# $t0 = 20ac
	nop
	addiu	$sp, $sp, -4
	lw	$t0, ($sp)	# push 20ac to stack
	nop


	li	$t0, -5		# $t0 = -5	
	lw	$t2, aa		# $t2 = a
	nop
	mul	$t0, $t0, $t2	# $t0 = -5a
	nop
	addiu	$sp, $sp, -4
	lw	$t0, ($sp)	# push -5a to stack
	nop

	
	li	$t0, -2		# $t0 = -2	
	lw	$t2, bb		# $t2 = b
	nop
	mul	$t0, $t0, $t2	# $t0 = -2b
	nop
	addiu	$sp, $sp, -4
	sw	$t0, ($sp)	# intermediate value = -2a on stack
	nop
	lw	$t0, ($sp)	# $t0 = -2a; 
	addiu	$sp, $sp, 4	# back off stack pointer
	lw	$t2, cc		# $t1 = c
	nop
	mul	$t0, $t0, $t2	# $t0 = -2bc
	nop
	addiu	$sp, $sp, -4
	sw	$t0, ($sp)	# push -2bc to stack
	nop
	

	li	$t0, 3		# $t0 = 3	
	lw	$t2, aa		# $t2 = a	
	nop
	mul	$t0, $t0, $t2	# $t0 = 3a
	nop
	addiu	$sp, $sp, -4
	sw	$t0, ($sp)	# intermediate value = 3a on stack
	nop
	lw	$t0, ($sp)	# $t0 = 3a; 
	addiu	$sp, $sp, 4	# back off stack pointer
	lw     	$t2, bb
	nop
	mul   $t0, $t0, $t2	# $t0 = 3ab
	nop
	addiu	$sp, $sp, -4
	sw	$t0, ($sp)	# push 3ab to stack
	nop

	# pop everything from Stack 
	lw	$t0, ($sp)	# $t0 = 3ab
	nop
	addiu	$sp, $sp, 4	# pop 3ab
	lw	$t2, ($sp)	# $t2 = -2bc
	nop
	addiu	$sp, $sp, 4	# pop 2bc
	add	$t0, $t0, $t2	# $t0 = 3ab - 2bc
	lw	$t2, ($sp)	# $t2 = 5a
	nop
	addiu	$sp, $sp, 4	
	add	$t0, $t0, $t2	# $t0 = 3ab - 2bc - 5a
	lw	$t2, ($sp)	# $t2 = 20ac
	nop
	addiu	$sp, $sp, 4
	add	$t0, $t0, $t2	# $t0 = 3ab - 2bc - 5a + 20ac
	lw	$t2, ($sp)
	nop
	addiu	$sp, $sp, 4
	add	$t0, $t0, $t2	# t0 = 3ab - 2bc - 5a + 20ac -16
	jr	$ra
	nop	
	

















