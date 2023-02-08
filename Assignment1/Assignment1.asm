#
# Assignment1.asm
#
# Eric Chhun
# 09/02/22
#
# Excerise 1
# using shift logical register logic instructions
# 


        .text
        .globl main



main: # start  from scratch 
        # ori     $t0, $zero, 0x01 # the goal is to get 0xAAAAAAAA
        # # start by puting single one-bit into register 8
        # sll     $9, $8, 1
        # sll     $9, $8, 2
        # sll     $9, $8, 26
        # or      $9, $8, $9
        # sll     $8, $9, 22
        # or	$9, $8, $9
        # or      $9, $8, $9
        # sll     $9, $9, 16
        # sll     $9, $8, 10
        # and     $9, $8, $9




        ori     $t0,    $0, 0x01 # start from scratch
        # the goal is to get 0xAAAAAAAA
        sll     $t1,    $t0, 2 # let $t0 == $t1 and sll by 2
        or      $t2,    $t1, $t0
        sll     $t2,    $t1, $t0
            


# End of file
