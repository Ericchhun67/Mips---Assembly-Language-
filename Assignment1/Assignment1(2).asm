#
# Assignment1.asm
#
# Eric Chhun
# 09/02/22
#
# Excerise 2
# using shift logical and register and register logic instructions
# 

        
        
        .text
        .globl main

main: 
        ori     $t0, $zero, 0x01 # start from one bit again
        sll	$t1, $t0,  1 # 0010
        sll     $t2, $t0,  2 # 0100
        or      $t3, $t1,  $t2
        sll     $t1, $t0,  4
        sll     $t2, $t0,  7
        or      $t2, $t1,  $t2
        or      $t1, $t2,  $t3
        sll     $t1, $t1,  8
        or      $t1, $t1,  $t2
        sll     $t2, $t1,  16
        or      $t1, $t1,  $t2 # 0x96969696

## end of file