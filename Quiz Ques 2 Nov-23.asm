# Quiz: Coding Problem 2: Calculation ax^2 + bx + c

	.data
lf:	.asciiz	"\n"			# linefeed
pr1:	.asciiz	"Enter value for 'x:' "	# prompt message
pr2:	.asciiz	"Enter value for 'a:' "	# prompt message
pr3:	.asciiz	"Enter value for 'b:' "	# prompt message
pr4:	.asciiz	"Enter value for 'c:' "	# prompt message
result:	.asciiz	"ax^2 + bx + c = "	# resulting message

	.text
	.globl main

main:
	la	$a0, pr1	# load address of pr1
	li	$v0, 4		# print string service code
	syscall			# get value for 'x'
	li	$v0, 6		# read float service code
	syscall			# get value for 'x'
	mov.s	$f1, $f0	# move 'x' into $f1

	la	$a0, pr2	# load address of pr2
	li	$v0, 4		# print string service code
	syscall			# print prompt 2
	li	$v0, 6		# read float service code 
	syscall			# get value for 'a'
	mov.s	$f2, $f0	# move 'a' into $f2

	
	la	$a0, pr3	# load address of pr3
	li	$v0, 4		# print string service code
	syscall			# print prompt 3
	li	$v0, 6		# read float service code 
	syscall			# get value for 'b'
	mov.s	$f3, $f0	# move 'a' into $f3

	
	la	$a0, pr4	# load address of pr4
	li	$v0, 4		# print string service code
	syscall			# print prompt 4
	li	$v0, 6		# read float service code 
	syscall			# get value for 'c'
	mov.s	$f4, $f0	# move 'c' into $f4

	mul.s	$f0, $f1, $f1	# $f0 = x * x = x^2
	mul.s	$f0, $f0, $f2	# $f0 = x^2 * a = ax^2
	mul.s	$f1, $f1, $f3	# $f1 = x * b = bx
	add.s	$f0, $f0, $f1	# $f0 = ax^2 + bx
	add.s	$f0, $f0, $f4	# $f0 = ax^2 + bx + c

	la	$a0, lf		# load address of linefeed
	li	$v0, 4		# print string service code
	syscall
	la	$a0, result	# load address of result message
	syscall
	
	mov.s	$f12, $f0	# move calculated val into $f12 to print
	li	$v0, 2		# print float service code
	syscall			# print the resulting value

	li	$v0, 10		# service code to end program
	syscall

## End of program