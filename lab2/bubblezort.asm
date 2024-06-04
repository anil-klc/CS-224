# CS224
# Lab 3
# Section 4 
# Anıl KILIÇ 
# 22203783
# 03.03.2024


.data 
	prompt_1: .asciiz "Array size : "
	prompt_2: .asciiz "Provide array element : "
	min: .asciiz "min element : "
	max: .asciiz "max element : " 
	newLine: .asciiz "\n"


.text


	main:
		
		jal arraySize
		
		
		addi $a0, $v0, 0
		addi $a1, $v1, 0
		addi $sp, $sp, -4
		sw $a0, 0($sp)
		addi $sp, $sp, 4
		sw $a1, 0($sp)
		jal monitor
		
		lw $a0, -4($sp) 
		lw $a1, 0($sp) 
		jal minMax

		

		li $v0, 10
		syscall
			
		
	# v0 : arrayAdrs, v1 : arraySize
	arraySize:
	
		li $v0, 4
		la $a0, prompt_1
		syscall 
			
		li $v0, 5
		syscall
		
		addi $v1, $v0, 0
		
		mul $v0, $v0, 4
		mflo $a0
		
		li $v0, 9
		syscall
		
		jr $ra
	
	# a0: arrayAdrs, a1: arraySize
	monitor:
		
		sgt $t3, $a1, $t0
		beq $t3, 0, bubbleSort
		
		add $t4, $a0, $zero 
		li $v0, 4
		la $a0, prompt_2
		syscall
		add $a0, $t4, $zero
		
		li $v0, 5
		syscall
		
		sw $v0, 0($a0)
		addi $a0, $a0, 4
		addi $t0, $t0, 1

		add $t4, $a0, $zero 
		li $v0, 4
		la $a0, newLine
		syscall
		add $a0, $t4, $zero
		
		lw $v1, 0($sp) # addr
		lw $v0, -4($sp) # size
		
		j monitor
		
	
	bubbleSort:
		
		beq $v0, 0, exit
		
		lw $a0, -4($sp) # addr
		lw $a1, 0($sp) # size
		addi $a1, $a1, -1 # n - 1 traverse
		addi $a2, $zero, 0 # traverse
		addi $v0, $zero, 0
		
		j swapWhile
		
	swapWhile:
		
		beq $a2, $a1, check
		lw $t0, 0($a0)
		lw $t1, 4($a0)
		
		addi $a0, $a0, 4
		addi $a2, $a2, 1
		
		sgt $t3, $t0, $t1
		beq $t3, 0, swapWhile
		
		addi $v0, $zero, 1 
		
		addi $a0, $a0, -4
		addi $a2, $a2, -1
		
		sw $t0, 4($a0)
		sw $t1, 0($a0)
		
		addi $a0, $a0, 4
		addi $a2, $a2, 1
		
		
		j swapWhile
	
	check:
	
		beq $v0, 1, bubbleSort
		j exit
		
	minMax:
		
		addi $t0, $a0, 0
		
		li $v0, 4
		la $a0, min
		syscall
		
		li $v0, 1
		lw $a0, 0($t0)
		syscall
		
		li $v0, 4
		la $a0, newLine
		syscall
		
		addi $a1, $a1, -1 
		
		mul $a1, $a1, 4
		
		mflo $a1
		
		add $t0, $t0, $a1
		
		li $v0, 4
		la $a0, max
		syscall
		
		li $v0, 1
		lw $a0, 0($t0)
		syscall
		
		li $v0, 4
		la $a0, newLine
		syscall
		
		
		j exit
		
	exit:
		
		jr $ra



