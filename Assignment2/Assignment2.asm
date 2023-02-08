#
# Assignment2.asm
# 
# Eric Chhun
# 09/18/22
#
# Assignment2
# excerise1 - set Bare Machine OFF, Allow Pseudo Instructions ON, 
# Load Exception Handler OFF, Delayed Branches OFF, 
# Delayed Loads ON, Mapped IO OFF, Mapped IO OFF
#


 	.text
	.globl main

main:	
	li 	$t0, 456 	# $t0 = 456
	li 	$t1, -229  	# load $t1 into -229
	li 	$t2, 325   	# $t2 = 325
	li 	$t3, -552  	# $t3 = -552
	add 	$t0, $t0, $t1   # $t0 = $t0 + $t1
	add 	$t0, $t0, $t2   # $t0 = $t0 + $t2
	add 	$t0, $t0, $t3   # $t0 = $t0 + $t3












