.data
	prompt: .asciiz "Number to square: "
	secondprompt: .asciiz "\nSquare: "
	
.text
.globl main
main:
	
	# Your code here
	li $v0,4                #display prompt
	la $a0, prompt
	syscall
	li $v0, 5                 #input number to square
	syscall 
	add $s0, $zero, $v0
	li $v0, 4                 
	la $a0, secondprompt       #display secondprompt
	syscall
	
	add $a0, $zero, $s0
	jal squareIt                #go to function squareIt
	 
	add $a0, $v0, $zero
	li $v0, 1
	syscall
	
	# Exit
	li $v0, 10
	syscall

	
	squareIt:        
	add $t0, $a0, $zero         #$t0 = $a0
	slt $t4, $t0, $0
	
	bne $t4, $0, positive
	add $t2, $zero, $a0      #$t2 will be used to compare $s1 with
	addi $t1, $0, 1            #$t1 will be the counter
	Loop:
	beq $t1, $t2, fin
	add $t0, $t0, $t2
	addi $t1, $t1, 1
	j Loop
	  
	positive:
	sub $t0, $0, $t0  
	add $t2, $zero, $t0      #$t2 will be used to compare $s1 with
	addi $t1, $0, 1     
	j Loop 		
	
	
	fin:
	add $v0, $zero, $t0         #$t0 to $v0
	jr $ra                     #jump to return addres
	
	
	
	
