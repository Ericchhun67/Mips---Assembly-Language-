#
# FProject.asm
#
# Eric Chhun
# 12/1/22
#
# Finalproject
#
# using loops to handle interrupt until the user quit the program
# Enable mapped i/o, load exception handler and persudo for this to work.
# turning off load exception handler should still work. 
# turn off bare machine, delayed branches, delayed loads
#
	
	.data
source:	.asciiz "Apple phone's are better than Android \n"  
q:	.word 0				# for the quit flag
display: .space 200 # an array of 200 characters
flag:	.word 0

	.text
	.globl main

main:	
	# caller prolog
	addiu	$sp, $sp, -4		# push to the stack
	la	$t0, source		# load the address of 'source' in $t0
	sw	$t0, ($sp)		# push the address of 'source' to stack
        nop
	addiu	$sp, $sp, -4
	la	$t0, display		# load the address of 'display' in $t0
	sw	$t0, ($sp)		# push the address of 'display' to stack
	jal	copyarr
	nop
	# caller Epilog
	addiu	$sp, $sp, 8		# pop back the space on stack
	addiu	$sp, $sp, 8
	mfc0	$s0, $12		# Access the Status register
	move	$t0, $zero
	# Enable Interrupts 
	li      $s0, 3            	# loop counter
    	li	$s0, 0x801
	li	$s0, 0xC01		# to turn on the status register in kernel
	mtc0	$s0, $12		# mtc0 to talk to the kernel
	ori	$s0, $zero, 0x0c01	# Turn on bits 0, 10, and 11
	mtc0	$s0, $12		# Interrupts now enabled
	nop
	li	$s0, 2			# 2 is 10 in binary to set registers 
	sw	$s0, 0xffff0000		# enable interrupt for receiver control 
        nop
	sw	$s0, 0xffff0008		# enable interrupt for transmitter control 
    	nop
	li	$s1, 0
quitf:
	lw	$t0, q			# load boolean quit into $t0
	beqz	$t0, quitf		# if flag off loop to check again
        nop
	li	$v0, 10			# quit the program
	syscall
	# end of file
clear:  li      $v1, 0 # clear the flag if needed

# Subroutine for copying the 'source' to 'diplay' starts here 

copyarr:	
	addiu	$sp, $sp, -4		
	sw	$ra, ($sp)		# push caller's return address to stack
	addiu	$sp, $sp, -4
	sw	$fp, ($sp)		# push	caller's frame pointer to stack
	move	$fp, $sp		# $fp = $sp
	lw	$t0, 8($fp)		# load the address of the 'display' 
	lw	$t1, 12($fp)		# load the address of the 'source' 
	move	$fp, $sp		# No variables, $fp = $sp
chrcpy:	
	lb	$t2, ($t1)		# load a byte into register
	sb	$t2, ($t0)		# save it to the 'destination' 
	beqz	$t2, copied
        nop
	addiu	$t1, $t1, 1		# increment the source pointers 
	addiu	$t0, $t0, 1		# increment the display pointers
	lbu	$t2, 0($t0)		# Load ASCII from source 
	b	chrcpy
        nop
copied:	
	move	$sp, $fp		# $sp = $fp+ local variables
	lw	$fp, ($sp)		# load callers $fp
	addiu	$sp, $sp, 4		# pop callers $fp
	lw	$ra, ($sp)		# user's return address
	addiu	$sp, $sp, 4		# pop callres $ra
	jr	$ra			# return to subroutine
        nop
# Subroutine for copying the 'source' to 'diplay' ends here

# Kernel segment use started from here for the interrupt handler 
	.kdata
s_at:	.word 0
s_s0:	.word 0
s_t0:	.word 0
s_t1:	.word 0
s_t2:	.word 0
index:	.word 0
	.ktext 0x80000180		# kernel entry point
	.set noat
	move	$k0, $at		# save $at in a safe place
	.set at		
	sw	$k0, s_at
	sw	$s0, s_s0
	sw	$t0, s_t0
	sw	$t1, s_t1
	sw	$t2, s_t2	
	
	mfc0	$t0, $13		# extract the cause register
	andi	$t1, $t0, 0x400		# get the transmitter bit
	bnez	$t1, printit		# if trasmitter bit on, print the string
        nop
	nop
	andi	$t1, $t0, 0x800		# get the receiver bit
	bnez	$t1, getC		# if receiver bit on, get the command
        nop
iloop:  
	lw	$t0, ($a3)			# get receiver control
	nop
	andi	$t0, $t0, 1			# mask off ready bit
	beqz	$t0, printit		# if keyboard not ready to provide char, skip
	nop
	lw	$t1, 4($a3)		# extract char as word once ready
	nop
	li	$t2, 0x73			# ascii for s
	beq	$t1, $t2, s			# if char input is s prob jal
	nop
	li	$t2, 0x74			# ascii for t
	beq	$t1, $t2, t			# if char input is t
	nop
	li	$t2, 0x61			# ascii for a
	beq	$t1, $t2, a			# if char input is a
	nop
	li	$t2, 0x72			# ascii for r
	beq	$t1, $t2, r			# if char input is r
	nop
	li	$t2, 0x71			# ascii for q
	beq	$t1, $t2, q			# if char input is q
	nop
	j	printit			# otherwise skip because it's nonsense
	nop

	# if none of this is applicable end the proram
	b	endIt
