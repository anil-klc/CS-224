.data

	prompt1: .asciiz "Total number of add-ori-lw instructions in main with psudecodes included : "    
	prompt2: .asciiz "Total number of add-ori-lw instructions in subProgram with psudecodes included : "    
	newLine: .asciiz "\n"

.text

	main:

    		# THERE ARE 1 ori IN la
    		la $a0, main 
    		la $a1, instructionCount

    		jal instructionCount

    		addi $s0, $v0, 0

    		la $a0, prompt1
    		li $v0,4
    		syscall	
    
    		addi $v0, $zero, 1
    		addi $a0, $s0, 0  
    		syscall  

    		la $a0, newLine
    		li $v0,4
    		syscall     

    		# THERE ARE 1 ori IN la
    		la $a0, instructionCount
    		la $a1, exit

    		jal instructionCount

    		addi $s0, $v0, 0
    
    		la $a0, prompt2
    		li $v0,4
    		syscall	
    
    		addi $v0, $zero, 1
    		addi $a0, $s0, 0  
    		syscall  

    		la $a0, newLine
    		li $v0,4
    		syscall     
    

    		addi $v0, $zero, 10
    		syscall     


	instructionCount:
		
		addi $sp, $sp, -12
		sw $s0, 0($sp)
		sw $s1, 4($sp)
		sw $s2, 8($sp)
		sw $s3, 12($sp)
		
   		# Initialize counters
    		addi $v0, $zero, 0  # Initialize the return value to 0


	L1: 
		
    		bgt $a0, $a1, exit
    
    		lw $s1, 0($a0)
    
    		andi $s2, $s1, 0xFC000000 # opcode 
    
    		# add
    		andi $s3, $s1, 63  # func field for add
    		add $s3, $s3, $s2
    		beq $s3, 32, increment
	
    		# ori
    		addi $s3, $zero, 0x34000000 # opcode of ori
    		beq $s2, $s3, increment
 
   		# lw
    		addi $s3, $zero, 0x8C000000 # opcode of lw
    		beq $s2, $s3, increment

    
    		addi $a0, $a0, 4  # next instruction
    		j L1

	increment:
    		addi $v0, $v0, 1 
    		addi $a0, $a0, 4 
    		j L1
    
	exit:
		lw $s0, 0($sp)
		lw $s1, 4($sp)
		lw $s2, 8($sp)
		lw $s3, 12($sp)
		addi $sp, $sp, 12
    		jr $ra
    


