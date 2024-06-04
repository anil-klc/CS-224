.data

	userInput: .word 0
	number: .word 0 
	traverseIndx: .word 0
	result: .word 0
	newLine: .asciiz "\n-------\n"
	userPrompt: .asciiz "Do you want to continue? Y/N "
	yes: .asciiz "Y"
	userAnswer: .space 3
.text

	main:
		
		addi $t0, $zero, 0
		addi $t1, $zero, 0
		addi $t2, $zero, 0
		addi $t3, $zero, 0
		addi $t4, $zero, 0
		addi $t5, $zero, 0
		
		li $v0, 5
		syscall
		
		sw $v0, userInput
		
		la $a0, userInput
		lw $a0, 0($a0)
		jal invertBytes
		
		li $v0, 34
		lw $a0, result
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
		
		li $v0, 4
		la $a0, newLine
		syscall
		
		li $v0, 10
		syscall
		
	
	invertBytes:
		
		beq $t0, 4, exit
		
		sw $a0, number
		
		lbu $t1, number($t0)		
		addi $t0, $t0, 1
			
		addi $t3, $zero, 15 # 31-32 bit
		addi $t4, $zero, 240 # 29-30 bit
		
		and $t5, $t1, $t3
		# sll $t5, $t5, 4
		and $t6, $t1, $t4
		# srl $t6, $t6, 4
		
		or $t6, $t5, $t6 # 1 byte is inverted
		
		lw $t7, result
		
		sll $t7, $t7, 8
		
		or $t7, $t7, $t6
		
		sw $t7, result
		
		j invertBytes
		
		

		
	exit:
		jr $ra









