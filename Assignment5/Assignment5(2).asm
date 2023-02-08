 # 
 # Assignment6.asm
 # 
 # Eric Chhun
 # 04/19/22
 #
 # Assignment6
 # excerise2
 #
        .data
pmt: .asciiz " Enter the number: \n"
result: .asciiz " The factorial number is: \n"
       
       
       .text
       .globl main


# A factorial function
fact:
        li      $t0, 1 # let $t0 == 1
        multu	$a0, $t0
        mflo    $v0
        jr	$ra     # return address
        nop

main: 
        li	$v0, 4 # print the prompt
        la	$a0, pmt # read the prompt
        syscall

        li	$v0, 5 # read the number 
        syscall
        move    $a0, $v0 # move number to $a0
        nop

        jal     fact # call factorial function
        nop

        li      $v0, 4 # print the result
        la      $a0, result
        syscall

        li      $v0, 1 # print out the result from the factorial function
        move    $a0, $v0
        nop
        syscall

        li      $v0, 1 print factorial
        move    $a0, $v0
        nop
        syscall
quit: 
        li      $v0, 10 # exit the program
        syscall

# end of file














