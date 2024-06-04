.data
	
	
	
	

.text

	#-------------------#

	leaf_example:
		
		addi $sp, $sp, -4 # move stack pointer to the next EMPTY memory location 
		sw $s0, 0($sp) # saving s0 to stack, since leaf_example is calle 
		
		# smt
		# smt
		# smt
		
		# restoring sp and s back caller's value 
		lw $s0, 0($sp)
		addi $sp, $sp, 4 
		
		
	#-------------------#
		
	la $t0, smt
	
	sb $t1, 0($t0)
	
	# do smt 
	
	addi $t0, $t0, 1 # 1 byte ahead adr
	
	sb $t1, 0($t0)


	#-------------------#


