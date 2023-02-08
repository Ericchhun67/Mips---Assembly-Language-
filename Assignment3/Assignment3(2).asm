#
# Assignment3.asm
#
# Eric Chhun
# 09/29/22
#
# Assign3
# excerise2
#
        
          
        .text
	.globl main
main:	# goal is to count from 1 to 100 by using a loop 
	li  	$t0, 0 # $t0 = loop the counter
	li	$t1, 0 # $t1 =0, holds the sum of the odd terms
	li	$t2, 0 # $t2 = 0 will hold all sum terms
	li	$t3, 1 # $t3 = 0, the loop counter 
	li	$t4, 101 # $t4 = 101 hold the end of the count

loop:
	add	$t1, $t1, $t3 # the sums all the odd term
	addu	$t2, $t2, $t3  # sum of the terms
	addi	$t3, $t3, 1 # loop the counter
	addu	$t2, $t2, $t3 # sum of all the terms
	addu	$t0, $t0, $t3
	addu	$t0, $t0, $t4
	addi	$t3, $t3, 1 # loop the counter
	blt	$t3, $t4, loop # check the while loop counter
	nop
end:
	li	$v0, 10 # exit the program
	syscall 

# end of file
