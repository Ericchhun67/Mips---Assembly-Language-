 #
 # Assignment2.asm
 #
 # Eric Chhun
 # 09/20/22
 # 
 # assign2
 # excerise6 - #
# Assignment2.asm
# 
# Eric Chhun
# 02/16/22
#
# Assignment2
# excerise 6 - set Bare Machine OFF, Allow Pseudo Instructions ON, 
# Load Exception Handler OFF, Delayed Branches OFF, 
# Delayed Loads ON, Mapped IO OFF, Mapped IO OFF
# ev
#
        
        .data
x:      .word 1
y:      .word 0
result: .word 0

        .text
        .globl main
       
main:   
        lw      $t0, x # let $t0 == to x
        lw      $t1, y # let $t1 == y
        nop
        mult    $t0, $t1 # product x *y
        mflo    $t2
        nop
        sll     $t1, $t1, 1 # shift left by 2
        ori     $t3, $zero, 3 # $t3=3
        mult	$t2, $t3 # product $t3 to $t2
        nop
        mflo	$t2
        nop
        addu    $t2, $t2, $t0 
        sub     $t2, $t2, $t1
        addi    $t2, $t2, 2
        sll     $t3, $t3, 1  # shift left by 1
        mult    $t3, $t2
        nop
        mflo    $t3
        nop
        sw      $t3, result # store result into $t3





## End of file



