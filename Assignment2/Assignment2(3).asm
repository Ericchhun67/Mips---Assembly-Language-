#
# Assignment2.asm
#
# Eric Chhun
# 09/18/22
#
# Assignment2
# excerise3
#

	.text
	.globl	main

main:
	# excerise 3

	li	$t1, 0x7000 # load in 0x7000 into $t1
	sll	$t1, $t1, 16 # then shift left by 16
	addu	$t1, $t1, $t1 # then add $t1 to $t1

	li	$t2, 0x7000
	sll	$t2, $t2, 16
	addu	$t2, $t2, $t2

## End of File