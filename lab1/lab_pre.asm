# CS224
# Lab 1 
# Section 4 
# Anıl KILIÇ 
# 22203783
# 18.02.2024

.data
	
	array: .space 80 # initialize every array element with 0 
	prompt_1: .asciiz "Provide the array size : "
	prompt_2: .asciiz "Provide a number : "
	prompt_3: .asciiz "Provide a integer number N : "
	prompt_4: .asciiz "Equal to N : "
	prompt_5: .asciiz "Less than N : "
	prompt_6: .asciiz "Greater than N : "
	prompt_7: .asciiz "Divisible by N : "
	coma: .asciiz ", "
	newLine: .asciiz "\n"

.text
	
	main:
	 
		addi $t0, $zero, 0 # array size
		addi $t1, $zero, 0 # traverse var
		addi $t2, $zero, 0 # user input
		addi $t3, $zero, 0 # increment var for N
		
		li $sp, -16 # allocating 16 byte memory from the stack, results are held in stack 
		
		jal userInput
		
		addi $t0, $v1, 0
		
		addi $v1, $zero, 0
		
		jal userInput_2
		
		addi $t1, $zero, 0
		
		jal printArr
		
		jal user_N
		
		addi $t2, $v1, 0
		
		addi $v1, $zero, 0
		
		addi $t1, $zero, 0
		
		jal equal_to_N # no return, save to stack
		
		li $v0, 4
		la $a0, prompt_4
		syscall	
		
		li $v0, 1
		lw $a0, 0($sp)
		syscall
		
		li $v0, 4
		la $a0, newLine
		syscall
		
		addi $t1, $zero, 0
		
		addi $t3, $zero, 0
		
		jal less_than_N
		
		li $v0, 4
		la $a0, prompt_5
		syscall	
		
		li $v0, 1
		lw $a0, 4($sp)
		syscall
	
	
		li $v0, 4
		la $a0, newLine
		syscall
		
		addi $t1, $zero, 0
		
		addi $t3, $zero, 0
		
		jal greater_than_N


		li $v0, 4
		la $a0, prompt_6
		syscall	
		
		li $v0, 1
		lw $a0, 8($sp)
		syscall
		
		addi $t1, $zero, 0
		
		addi $t3, $zero, 0

		li $v0, 4
		la $a0, newLine
		syscall
		
		jal divisible_by_N
		
		li $v0, 4
		la $a0, prompt_7
		syscall
			
		li $v0, 1
		lw $a0, 12($sp)
		syscall
		
		li $v0, 4
		la $a0, newLine
		syscall
		
		li $v0, 10
		syscall
		
		
	userInput:
	
		li $v0, 4
		la $a0, prompt_1
		syscall 
		
		li $v0, 5 # 5 integer read
		syscall
		
		addi $v1, $v0, 0
		
		mul $v1, $v1, 4
		
		li $v0, 4
		la $a0, newLine
		syscall 


			
	userInput_2:
			
		beq $t1, $t0, rtrn
									
		li $v0, 4
		la $a0, prompt_2
		syscall 
		
			
		li $v0, 5 
		syscall
	
		sw $v0, array($t1)
			
		addi $t1, $t1, 4 # 1 byte increment

			
		li $v0, 4
		la $a0, newLine
		syscall 			
			
		j userInput_2
		
		
		
	printArr:
			
		beq $t1, $t0, rtrn
		
		lw $t6, array($t1) # to hold the current value of the array item

		addi $t1, $t1, 4 # 1 byte decrement
			
		li $v0, 1
		move $a0, $t6
		syscall
			
		li $v0, 4
		la $a0, coma
		syscall 
			
		li $v0, 4
		la $a0, newLine
		syscall 
			
		j printArr
			
			
	user_N:
			
		li $v0, 4
		la $a0, prompt_3
		syscall
			
		li $v0, 5
		syscall
		 
		addi $v1, $v0, 0
		
		li $v0, 4
		la $a0, newLine
		syscall
			
		jr $ra
			
			
		
	equal_to_N:
			
				
		beq $t1, $t0, rtrn
		
		lw $t6, array($t1)
		
		addi $t1, $t1, 4
		
		bne $t2, $t6, equal_to_N
		
		addi $t3, $t3, 1
		
		sw $t3, 0($sp) 
		
		j equal_to_N
		
	less_than_N:
	
		beq $t1, $t0, rtrn
		
		lw  $t6, array($t1)
		
		addi $t1, $t1, 4
		
		sgeu $t4, $t6, $t2
		
		bne $t4, 0, less_than_N
		
		addi $t3, $t3, 1
		
		sw $t3, 4($sp) 
		
		j less_than_N
	
		
	greater_than_N:
	
		beq $t1, $t0, rtrn
		
		lw  $t6, array($t1)
		
		addi $t1, $t1, 4
		
		sleu $t4, $t6, $t2
		
		bne $t4, 0, greater_than_N
		
		addi $t3, $t3, 1
		
		sw $t3, 8($sp) 
		
		j greater_than_N
	
		
	divisible_by_N:
	
		beq $t1, $t0, rtrn
		
		lw  $t6, array($t1)
		
		addi $t1, $t1, 4
		
		div $t6, $t2
		
		mfhi $s1
		
		bne $s1, 0, divisible_by_N
		
		addi $t3, $t3, 1
		
		sw $t3, 12($sp) 
		
		j divisible_by_N

	
	rtrn:
		jr $ra
	
	
		
		
		
		
		
		
		
		
