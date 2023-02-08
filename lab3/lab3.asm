#
# lab3.asm
# 
# Eric Chhun
# 09/27/22
#
# lab3
# using loops and if statements in mips
# 
    	.text
	.globl main
main:
	ori 	$t0, $zero, 0	# puts 0 in $t0 to initialize a = 0
	ori 	$t1, $zero, 0	# puts 0 in $t1 to initialize b = 0
	ori 	$t2, $zero, 10	# counter register (variable)

 	# while loop
while:
	sub	$t3, $t2, $t0	# for comparison 
	blez	$t3, done	# $t3 < = 0
	nop
	addu	$t0, $t0, $t1	# increament 
	addu	$t1, $t1, $t0	# it is for the 'y'
	addiu	$t0, $t0, 1	# it is for the 'x'
	b	while
	nop
done:
	li	$v0, 10 # end of program
	syscall

	# do-while
	ori 	$t0, $zero, 0	# puts 0 in $t0
	ori 	$t1, $zero, 0	# puts 0 in $t1
dowhile:
	addu	$t1, $t1, $t0	# it is for the 'y'
	addiu	$t0, $t0, 1	# it is for the 'x'
	sub	$t3, $t2, $t0	# for comparison
	blez	$t3, done2	# exit control loop
	nop
	b	dowhile
	nop
done2:
	li	$v0, 10 # end of program
	syscall

	# for loop
	ori 	$t0, $zero, 0	# puts 0 in $t0
	ori 	$t1, $zero, 0	# puts 0 in $t1
for:
	sub	$t3, $t2, $t0	# for comparison 
	blez	$t3, end	# $t3 < = 0
	nop
	addu	$t1, $t1, $t0	# it is for the 'y'
	addiu	$t0, $t0, 1	# it is for the 'x'
	b	for
	nop
end: 
    	li  $v0, 10  # exit the program   
    	syscall     

	# if statement
	ori	$t0, $zero, 0 # initialize 0 into $t0 to initialize a = 0
	ori	$t1, $zero, 0 	# puts 0 in $t1 to initializeb = 0


	sub	$t1, $t0, $t1
	blez	$t0, end2
	nop
	ori	$t1, $zero, 10
end2:
	li	$v0, 10 
	syscall

	# if / else statment
	ori	$t0, $zero, 0 # initialize 0 into $t0 to initialize a = 0
	ori	$t1, $zero, 0 	# puts 0 in $t1 to initializeb = 0

	sub	$t1, $t0, 10
	blez	$t0, else
	nop
	ori	$t1, $zero, 10
else:
	ori	$t0, $zero, 0
end3:
	li	$v0, 10 # exit the program
	syscall

# end the program 




	

