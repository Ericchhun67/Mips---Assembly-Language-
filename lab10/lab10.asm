#
# Lab10.asm
#
# name
# 12/1/22
#
# lab10
# using an array of charaters by polling the inputs and outputs
# turn off delayed branches, and delayed loaded
# turn on mapped io, and Pseudo instructions.
#  
        .text
	.globl main


main:	
	jal	copy		# subroutine
        nop
	li	$t7, 0xffff0000	# set the base of memory-mapped io (receive control

loop:	
	lw	$t1, 0($t7)	# load word of the base of memory-mapped io area
	andi	$t1, $t1, 1	# mask off ready bit
	beqz	$t1, foundEndline	# if not set, branch to exR
        nop	
	lw	$t6, 4($t7)	# extract character (receive data) 		
	li	$t3, 0x73	# put 115 ('s') to register $t3
	beq	$t6, $t3, sort	# branch to sort if the character is 's' 
        nop	
	li	$t3, 0x74	# put 116 ('t') to register $t3
	beq	$t6, $t3, toggle	# branch to tog if the character is 't'	
        nop
	li	$t3, 0x61		# put 97 ('a') to register $t3
	beq	$t6, $t3, replace	# branch to arr if the character is 'a'	
        nop
	li	$t3, 0x72	# put 114 ('r') to register $t3
	beq	$t6, $t3, reverse	# branch to rev if the character is 'r'	
        nop
	li	$t3, 0x71	# put 113 ('q') to register $t3
	beq	$t6, $t3, quit	# branch to quit if the character is 'q'
        nop
	j	foundEndline
	nop
	
sort:	
	la	$t0, display	        # load address of display
	li	$t1, 0x0a	        # put 0x0a ('\n') to register $t1
	
sortLoop:	
	lb	$t2, 0($t0)	        # load the character at $t0
	beq	$t1, $t2, foundEndline	# branch to exR if $t2 = endline
        nop
	addiu	$t3, $t0, 1 	        # put the value of $t0 + 1 in $t3

sortStart:	
	lb	$t4, 0($t3)	        # load the charater at $t3
	beq	$t1, $t4, sortEnd	# if $t1 = $t4, branch to endS1
	bgt	$t4, $t2, sortEnd2	# check if $t4 < $t2 is true
        nop
	
	sb	$t4, 0($t0)	        # store the $t4 into $t0	
	sb	$t2, 0($t3)	        # store the $t3 into $t2
	addi	$t2, $t4, 0
	

sortEnd2:	
	addiu	$t3, $t3, 1	        # add 1 to advance to the next character
	j	sortStart		# jump to loopS1
        nop
	
sortEnd:	
	addiu	$t0, $t0, 1	# add 1 to advance to the next character
	j	sortLoop		# jump to loopS
        nop
	


toggle:	
	la	$t0, display	# load address of display
	li	$t1, 0x0a	# put 0x0a ('\n') to register $t1

toggleLoop:	
	lb	$t2, 0($t0)	# load the character at $t0
	beq	$t1, $t2, foundEndline	# branch $t2 is the endline character
	li	$t3, 65
	li	$t4, 91
	li	$t5, 97
	li	$t6, 123

	blt	$t2, $t3, toggleEnd
	blt	$t2, $t4, lower
	blt	$t2, $t5, toggleEnd
	bgt	$t2, $t6, toggleEnd
	addiu	$t2, $t2, -32
	sb	$t2, 0($t0)	# store the character at $t0
	j	toggleEnd		# jump to endT
	
lower:	addiu	$t2, $t2, 32	# add 32 to make the character lower-case
	sb	$t2, 0($t0)	# store the character at $t0

toggleEnd:	addiu	$t0, $t0, 1	# add 1 to advance to the next character
	j	toggleLoop		# jump to loopT

replace:	
	la	$t0, source	# move the address into $t0
	la	$t1, display	# move the address into $t1

loopA:	lb	$t2, 0($t0)	# load character of the string
	beqz	$t2, endCopy	# branch to exC if the character is null
	sb	$t2, 0($t1)	# store character of the string
	addiu	$t0, $t0, 1	# add 1 to advance to the next character
	addiu	$t1, $t1, 1	# add 1 to advance to the pointer of display

	j	loopA
	
exA:	sb	$t2, 0($t1)	# store null character
	j	foundEndline		# jump to exR
	


reverse:	
	la	$t0, display	# load address of display
	li	$t1, 0x0a	# put 0x0a ('\n') to register $t1

loopR:	lb	$t2, 0($t0)	# load the character at $t0
	beq	$t1, $t2, endR1# branch to loopR1 if $t1 is '\n'
	addiu	$t0, $t0, 1	# add 1 to advance to the next character

	j	loopR		# jump to loopR
	
endR1:	addiu	$t1, $t0, -1	# subtract from 1 to avoid to get '\n'
	la	$t0, display	# load address of display

loopR1:	
	sltu	$t2, $t0, $t1	# check if $t0 < $t1
	beqz	$t2, foundEndline
	lb	$t3, 0($t0)	# load the first character into $t2
	lb	$t4, 0($t1)	# load the last character into $t3
	sb	$t3, 0($t1)	# store the first character into $t1
	sb	$t4, 0($t0)	# store the last character into $t0
	addiu	$t0, $t0, 1	# add 1 to advance to the next character
	addiu	$t1, $t1, -1	# subtract 1 to get the previous character
	j	loopR1		# jump to loopR1
	

foundEndline:	la	$t0, display	# load address of display

loopP:	lw	$t1, 8($t7)	# extract transmitter control
	andi	$t1, $t1, 1	# mask off ready bit
	beqz	$t1, loopP	# if not set, branch to loopP	
	lb	$t2, 0($t0)	# load the character at $t0
	beqz	$t2, loop	# back to loop if no more characters to print
	sw	$t2, 12($t7)	# write character to display
	addiu	$t0, $t0, 1	# add 1 to advance to the next character
	j	loopP
        nop
	

copy:	la	$t0, source	# move the address into $t0
	la	$t1, display	# move the address into $t1

copyLoop:	

	lb	$t2, 0($t0)	# load character of the string
	beq	$t2, $zero, endCopy	# branch to exC if the character is null
	sb	$t2, 0($t1)	# store character of the string
	addiu	$t0, $t0, 1	# add 1 to advance to the next character
	addiu	$t1, $t1, 1	# add 1 to advance to the pointer of display
	j	copyLoop
        nop
	
endCopy:	
	sb	$t2, 0($t1)	# store null character
	jr	$ra
	

quit:	
	li	$v0, 10		# system call for end program
	syscall	

        .data
source:	.asciiz	"AbCdEfGhIjKf\n"
display:	.space	200
	