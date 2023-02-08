#
# lab2.asm
# 
# Eric Chhun
# 09/21.22
# lab2 
#


        .text
        .globl main

main:
        li      $t0, 16
        li	$t1, 32   
        ori     $t0, $zero, 1
        sll     $t0, $zero, 1
        and     $t0, $t0, $t1
        or $t0, $t0, $t0


        # oxffffff
        ori     $t0, $zero, 0x01 
        srl     $t2, $t0, 24 
        nor	$t2, $t2, $t1
        addi    $t8, $0, 0x42
        addi	$t9, $0, -1 
        xor     $10, $t8, $t9

