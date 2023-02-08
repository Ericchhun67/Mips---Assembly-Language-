#
# Assignment4.asm
#
# Eric Chhun
# 10/10/22
#
# excerise 4
# Enter a string and convert it to uppercase
#
	
	
	
	.data
string:	.space 81
prompt: .asciiz "Enter a string \n"
dmes:	.asciiz "bye!" # done message
	.text
	.globl main

main:	
	la	$a0, prompt	# load the prompt
     	li	$v0, 4		# print the message (prompt)
	syscall
	li	$v0, 8		# read string from user
	la	$a0, string	# load the address to store string 
	syscall	
	li 	$t0, 0x20	# offset to convert to upper case
	la	$t1, string	# $t1 points to the string
	li	$t3, 91		# the ascii upper case chars end at 91
	li	$t4, ' '	# to check if we have space
	li	$t5, '\n'	# then add a newline
	move	$v0, $t0
	
convertstr:
	lb	$t2, 0($t1)	# $t2 stores character at time
	nop
	beq	$t2, $t5, done	# branch if we got to end of string
	nop
	beq	$t2, $t4, handle # if we have space we handle it
	nop
	blt	$t2, $t3, lowerc # if we have space we handle it
	nop
	bgt	$t2, $t3,upperc # branch if we have flag set on
	nop			
	b	convertstr 	# test next char
	nop	

handle:	
	addi	$t1, $t1, 1	# pointer points to next char
	addu	$t0, $t1, $t1
	b	convertstr	# test next char
	nop

upperc:
	sub	$t2, $t2, $t0	# convert to the uppercase
	sb	$t2, ($t1)	# save the upper case char
	nop
	addi	$t1, $t1, 1
	j	convertstr
	nop

lowerc:
	add	$t2, $t2, $t0	# convert to the lowercase
	sb	$t2, ($t1)	# save the lower case char
	nop
	addi	$t1, $t1, 1
	add	$t1, $t1, $t0
	j	convertstr
	nop
done:	
	la	$a0, string	# load the address to store string 
	li	$v0, 4		# read string from user
	syscall
quit:	
	li	$v0, 10 # exit the program
	syscall

# end of file