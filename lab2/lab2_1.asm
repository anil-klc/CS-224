# CS224
# Lab 2
# Section 4 
# Anıl KILIÇ 
# 22203783
# 25.02.2024

.data
	
	userInput: .space 100 
	newLine: .asciiz "\n-------\n"
	userPrompt: .asciiz "Do you want to continue? Y/N "
	userAnswer: .space 3
	yes: .asciiz "Y"

.text
	main:
		addi $s1, $s1, 0 # for string length
		addi $s2, $s2, 0 # decimal value 
		addi $s3, $s3, 0 # traversing 
		
		addi $t5, $t5, -1 # traversing 
		
		li $v0, 8
		la $a0, userInput
		li $a1, 100 # allocating 100 byte 
		syscall
	
		jal gettingLength
		
		addi $s1, $s1, -1 # since 1 charecter is for null-terminating char
		
		addi $a0, $s1, 0 		
		jal ascii2dec
		
		li $v0, 1
		addi $a0, $s2, 0
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
		
		lb $t0, yes
		
		lb $t1, userAnswer
		
		beq $t0, $t1, main
				
		li $v0, 10
		syscall
		
	gettingLength:
		
		lbu $t1, userInput($s1)
		
		beq $t1, $zero, exit
		
		addi $s1, $s1, 1
		
		j gettingLength
	
	ascii2dec:
		
		beq $t1, $a0, exit # since array is 0-indexed
		
		lbu $t2, userInput($t1)
		
		sub $t4, $a0, $t1 # temp loop variable
		
		addi $t1, $t1, 1
		
		addi $t6, $zero, 1 # $t6 will be multiplied by 16 
		
		j calDec 
		
	
	calDec:
		
		addi $t4, $t4, -1
		
		beq $t4, $zero, decSum

		mul $t6, $t6, 16
		
		j calDec
		
	
	decSum:
	
		addi $t3, $t2, -65
		
		bge $t3, $zero, decSumAF # A-F
		
		addi $t3, $t2, -48
		
		mul $t3, $t3, $t6 # t6 is initially 1
				
		add $s2, $s2, $t3
		
		j ascii2dec
	
	decSumAF:
		
		addi $t3, $t3, 10
		
		mul $t3, $t3, $t6 # t6 is initially 1
				
		add $s2, $s2, $t3
		
		j ascii2dec
		
	exit:
		jr $ra
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
	
