#
# Assignment4.asm
#
# Eric Chhun
# 03/28/22
#
# Assignment4
# excerise3 
        
        
        .data
string: .asciiz " in a hole in the ground there lived a hobbit "
nline:  .asciiz "\n"
        .text
        .globl main

main: 
        li      $v0, 4
        la      $a0, string # Print out the string message
        syscall
        li      $t0, ' ' # check if for space
        la      $t1, string # store $t1 to string
        li      $t3, 1 # then store $t1 == $t3 to convert the char to uppercase
        li      $t4, 0x20 # offset to conert to upper case
        li      $t5, 91 # the ascii upper case characters ends at 91
        move    $v0, $t3 

convertstr:  
        lb      $t2, 0($t1) # get $t2 and store the characters one at time
        nop
        beqz    $t2, end # then branch the string if it ends
        nop
        beq     $t2, $t0, handlestr  # look for space in the characters
        # then handle it
        nop
        bnez    $t3, Upperc # branch the string if flag is on
        nop
        addiu   $t1, $t1, 1 # then point to the next characters
        b	convertstr # test next characters
        nop
handlestr:
        li      $t3, 1 # set the first character
        addiu	$t1, $t1, 1 # let pointers points to the next characters
        add     $t1, $t1, 2
        b       convertstr
        nop
# get string to uppercase
Upperc:
        li      $t3, 0
        sub     $t2, $t2, $t4 # now convert the string to lower case
        sb      $t2, ($t1) # then save the uppercase characters
        nop
        addiu	$t1, $t1, 1 
        move    $v0, $t3
        # jump the to convert the string
        j	convertstr  
        nop
nextstr:   
        sb      $t2, 0($t1) # save the byte
        nop
        addiu	$t1, $t1, 1     # then  point it to the next character
        li      $t3, 0
        j       convertstr
        nop
end:
        la      $a0, nline # go to a new line
        li      $v0, 4 # print the newline
        syscall
        la      $a0, string # print new string after manipulation
        li      $v0, 4 
        syscall
        li      $v0, 10 # end the program
        syscall

# end of file




