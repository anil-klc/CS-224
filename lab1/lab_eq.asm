# CS224
# Lab 1 
# Section 4 
# Anıl KILIÇ 
# 22203783
# 23.02.2024

.data
	
	newLine: .asciiz "\n"
	prompt1: .asciiz "Provide variable a : "
	prompt2: .asciiz "Provide variable b : "
	prompt3: .asciiz "Division by zero error ! "
	prompt4: .asciiz "Answer is : "


.text

	main:
		
		jal userInput
		
		jal calculate
		
		addi $a0, $v0, 0 # quotient
		jal result
		
		li $v0, 10
		syscall
	
	userInput:
		
		li $v0, 4
		la $a0, prompt1
		syscall 
		
		li $v0, 5 
		syscall
		
		sw $v0, 0($sp)
		addi $sp, $sp, -4
		
		li $v0, 4
		la $a0, newLine
		syscall 

		li $v0, 4
		la $a0, prompt2
		syscall 
		
		li $v0, 5 
		syscall
		
		sw $v0, 0($sp)
		addi $sp, $sp, 4

		li $v0, 4
		la $a0, newLine
		syscall 
		
		jr $ra
		


	calculate:
	
		lw $t0, 0($sp) # a
		addi $sp, $sp, -4

		lw $t1, 0($sp) # b
		addi $sp, $sp, 4
		
		mult $t0, $t0
		
		mflo $t3 # a * a
		
		sub $t3, $t3, $t1  # a * a - b
		
		beq $t1, $zero, divByZero

		div $t3, $t1 # (a * a - b) / b
		
		mflo $t3 # quotient 
		
		div $t3, $t0
		
		mfhi $v0 # quotient 
		
		jr $ra

		
		
		
	result:
		
		addi $t0, $a0, 0 
		
		li $v0, 4
		la $a0, prompt4
		syscall
		
		li $v0, 1
		addi $a0, $t0, 0
		syscall
		
		li $v0, 4
		la $a0, newLine
		syscall 
		
		jr $ra


	divByZero:
		
		li $v0, 4
		la $a0, prompt3
		syscall 
		
		li $v0, 4
		la $a0, newLine
		syscall 
