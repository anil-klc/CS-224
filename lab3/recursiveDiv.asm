# CS224
# Lab 3
# Section 4 
# Anıl KILIÇ 
# 22203783
# 03.03.2024



.data

	divident: .asciiz "Divident value: "
	divisor: .asciiz "Divisorvalue: "
	quotient: .asciiz "Quotient: "
	remainder: .asciiz "Remainder: "
	newLine: .asciiz "\n"
	userPrompt: .asciiz "Do you want to continue? Y/N "
	yes: .asciiz "Y"
	userAnswer: .space 3



.text
	
	main:

		la $a0,divident
		li $v0,4
		syscall	
	

		li $v0,5
		syscall
	
		addi $s0, $v0, 0 
	
		la $a0,divisor
		li $v0,4
		syscall

		li $v0,5
		syscall
	
		# Divisior a1
		addi $a1, $v0, 0
	
		# Divident a0
		addi $a0, $s0, 0
	
		jal recursiveDivision

		addi $s0, $v0, 0
		addi $s1, $v1, 0

		la $a0, quotient
		li $v0,4
		syscall	
	
		li $v0, 1
		addi $a0, $s0, 0 		
		syscall

		la $a0, newLine
		li $v0,4
		syscall	

		la $a0, remainder
		li $v0,4
		syscall
	
		li $v0, 1
		addi $a0, $s1, 0 		
		syscall

		li $v0, 4
		la $a0, newLine
		syscall
		
		li $v0, 4
		la $a0, userPrompt
		syscall
		
		li $v0, 8
		la $a0, userAnswer
		li $a1, 3 
		syscall

		li $v0, 4
		la $a0, newLine
		syscall
		
		lb $s0, yes
		
		lb $s1, userAnswer
		
		beq $s0, $s1, main
			
		li $v0, 4
		la $a0, newLine
		syscall
		
		li $v0, 10
		syscall
	
	
	recursiveDivision:
	
		addi $sp, $sp, -8
		sw $ra, 0($sp)
		sw $a0, 4($sp) # divident

		
		slt $s1, $a0, $a1
		beq $s1, $zero, L1
		
		addi $v0, $zero, 0 # quotient
		addi $v1, $a0, 0 # remainder
		
		addi $sp, $sp, 8
		
		jr $ra
		
	L1:
	
		sub $a0, $a0, $a1
		
		jal recursiveDivision
		
		lw $ra, 0($sp)
		lw $a0, 4($sp) # divident

		addi $v0, $v0, 1 # quotient
		addi $v1, $v1, 0 # remainder
		
		addi $sp, $sp, 8
		
		jr $ra
		
		
	
	  
		




