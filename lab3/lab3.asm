.data
	line:	
	.asciiz "\n --------------------------------------"

nodeNumberLabel:
	.asciiz	"\n Node No.: "
	
addressOfCurrentNodeLabel:
	.asciiz	"\n Address of Current Node: "
	
addressOfNextNodeLabel:
	.asciiz	"\n Address of Next Node: "
	
dataValueOfCurrentNode:
	.asciiz	"\n Data Value of Current Node: "

reverseOrder:
	.asciiz "\n Reverse ordered link list: "
	
iterative:
	.asciiz "\n Linked list iteratively copied, print: "
	
recursive:
	.asciiz "\n Linked list recursively copied, print: "


space:
	.asciiz " "



.text

	li	$a0, 10	
	jal	createLinkedList
	
	move $a0, $v0
	jal DisplayReverseOrderRecursively
	
	move	$s0, $v0
	
	move	$a0, $v0	
	jal 	printLinkedList
	
	move	$v0, $s0
	move $a0, $v0
	jal DuplicateListRecursive
	#jal	DuplicateListIterative
	
	move	$a0, $v0	
	jal 	printLinkedList
	

	li	$v0, 10
	syscall	
#=========================================================
createLinkedList:

	addi	$sp, $sp, -24
	sw	$s0, 20($sp)
	sw	$s1, 16($sp)
	sw	$s2, 12($sp)
	sw	$s3, 8($sp)
	sw	$s4, 4($sp)
	sw	$ra, 0($sp) 	# Save $ra just in case we may want to call a subprogram
	
	move	$s0, $a0	# $s0: no. of nodes to be created.
	li	$s1, 1		# $s1: Node counter
# Create the first node: header.
# Each node is 8 bytes: link field then data field.
	li	$a0, 8
	li	$v0, 9
	syscall
# OK now we have the list head. Save list head pointer 
	move	$s2, $v0	# $s2 points to the first and last node of the linked list.
	move	$s3, $v0	# $s3 now points to the list head.	
# sll: So that node 1 data value will be 4, node i data value will be 4*i
	sw	$s1, 4($s2)	# Store the data value.
	
addNode:
# Are we done?
# No. of nodes created compared with the number of nodes to be created.
	beq	$s1, $s0, allDone
	addi	$s1, $s1, 1	# Increment node counter.
	li	$a0, 8 		# Remember: Node size is 8 bytes.
	li	$v0, 9
	syscall
# Connect the this node to the lst node pointed by $s2.
	sw	$v0, 0($s2)
# Now make $s2 pointing to the newly created node.
	move	$s2, $v0	# $s2 now points to the new node.	
# sll: So that node 1 data value will be 4, node i data value will be 4*i
	sw	$s1, 4($s2)	# Store the data value.
	j	addNode
allDone:
# Make sure that the link field of the last node cotains 0.
# The last node is pointed by $s2.
	sw	$zero, 0($s2)
	move	$v0, $s3	# Now $v0 points to the list head ($s3).
	
# Restore the register values
	lw	$ra, 0($sp)
	lw	$s4, 4($sp)
	lw	$s3, 8($sp)
	lw	$s2, 12($sp)
	lw	$s1, 16($sp)
	lw	$s0, 20($sp)
	addi	$sp, $sp, 24
	
	jr	$ra
#=========================================================
printLinkedList:
# Print linked list nodes in the following format
# --------------------------------------
# Node No: xxxx (dec)
# Address of Current Node: xxxx (hex)
# Address of Next Node: xxxx (hex)
# Data Value of Current Node: xxx (dec)
# --------------------------------------

# Save $s registers used
	addi	$sp, $sp, -20
	sw	$s0, 16($sp)
	sw	$s1, 12($sp)
	sw	$s2, 8($sp)
	sw	$s3, 4($sp)
	sw	$ra, 0($sp) 	# Save $ra just in case we may want to call a subprogram

# $a0: points to the linked list.
# $s0: Address of current
# s1: Address of next
# $2: Data of current
# $s3: Node counter: 1, 2, ...
	move $s0, $a0	# $s0: points to the current node.
	li   $s3, 0
printNextNode:
	beq	$s0, $zero, printedAll
				# $s0: Address of current node
	lw	$s1, 0($s0)	# $s1: Address of  next node
	lw	$s2, 4($s0)	# $s2: Data of current node
	addi	$s3, $s3, 1
# $s0: address of current node: print in hex.
# $s1: address of next node: print in hex.
# $s2: data field value of current node: print in decimal.
	la	$a0, line
	li	$v0, 4
	syscall		# Print line seperator
	
	la	$a0, nodeNumberLabel
	li	$v0, 4
	syscall
	
	move	$a0, $s3	# $s3: Node number (position) of current node
	li	$v0, 1
	syscall
	
	la	$a0, addressOfCurrentNodeLabel
	li	$v0, 4
	syscall
	
	move	$a0, $s0	# $s0: Address of current node
	li	$v0, 34
	syscall

	la	$a0, addressOfNextNodeLabel
	li	$v0, 4
	syscall
	move	$a0, $s1	# $s0: Address of next node
	li	$v0, 34
	syscall	
	
	la	$a0, dataValueOfCurrentNode
	li	$v0, 4
	syscall
		
	move	$a0, $s2	# $s2: Data of current node
	li	$v0, 1		
	syscall	

