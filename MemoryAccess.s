.data
	a: .word 1, 6, 3, 8, 2, 7
	prompt: .asciiz "Value at index 5 before modification: “
	secondprompt: .asciiz "\nValue at index 5 after modification: “
	
.text
.globl main
main:
	# Your code here
	
	li $v0, 4 # display prompt
	la $a0, prompt 
	syscall         
	la $t3, a    #add base address of a to $t3
	addi $t4, $t3, 20 #add &A[5] to $t4 by adding 20 to base address
        lw $t1, 0($t4) #load A[5] to $t1
	add $a0, $t1, $zero #add a[5] in $a0 before modification
	li $v0, 1          #print a[5]
	syscall 
        
        lw $t6, 0($t3)
        lw $t5, 12($t3) #load a[3] to $t5
        add $t7, $t5, $t6 #add a[3] and a{0]
        sw $t7, 0($t4) #store a[3] + a[0] to a[5] or $t4
        lw $s3, 0($t4) #load a[5] to $s3
        
        li $v0, 4   #display the second prompt
        la $a0, secondprompt
        syscall
        add $a0, $s3, $zero  # add new value of a[5] to $v0
        li $v0, 1  #display a[5] after modification
        syscall
        
        
	# Exit
	li $v0, 10
	syscall
	
        
        
        
        
