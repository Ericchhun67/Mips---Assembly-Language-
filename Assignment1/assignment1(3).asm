#
# Assignment1.asm
#
# Eric Chhun
# 09/02/22
#
# Excerise 3
# using shift logical and register and register logic instructions
# 

        .text
        .globl  main


main:    # start from scratch
        ori     $t0, $zero, 0x01 # The goal is to get 0xFFFFFFFFFF
        srl     $t2, $t0, 24 # 100000000
        srl     $t2, $t2, 22
        srl     $t1, $t1, 12
        and     $t1, $t1, $t2
        and     $t1, $t2, $t2
        srl     $t2, $t1, 26
        and     $t2, $t2, $t1
        nor	$t2, $t2, $t1

       
       
 
# end of program
