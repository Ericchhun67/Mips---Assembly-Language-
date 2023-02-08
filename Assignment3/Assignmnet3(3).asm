#
# Assignmeent3.asm
#
# Eric Chhun
# 10/05/22
#
# Assign3
# excerise 3
#

	.text
	.globl main

main:
	li	$t0, 0	# let $t0 == 0 of the fibonacci series
	li	$t1, 1	# let $t1 == 1 of the fibonacci series
	li	$t2, 99 # let $t2 == 99 of the fibonacci series
	li	$t3, 0
	# loop untill it reaches to 99
loop:
	addu	$t1, $t1, $t0 # store the fibonacci series number
	subu	$t0, $t1, $t0 # we save the previous fibonacci series number
	sub	$t1, $t1, $t1 
	add	$t3, $t3, 1 # A loop counter
	add	$t2, $t2, 1 # A loop counter
	blt	$t3, $t2, loop # test condition
	nop
end:
	li	$v0, 10 # end the program
	syscall

# end the program

