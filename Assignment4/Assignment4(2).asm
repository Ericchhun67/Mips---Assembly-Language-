#
# Assignment4.asm
#
# Eric Chhun
# 03/24/22
#
# assign4
# excerise2
#

        .data
string: .asciiz " in a hole in the ground there lived a hobbit "
nline:  .asciiz "\n"
        .text
        .globl main

main: 
        li      $v0, 4
        la      $a0, string # Print out the string message
        syscall
        li      $t0, ' ' # check for space
        la      $t1, string # store $t1 to string
        li      $t3, 1 # then store $t1 = $t3 to convert the char to uppercase
        li      $t4, 0x20 # offset to conert to upper case
        move    $v0, $t3
# connvert the strings 
convertstr:  
        lb      $t2, 0($t1) # get $t2 and store the characters one at time
        nop
        beqz    $t2, endit # then branch the string if it ends
        nop
        beq     $t2, $t0, handlestr  # look for space in the characters
        # then handle it
        nop
        bnez    $t3, toUpper # branch the string if flag is on
        nop
        addiu   $t1, $t1, 1 # then point to the next characters
        b	convertstr # test next characters
        nop
handlestr:
        li      $t3, 1 # set the first character
        addiu	$t1, $t1, 1 # let pointers points to the next characters
        b       convertstr
        nop
toUpper:
        li      $t3, 0
        sub     $t2, $t2, $t4 # now convert the string to lower case
        sb      $t2, ($t1) # then save the uppercase characters
        nop
        addiu	$t1, $t1, 1 
        # jump the to convert the string
        j	convertstr  
        nop
endit:
        la      $a0, nline # go to a new line
        li      $v0, 4 # print the newline
        syscall
        la      $a0, string # print new string after manipulation
        li      $v0, 4 
        syscall
quit:
        li      $v0, 10 # end the program
        syscall
# end of file


