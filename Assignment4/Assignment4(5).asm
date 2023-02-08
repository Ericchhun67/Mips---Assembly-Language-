#
# Assignment4.asm
#
# Eric Chhun
# 
#
# Assignment4
# Excerise5
# prompt the user for the array and find the min and the max values using 
# arrays
#  
                .data
array:          .space 40
prompt:         .asciiz "Enter a number"
min:            .asciiz "smallest"
max:            .asciiz "largest"
nline:          .asciiz "\n"

                .text
                .globl main
main:
        la      $t0, array # let $t0 point to an array
        li      $t1, 0 # then counter for index
        li	$t2, 10 # The max index for the array
     
# get the number entr by the user
getNum:
        beq     $t1, $t2, nextline # let branch stop reading if the counter is
        # at max index
        nop
        li      $v0, 4 # print the prompt message
        la      $a0, prompt
        syscall
        li      $v0, 5 # get the number
        syscall
        sw      $v0, ($t0) # then, store number to the array  
        nop
        addiu	$t1, $t1, 1 # increment the counter  
        addiu	$t0, $t0, 4 # increase pointer up to 4 bytes to the next counter
        addu    $t1, $t1, 5
        # number
        b       getNum  # repeat until the counter is == 10
        nop
# next, find the maximum and minimum in the array
nextline:
        la      $t0, array      # $t0 is the pointer to array[0] for searching
        li      $t1, 0  # counter for index
        lw      $t3, ($t0) # initialized  min with array[0]
        lw      $t4, ($t0) # initialized max with array[0]
        addiu   $t1, $t1, 1  
        addiu   $t0, $t0, 4 # pointer will point to the next element of the array

searching:
        # use a branch to search for the array
        beq     $t1, $t2, endit # end with traversing through the array
        nop
        lw      $t5, ($t5) # $t5 will now contain the value in the address
        # $t0

        # use a branch to search the min
        blt     $t5, $t3, smallest # if array[element] < min, then branch to 
        # smallest number
        nop
        bgt	$t5, $t3,  biggest # if array[element] > max, then branch to 
        # the biggest number of the element
        nop
        addi    $t1, $t1, 1 # increament the counter  by 1 
        addi    $t0, $t0, 4 # then, the pointer will point to the next element
        j       searching
        nop
smallest:
        or      $t3, $t5, $zero # set $t3 == $t0 if $t3 > $t4
        addiu   $t1, $t1, 1
        addiu   $t0, $t0, 4 # pointers points to next elmement in array
        j       searching
        nop
biggest:
        or      $t4, $t5, $zero # set $t4 == $t0 if $t4
        addiu   $t1, $t1, 1
        addiu   $t0, $t0, 4     # pointer points to the next elmement in array
        addu    $t1, $t1, $t1
        j       searching
        nop
endit:
        li     $v0, 4
        la      $a0, min
        syscall
        or	$a0, $t3, $zero
        li      $v0, 1
        syscall

        li      $t0, 4
        la      $a0, max
        syscall
        or      $a0, $t4, $zero
        li      $v0, 1
        syscall
quit:
        li      $v0, 10 # exit the program
        syscall
# end of file




