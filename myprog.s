
# .set noreorder

main:
# some testing
	addi $t1, $zero, 4
	ori $t1, $t1, 0xf1
	andi $t1, $t1, 0xf
	lw $t3, mydata


	ori $s1, $zero, 0x3f





	j init

.space 200

init:
	or $t0, $zero, $zero
	beq $zero, $zero, loop

.space 200

loop:
	addi $t0, $t0, 2
	addi $t0, $t0, -1
	bne $t0, $t1, loop

# accumulate in RAM
	lw $t2, 0($zero)
	add $t2, $t2, $t0
	sw $t2, 0($zero)

# clear counter
	add $t0, $zero, $zero

# start again
	ori $t2, $zero, loop
	jr $t2

.space 200

error:
	nop		# ERROR!


.data
	mydata:
	.word 00000005

