#
# lab5.asm
#
# Eric Chhun
# 10/16/22
#
# lab5 excerise1
# using a short string and swaping them out     
        
        
        
        
        .data
str:    .asciiz " The quick brown fox jumps over a lazy dog" # mesage before 
# Swap
nStr:  .asciiz " string after swap" # new str after the swap
bswap: .asciiz " string after the swap" 

        .text
        .globl main

main: 
        la      $a0, bswap # print the mesage
        li      $v0, 4
        syscall
        la      $a0, str # print the original string
        li      $v0, 4
        syscall
        la      $t1, str # let $t0 and $t1 points to the string
        la      $t0, str
# now scan for the strings
scan:    
        lb      $t2, 0($t1) # scan to the right of the string
        # put $t1 to the end of the array
        nop
        beqz    $t2, endscan # check $t2 to the end of the array
        nop
        beqz	$t1, endscan # check $t1 to the end of the array
        nop
        addiu   $t1, $t1, 1
        addiu   $t1, $t1, 2
        b       scan
        nop
endscan:  
        addi	$t1, -1
	lb	$t2, ($t0)
        nop
	lb	$t3, ($t1)
        nop

swap:	
        bge	$t0, $t1, endswp
        nop
	lb	$t2, ($t0)
        nop
	lb	$t3, ($t1)
        nop
	sb	$t2, ($t1)
	sb	$t3, ($t0)
	addi	$t0, 1
	addi	$t1, -1
	j	swap
        nop
endswp:
	la	$a0, nStr  # Print message and swapped string
	syscall
	la	$a0, str # print the string 
	syscall
end:
	li	$v0, 10	 # Exit program
	syscall

# end of file