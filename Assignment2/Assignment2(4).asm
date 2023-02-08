#
# Assignment2.asm
#
# Eric Chhun
# 09/18/22
# 
# Assignment2
# excerise4
#

	.text
	.globl main

main:
	ori	$t0, $zero, 0x186A # put 0x186A in to $t0
	sll	$t0, $t0, 8 # sift to the left 8 place
	ori	$t1, $zero, 0x1388 # then put 0x1388 in to $t1
	sll	$t1, $t1, 4 # then shift to the left 4 place
	ori	$t2, $zero, 0x61A8 # put 0x61A8 in to $t2
	sll	$t2, $t2, 4 # then shift to the left 4 place
	div	$t0, $t2 # div $t0 into $t2
	mflo	$t3
	nop
	nop
	mult	$t3, $t1 # multiply #t3 to $t1
	nop	
	mflo	$t4
	nop

# end of file

	