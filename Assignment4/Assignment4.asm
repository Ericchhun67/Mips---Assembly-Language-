#
# Assignment4.asm
#
# Eric Chhun
# 10/12/22
#
# assign4
# Exercise1
#


         .data
string:  .asciiz " APPLEISBETTERTHANANDROID "
newline: .asciiz "\n"
dmes:   .asciiz "bye!" # done message
        .text
        .globl  main

main:
        li      $v0, 4 # print out messsage
        la      $a0, string # load message
        syscall
        la      $t0, string

# make the string to lower case characters
lcase:
        lb      $t1, ($t0) # get $t1 to store the characters to $t0
        lb      $t2, ($t0)
        move    $v0, $t1 # move to address of $t1
        nop
        # check if the string is lowercase
        beqz    $t1, endit # branch the string if it comes to an end
        nop
        nop
        addi	$t1, $t1, 0x20 # add ascii offset to convert it to lower case
        sb      $t1, ($t0)
        nop
        addiu	$t0, $t0, 1
        # jump branch the lower case
        j	lcase
        nop
endit:    
        li	$v0, 4 # print out the newline
        la      $a0, newline
        syscall
        li	$v0, 4
        la      $a0, string # print out the new string 
        syscall # print  out the string
# quit the program when done
quit:
        li      $v0, 4 # print out message
        la      $a0, dmes # load dmes
        syscall
        li      $v0, 4 # print out newline message
        la      $a0, newline
        syscall 
        li	$v0, 10
        syscall # end the program



## End of file




