.data 
	operator: .ascii "   "
	mult_sign: .ascii "*"
	
	num1: .asciiz "Please enter the first operand: " 
	num2: .asciiz "Please enter the second operand: " 
	operation: .asciiz "\nPlease enter the operation (*, /): "
	colon: .asciiz ": "
	product: .asciiz "product="
	
	quotient: .asciiz "quotient="
	semi: .asciiz "; "
	remainder: .asciiz "remainder="
	err: .asciiz "\nInvalid: Division by 0."
	msign: .asciiz "*"
	dsign: .asciiz "/"
	

.text
        la $a0, num1
        li $v0,4
        syscall
	li $v0, 5              
	syscall
	add $t6, $0, $v0   # multiplicand/dividend
	la $a0, num2
	li $v0, 4
	syscall
	li $v0, 5             
	syscall
	add $t2, $0, $v0       #multiplier/divisor
	la $a0, operation
	li $v0, 4
	syscall
	
	#add $s4, $0, $a0
	la $a0, operator
	li $a1, 3
	li $v0, 8
	syscall
	
	
	la $s2, operator
	lbu $t4, 0($s2)
	
	la $t9, msign
	lbu $t5, 0($t9)
	
	la $s5, dsign
	lbu $s6, 0($s5)
	
	
	addi $t1, $0, 32
	
	add $s4, $0, $t2
	add $a3, $0, $t6
	beq $t4, $t5, do_mult
	
	
	j do_div
	
	
.globl main

main: 
	
	error:
		la $a0, err
        	li $v0,4
        	syscall
        	j end
	
	do_div:
	       beq $t2, $0, error
	       
	       li $t0, 0x80000000
	     
	       and $t0, $t0, $t6
	       sll $s3, $s3, 1
	       sll $t6, $t6, 1
	       srl $t0, $t0, 31
	       add $s3, $s3, $t0
	       
	       loop:
	       	    addi $t1, $t1, -1
	       	    
	       	    sub $s3, $s3, $t2
	       	    slt $t9, $s3, $0
	       	    bne $t9, $s3, restore
	       	    
	       	    li $t0, 0x80000000
	       	    and $t0, $t0, $t6
	            sll $s3, $s3, 1
	            sll $t6, $t6, 1
	            srl $t0, $t0, 31
	            add $s3, $s3, $t0
	            
	            ori $t6, $t6, 0x0001
	            beq $t1, $0, exit
	            j loop
	       	    
	       	    restore:
	       	    	add $s3, $s3, $t2
	       	    	
	       	       li $t0, 0x80000000
	               and $t0, $t0, $t6
	               sll $s3, $s3, 1
	               sll $t6, $t6, 1
	               srl $t0, $t0, 31
	               add $s3, $s3, $t0
	               
	               beq $t1, $0, exit
	               j loop
			
	
	
	
	do_mult:
		
		li $t0, 0x00000001 
		and $t0, $t0, $t2
		beq $t0, $0, loop2
		add $s3, $s3, $t6
		
	 	
	  loop2:
	  	
	  	li $s7, 0x00000001
		and $s7, $s7, $s3 
		srl $s3, $s3, 1 
		srl $t2, $t2, 1 
		sll $s7, $s7, 31 
		add $t2, $s7, $t2
	 	
	 addi $t1, $t1, -1
	 beq $t1, $0, exit2
	 j do_mult
	 	
	 	
	 	
	 	
	 exit:
	 	add $a0, $a3, $zero  
        	li $v0, 1  
        	syscall
        	la $a0, dsign
        	li $v0,4
        	syscall
        	add $a0, $s4, $zero  
        	li $v0, 1  
        	syscall
        	la $a0, colon
        	li $v0,4
        	syscall
        	la $a0, quotient
        	li $v0,4
        	syscall
        	add $a0, $0, $t6
		li $v0, 1
		syscall
		la $a0, semi
        	li $v0,4
        	syscall
		la $a0, remainder
        	li $v0,4
        	syscall
        	add $a0, $0, $s3
		li $v0, 1
		syscall
        	j end
        	
	 	
	 exit2:
	 	add $a0, $t6, $zero  
        	li $v0, 1  
        	syscall
        	la $a0, msign
        	li $v0,4
        	syscall
        	add $a0, $s4, $zero  
        	li $v0, 1  
        	syscall
        	la $a0, colon
        	li $v0,4
        	syscall
        	la $a0, product
        	li $v0,4
        	syscall
        	add $a0, $0, $t2
		li $v0, 1
		syscall
		
	 
	 end:
	 	li $v0, 10
	        syscall
	 	
		
		
		
		
	
	
