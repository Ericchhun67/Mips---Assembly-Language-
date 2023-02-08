#
# Assignment2.asm
# 
# Eric Chhun
# 09/18/22
#
# Assignment2
# excerise 2 - set Bare Machine OFF, Allow Pseudo Instructions ON, 
# Load Exception Handler OFF, Delayed Branches OFF, 
# Delayed Loads ON, Mapped IO OFF, Mapped IO OFF
#

	
	
	
	.text
        .globl main
main:
# excerise 2
	li 	$t0, 0x0 # 1 instruction
	add	$t0, $t0, 0x1000
	add	$t0, $t0, 0x1000
	add	$t0, $t0, 0x1000
	add	$t0, $t0, 0x1000
	add	$t0, $t0, 0x1000
	add	$t0, $t0, 0x1000
	add	$t0, $t0, 0x1000
	add	$t0, $t0, 0x1000
	add	$t0, $t0, 0x1000
	add	$t0, $t0, 0x1000
	add	$t0, $t0, 0x1000
	add	$t0, $t0, 0x1000
	add	$t0, $t0, 0x1000
	add	$t0, $t0, 0x1000
	add	$t0, $t0, 0x1000
	add	$t0, $t0, 0x1000

	li	$t1, 0x1000
	sll	$t1, $t1, 4

	li 	$t2, 0x1000
	add	$t2, $t2, $t2
	add	$t2, $t2, $t2 
	add	$t2, $t2, $t2 
	add	$t2, $t2, $t2