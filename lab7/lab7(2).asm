#
# lab7(2).asm
#
# Eric Chhun
# 11/7/22
#
# lab7 excerise 2
# letting the user prompt for a string and finding and comparing strings
# Turn off Bare Machine 
#
	
	
	.data
# prompt the user for a string
prompt:	.asciiz "Enter a string : "
str:	.space 100 # hold the size 
	.text
	.globl main
main:
	# get string from user
	la	$a0, prompt		# load prompt
	li 	$v0, 4			# prompt user
	syscall
	la	$a0, str		# load input address
	li	$a1, 100		# size of string
	li	$v0, 8			# read in string
	syscall

	# find end of string
	la	$s0, str		# load address of input
	la	$s1, str
	sw 	$s2, ($sp)
	addiu	$sp, $sp, -1 
	move 	$s0, $s1
	nop
fstr:	
	lb	$s2, ($s1)
	nop
	sb	$s2, ($sp)
	beqz	$s2, strf
	addi	$s1, $s1, 1		# advance ptr of input
	bnez	$s2, fstr		# continue loop if not at end
	nop
strf:
	addi	$s1, $s1, -1		# backup ptr off NULL
	addiu	$sp, $sp, -1		# move stack pointer up 
	sb	$zero, ($sp)		# push null on top
	nop
	addiu	$sp, $sp, -1 

	# compare chars to aeiou
comparev: 
	lbu	$t0, ($s1)		# load the byte into $t0
	nop	
	li	$t1, 'a'		# is $t0 == 'a' ?
	beq	$t0, $t1, skip
	nop
	li	$t1, 'e'		# is $t0 == 'e' ?
	beq	$t0, $t1, skip
	nop
	li	$t1, 'i'		# is $t0 == 'i' ? 
	beq	$t0, $t1, skip
	nop
	li	$t1, 'o'		# is $t0 == 'o' ?
	beq	$t0, $t1, skip
	nop
	li	$t1, 'u'		# is $t0 == 'u' ?
	beq	$t0, $t1, skip
	nop

        # push if not vowel else we skip it
	addiu	$sp, $sp, -1
	sb	$t0, ($sp)
	nop
	lb	$t1, ($sp)
	nop

	#  move to the next char
skip:
	beq	$s0, $s1, popIt		
	nop
	addiu	$s1, $s1, -1		# if we have not crossed the prt
	j	comparev		# keep on comparing if it is a vowel or not 
	nop

	# pop everything and store in buffer
popIt:
	lbu	$t0, ($sp)		# get the top element
	nop
	addiu	$sp, $sp, 1		# move the stack ptr
	sb	$t0, ($s0)		# store the character at $s0
	nop
	beqz	$t0, done		# if just encountered null, then finished reading
	nop		
	addiu	$s0, $s0, 1		# move the ptr to next location 
	j	popIt			# repeat untill done 
	nop

	# print	
done:	
	li	$v0, 4
	la	$a0, str
	syscall
	li	$v0, 10 # exit the program
	syscall
# end of file