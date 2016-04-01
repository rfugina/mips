
.set noreorder

setup:
	li $t0, 0x400

	li $t1, 1
	sw $t1, 0($t0)

	li $t1, 2
	sw $t1, 4($t0)

	li $t1, 3
	sw $t1, 8($t0)

loop:
	lw $t1, 0($t0)
	sw $zero, 0($t0)
	lw $t2, 4($t0)
	sw $t1, 4($t0)
	lw $t1, 8($t0)
	sw $t2, 8($t0)
	sw $t1, 0($t0)
	
	b loop



