.data

message: .asciiz "Your string: "
result: .asciiz "Reverse: "
nl: .asciiz "\n"
text: .space 256
size: .word -1

.text

main:

	li $v0, 4
	la $a0, message
	syscall
	
	li $v0, 4
	la $a0, nl
	syscall

	la $a0, text
	li $a1, 256
	li $v0, 8
	syscall

	
	move $t1, $a0
	lw $t0, size 
	li $s0, '-'
	lb $t2, 0($t1)
	
	strlen:
		move $s1, $a0

		Loop:	
			beq $t2, $s0, Exit
			addi $t0, $t0, 1
			addi $t1, $t1, 1
			lb $t2, 0($t1)
			j Loop
		Exit:
			
		Loop1:	
			beq $t2, $zero, Exit1 
			addi $t0, $t0, 1
			addi $t1, $t1, 1
			lb $t2, 0($t1)
			j Loop1

		Exit1: 

			move $a0, $s1
			move $a1, $t0
	
	jal functReverse

	jal functPrintArrChar 

	j main
	
	functReverse:
	
		move $t0, $a0
		move $t1, $a1
		addi $t2, $t1, -1 
		add $t9, $t0, $t2 
		div $t2, $t1, 2  
		add $t3, $zero, $zero 
		
		Loop2:
			   
			 beq $t3, $t2, Exit2
			
			 lb $t4, 0($t0)	
			 lb $t5, 0($t9)

			 move $t6, $t4
			 sb $t5, 0($t0) 
			 sb $t6, 0($t9)
			 
			 addi $t0, $t0, 1
			 addi $t9, $t9, -1
			 addi $t3, $t3, 1 
			 
			 j Loop2
				 		 
			 Exit2: 

			 	jr $ra
	
	functPrintArrChar:
	 
		move $t0, $a0

		li $v0, 4
		la $a0, result
		syscall
			
		li $v0, 4
		move $a0, $t0
		syscall
			
		jr $ra
			 
	Exit:	
		li $v0, 4
		la $a0, result
		syscall
			
		li $v0, 4
		move $a0, $t0
		syscall
		
		li $v0, 10
		syscall