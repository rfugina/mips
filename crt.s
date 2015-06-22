
.set mips1
# .set noreorder

	nop		# always start with a nop!

main:
	li $t0, 0		# build ascii value here
	li $t2, 0		# rep counter
	li $t3, 0x40	# ascii value of '@'
	li $t4, 26		# letters in the alphabet
	li $t5, 0xc000	# i/o addr of crt
	# li $t6, mydata	# addr of data

repeat:
	li $t1, 1		# reset letter counter

loop:
	add $t0, $t3, $t1		# calc ascii value
	# sw $t0, 0(mydata)
	# sw $t0, mydata		# works, but requires lui
	sw $t0, 0($t5)			# write to crt
	beq $t1, $t4, end
	add $t1, $t1, 1
	# sw $t1, 4(mydata)
	j loop

end:
	li $t0, 10				# newline
	sw $t0, 0($t5)			# write to crt

	li $t6, 0
	addi $t6, mydata
	lw $t2, 0($t6)		# read
	add $t2, $t2, 1		# modify
	sw $t2, 0($t6)		# write

	j repeat

mydata:

	.word 0