# Now consider next node.
	move	$s0, $s1	# Consider next node.
	j	printNextNode
printedAll:
# Restore the register values
	lw	$ra, 0($sp)
	lw	$s3, 4($sp)
	lw	$s2, 8($sp)
	lw	$s1, 12($sp)
	lw	$s0, 16($sp)
	addi	$sp, $sp, 20
	jr	$ra
#=========================================================	

DisplayReverseOrderRecursively:
	
	addi	$sp, $sp, -24
	sw	$s0, 20($sp)
	sw	$s1, 16($sp)
	sw	$s2, 12($sp)
	sw	$s3, 8($sp)
	sw      $a0, 4($sp)
	sw	$ra, 0($sp)
	
	lw      $s0, 0($a0)
	bne     $s0, $zero, L1
	
	jr	$ra
	
L1:

	addi	$a0, $a0, 8
	
	jal	DisplayReverseOrderRecursively
	 	
	lw	$s0, 20($sp)
	lw	$s1, 16($sp)
	lw	$s2, 12($sp)
	lw	$s3, 8($sp)
	lw      $a0, 4($sp)
	lw	$ra, 0($sp)
	
	addi	$sp, $sp, 24
		
	lw	$a0, 4($a0)
	li	$v0, 1
	syscall
	
	la	$a0, space
	li	$v0, 4
	syscall
	
	jr 	$ra
					

		
DuplicateListRecursive:
	
	move	$s0, $a0
	
	la	$a0, recursive
	li	$v0, 4
	syscall		
	
	move	$a0, $s0
	
Rec:
	
	addi	$sp, $sp, -24
	sw	$s0, 20($sp)
	sw	$s1, 16($sp)
	sw	$s2, 12($sp)
	sw	$s3, 8($sp)
	sw      $a0, 4($sp)
	sw	$ra, 0($sp)
	
	la	$s0, 0($a0)
	
	lw      $s1, 0($s0)
	bne     $s1, $zero, L2

	li	$a0, 8
	li	$v0, 9
	syscall	
	
	lw 	$s2, 4($s0)
	sw 	$s2, 4($v0)

	lw	$s0, 20($sp)
	lw	$s1, 16($sp)
	lw	$s2, 12($sp)
	lw	$s3, 8($sp)
	lw      $a0, 4($sp)
	lw	$ra, 0($sp)
	
	addi	$sp, $sp, 24
	
	jr	$ra
				
L2:

	li	$a0, 8
	li	$v0, 9
	syscall	
	
	lw 	$s2, 4($s0)
	sw 	$s2, 4($v0)
	
	la	$s2, 0($v0)
	
	addi	$a0, $s0, 8
	
	jal	Rec

	la	$s3, 0($v0)
	sw	$s3, 0($s2)
	
	addi $v0, $s2, 0
	
	lw	$s0, 20($sp)
	lw	$s1, 16($sp)
	lw	$s2, 12($sp)
	lw	$s3, 8($sp)
	lw      $a0, 4($sp)
	lw	$ra, 0($sp)
	
	addi	$sp, $sp, 24

	jr	$ra
	

DuplicateListIterative:
					
	addi	$sp, $sp, -24
	sw	$s0, 20($sp)																	
	sw	$s1, 16($sp)
	sw	$s2, 12($sp)
	sw	$s3, 8($sp)
	sw	$s4, 4($sp)
	sw	$ra, 0($sp)	
	
	move	$s4, $zero
	lw	$s3, 0($a0)
	beq 	$s3, $zero, return

	move $s0, $a0	
	
	li	$a0, 8
	li	$v0, 9
	syscall	
	
	lw 	$s3, 4($s0)
	sw 	$s3, 4($v0)
	
	move 	$s1, $v0
	move	$s4, $v0
	
				
loop:
	lw $s3, 0($s0)
	beq $s3, $zero, return
	
	li	$a0, 8
	li	$v0, 9
	syscall	
	
	lw 	$s2, 4($s3)
	sw 	$s2, 4($v0)
	
	sw	$v0, 0($s1)
	move 	$s1, $v0
	
	addi	$s0, $s0, 8 
	
	j	loop
	
return:			

	la	$a0, iterative
	li	$v0, 4
	syscall			
	
	move	$v0, $s4 
			
	sw	$s0, 20($sp)																	
	sw	$s1, 16($sp)
	sw	$s2, 12($sp)
	sw	$s3, 8($sp)
	sw	$s4, 4($sp)
	sw	$ra, 0($sp)
									
	addi	$sp, $sp, 24	
	
	jr	$ra	
													
														
															
																
																		

