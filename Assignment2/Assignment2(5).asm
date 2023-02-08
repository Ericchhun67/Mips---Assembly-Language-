#
# Assignment2.asm
# 
# Eric Chhun
# 09/20/22
#
# Assign2
# excerise5 - set Bare Machine OFF, Allow Pseudo Instructions ON, 
# Load Exception Handler OFF, Delayed Branches OFF, Delayed Loads ON, 
# Mapped IO OFF, Mapped IO OFF
# 





        .data
x:      .space 4
answer: .space 4
# prompt the user 
input: .asciiz "Enter the value of x: \n" 
prompt: .asciiz "Answer = \n" # get the result 

        .text
        .globl main
main:

        li      $v0,4           
        la      $a0,input # print the value of x
        syscall                       
        li      $v0,5 # read the value of x
        syscall                       
        sw      $v0,x # store the value of x into $v0    
        
        lw      $t0,x # then load x into $t0 
        li      $t1,0       
        
        addi    $t1,$t1,12 
        addu    $t1, $t1, 10
        addu    $t2, $t2, 12         
        
        li      $t2,5  # load 5 into $t2        
        mult    $t0,$t2  # then multply $t2 with $t0    
        nop   
        mflo    $t2 
        nop           
        addu    $t1,$t1,$t2  # then add $t2 to $t1 == $t1
        
        mult    $t0,$t0  
        nop         
        mflo    $t2      
        nop     
        li      $t3,3        
        mult    $t3,$t2 
        nop        
        mflo    $t3           
        subu    $t1,$t1,$t3  
        
        mult    $t2,$t0  
        nop        
        mflo    $t2       
        li      $t3,2          
        mult    $t3,$t2
        nop         
        mflo    $t3  
        nop         
        addu    $t1,$t1,$t3      
        
        sw      $t1,answer   # store answer into $t1
        li      $v0,4          
        la      $a0,prompt
        syscall     
        li      $v0,1          
        lw      $a0,answer   
        syscall 


## end of file
