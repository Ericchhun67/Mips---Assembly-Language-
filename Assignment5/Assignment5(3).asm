# 
# assignment5.asm     
#  
# Eric Chhun
# 04/25/22
#   
# excerise 3
#       
        .text
        .globl main



main:
                                        
        sub     $sp,$sp,4        
        sw      $ra,($sp)
        sub     $sp,$sp,4        
        sw      $fp,($sp)
        nop
        nop
                                  
        sub     $fp,$sp,8        
        move    $sp,$fp          
        nop
        nop
                  
        li     $v0,4             #   print string service
        la     $a0, prompt       #   address of prompt
        syscall
                                
        li     $v0,5             
        syscall                  
        sw     $v0,0($fp)        
        nop
        nop
                                                  
        lw      $a0,0($fp)       
        jal     infact              
        nop
        nop
         
                                 
                                  
        sw     $v0,4($fp)        
                               
        li     $v0,4             #   print string service
        la     $a0, result       #   address of prompt
        syscall
                                 
        lw     $a0,4($fp)        
        li     $v0,1             # print integer service
        syscall                                  


                                      
        add     $sp,$fp,8             
                                     
        lw      $fp,($sp)        
        add     $sp,$sp,4       
        lw      $ra,($sp)        
        add     $sp,$sp,4                                         
        jr      $ra              # return to OS 
        nop
        nop

infact:                                  
        sub     $sp,$sp,4       
        sw      $ra,($sp)
        sub     $sp,$sp,4    
        sw      $fp,($sp)
        sub     $sp,$sp,4        
        sw      $s1,($sp)
        sub     $fp,$sp,0        
        move    $sp,$fp         
                                   
        move    $s1,$a0        
        li      $t1,1            
        bgt     $s1,$t1,recurse  
        nop
        nop
        li      $v0,1          
        b       epilog    

recurse:                                                       
        sub     $a0,$s1,1                                 
        jal     infact         
        nop
        nop

        addu     $v0,$v0,$s1     
                            
epilog:                           
                                    
        add     $sp,$fp,0       
        lw      $s1,($sp)       
        add     $sp,$sp,4             
        lw      $fp,($sp)       
        add     $sp,$sp,4               
        lw      $ra,($sp)        
        add     $sp,$sp,4        
        addu	$t3, $t0, $t1        
        jr      $ra              #   6. return to caller
quit:
        li      $v0, 10 #exit the program
        syscall

        .data
size:   .word   17
array:  .word  12, -1, 8, 0, 6, 85, -74, 23, 99, -30, 30, 95, 4, 7, 10, 28, -14
prompt: .asciiz  " Enter number "
result: .asciiz " f is "
