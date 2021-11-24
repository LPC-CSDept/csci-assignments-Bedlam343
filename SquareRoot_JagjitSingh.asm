## Quiz: Problem 3: Newton's method for finding square root
# Name: Jagjit Singh

	.data
x:	.float	1.0			# initial value for x
cons1:	.float	2.0			# constant needed for equation
limit:	.float	1.0e-5			# termination condition
pr1:	.asciiz	"Enter a number: "	# prompt 1
final:	.asciiz	"Square root: "		# message for the result
lf:	.asciiz	"\n"			# linefeed
	
	.text
	.globl main

main:
	la	$a0, pr1	# load address of prompt 1
	li	$v0, 4		# print string service code
	syscall
	li	$v0, 6		# read float service code
	syscall			# get value of 'n' -> $f0 = n

	l.s	$f1, x		# load initial value of x into $f1
	l.s	$f2, cons1	# load constant value '2.0' into $f2
	mov.s	$f3, $f1	# x == first approximation
	l.s	$f10, limit	# load termination value 1.0e-5 into $t10

loop:
	mov.s	$f4, $f0	# x' = n
	div.s	$f4, $f4, $f3	# x' = n/x
	add.s	$f4, $f3, $f4	# x' = x + n/x
	div.s	$f4, $f4, $f2	# x'  = (1/2) (x + n/x)
	sub.s	$f5, $f4, $f3	# $f5 = x' - x
	abs.s	$f5, $f5
	mov.s	$f3, $f4	# x = x'
	c.lt.s	$f5, $f10	# if((x' - x) < 1.0e-5)
	bc1f	loop		# if condition bit == true, branch to loop
	nop
	
	la	$a0, lf		# load address for linefeed
	li	$v0, 4		# print string service code
	syscall
	la	$a0, final	# load address for final
	syscall
	
	mov.s	$f12, $f4	# move x' into $f12 to print
	li	$v0, 2		# print float service code
	syscall

	li	$v0, 10		# service code to end program
	syscall

## End of program