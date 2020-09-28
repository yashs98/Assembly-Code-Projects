.data
	prompt: .asciiz "Number of squares to sum: "
	secondprompt: .asciiz "\nSum of the first n squares: "
	
	
.text
.globl main
main:
	
	# Your code here
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
	jal sumSquare                #go to function squareIt 
	add $a0, $v0, $zero
	li $v0, 1
	syscall
	
	# Exit
	li $v0, 10
	syscall
	
	
	sumSquare:
	addi $sp, $sp, -4        #allocate space in stack
	sw $ra, 0($sp)           
	li $t6, 0                   
	add $t4, $zero, $a0        #parameter goes to $t4
	addi $t5, $zero, 1         # t5 is the counter
	addi $t4, $t4, 1
	Loop2: 
	beq $t5, $t4, fin2
	addi $a1, $t5, 0            # $a1 will contain the input for squareIt 
	jal squareIt              #calling squareIt
	add $t6, $t6, $v0          #add result from squareIt to $t7
	addi $t5, $t5, 1            # $t5++
	add $v0, $0, $t6 
	j Loop2
        
	fin2:
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra
	
	squareIt:        
	add $t0, $a1, $zero         #$t0 = $a1
	add $t2, $zero, $a1      #$t2 will be used to compare $s1 with
	addi $t1, $0, 1            #$t1 will be the counter
	Loop:
	beq $t1, $t2, fin
	add $t0, $t0, $a1 
	addi $t1, $t1, 1
	j Loop
	
	fin:
	add $v0, $zero, $t0         #$t0 to $v0
	jr $ra                     #jump to return addres
