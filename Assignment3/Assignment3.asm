#
# Assignment3.asm
#
# Eric Chhun
# 10/05/22
#
# Assign3
# Excerse1
#

        .text
	.globl main
main:
	li  	$t0, 0 # set 0 into $t0, which will hold the sum
	li  	$t1, 1  # then load 1 into $t2, holds count
	li	$t2, 101 # end of sequence
# loop it to get the sum to 100
loop:
	addu	$t0, $t0, $t1 # add the counter to the sum
	addi	$t1, $t1, 1 # increment the counter to the sum
	# use a branch to get back to the loop
	blt	$t1, $t2, loop # counnter loop < 101
	nop
end:
	li	$v0, 10 # exit the program
	syscall 

# end of file