printit:	
	lw	$t0, index
	lbu	$t1, display($t0)	# get the char to be displayed
	beqz	$t1, setInd
        nop
	sw	$t1, 0xffff000c         # print character
	addiu	$t0, $t0,1
	b 	doit
setInd:	
	li	$t0, 0	
doit:	
	sw	$t0, index
	b	endIt

getC:	
	li	$t2, 0xffff0004		# to get the entered data
	lb	$t0, ($t2)
	li	$t1, 'q'		# if entered char == 'q', exit
	beq	$t0, $t1, quit
        nop
	li	$t1, 's'		# if entered char == 's', sort
	beq	$t0, $t1, sort
        nop
	li	$t1, 't'		# if entered char == 't', toggle
	beq	$t0, $t1, toggle
        nop
	li	$t1, 'a'		# if entered char == 'a', replace
	beq	$t0, $t1, replace
        nop
	li	$t1, 'r'		# if entered char == 'r', reverse
	beq	$t0, $t1, reverse
        nop
	b	endIt
        nop
        nop

# 'a': replace display array elements with the source elements once again 
replace:
	li	$s0, '\n'
	la	$t0, source	
	la	$t1, display	
nxtch:	
	lb	$k0, ($t0)
	sb	$k0, ($t1)	
	beq	$k0, $s0, endIt
        nop 
	addiu	$t0, $t0, 1	
	addiu	$t1, $t1, 1	
	b	nxtch
        nop		
### 'r': reverse the elements in the display array (excluding the '\n')     
reverse:
	la	$s0, display		# load the address of 'display'
	la	$s1, display		# Point to the base of display
	li	$s2, 0x0a		# Load with '\n'
rCheck: 
	lb	$t0, ($s0)
	beqz	$t0, strtc		# loop to get to the end of the string
        nop
	addiu	$s0, $s0, 1		
	b	rCheck
strtc:	addiu	$s0, $s0, -2		# $s0=null now, but back of two places
	la	$t0, display
eachar:	
	ble	$s0, $t0, endIt		# check if indices have crossed or not
        nop
	lb	$t1, ($s0)		# load the bytes
	lb	$t2, ($t0)
	sb	$t1, ($t0)		# save them here 
	sb	$t2, ($s0)
	addiu	$t0, $t0, 1		# increement the pointers
	addiu	$s0, $s0, -1
	b	eachar
        nop
        nop
sort:   
        addiu   $sp, $sp, -4
        sw      $t0, 0($sp)             # push characters to the stack
        nop   
	la	$t0, display
	addiu	$t1, $t0, 1		# for the next character in the string
	li	$s0, '\n'
         
checkit:	
	lb	$k0, ($t0)
	lb	$k1, ($t1)
	beq	$k0,$s0, endIt		# check if $k0 ==newline , then end loop
        nop
	beq	$k1,$s0, iplus		# to increement the outer loop variable
        nop
	bgt	$k0, $k1, swap
        nop			
jplus:	
	addiu	$t1, $t1, 1
	b	checkit
        nop
iplus:	
	addiu	$t0, $t0, 1		# increement the loop variables
	addiu	$t1, $t0, 1
	b	checkit
        nop			
swap:	
	sb	$k0, ($t1)
	sb	$k1, ($t0)
	j	jplus
        nop
	
# 't': toggle the case of every alphabetic characters     
toggle:	
	la	$s0, display		# load the address of the display string	
        lb	$t0, ($s0)		# load the current character to $t0
toglch: 
	beqz	$t0, endIt		# if $t0==null stop processing the string
        nop
	li	$t1, 0x41		# $t1 = 'A'
	blt	$t0, $t1, gnext
        nop
	li	$t1, 0x5a		# $t1 = 'Z'
	ble	$t0, $t1, lower
        nop
	li	$t1, 0x61		# $t1 = 'a'
	blt	$t0, $t1, gnext
        nop
	li	$t1, 0x7a		# $t1 = 'z'
	ble	$t0, $t1, upper
        nop
lower:	
	addiu	$t0, $t0, 32
	b	gnext
        nop
upper:	
	addiu	$t0, $t0, -32
	b	gnext
        nop
store:	
	sb	$s7, 0($s0)		
gnext:	
	sb	$t0, ($s0)
	addiu	$s0, $s0,1
	lb	$t0, ($s0)		# load the current character to $t0
        addiu   $sp, $sp, -4
        sw      $t1, 4($sp)
        nop
	b	toglch
        nop	
# 'q': quit -- terminate program execution   
quit:
        lw      $t0, ($sp)
        addiu   $sp, $sp, -4
	li	$v0, 4 
        li	$t0, 1			# load $t0 with 1 to quit the program
	sw	$t0, q			# save to q 
        nop
	b	endIt
endIt:  
	lw	$t2, s_t2
	lw	$t1, s_t1
	lw	$t0, s_t0
	lw	$s0, s_s0
        lw	$k0, s_at
	.set	noat
	move	$at, $k0
	.set	at
	eret
# End of Interrupt handler 