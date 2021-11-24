## Quiz: Coding Problem 1: from fahrenheit to celsius
# Name: Jagjit Singh

	.data
val1:	.float	32.0
val2:	.float	9.0
val3:	.float	5.0
lf:	.asciiz	"\n"							# linefeed
pr1:	.asciiz	"Enter an integer temperature value in fahrenheit: "	# prompt
msg:	.asciiz	"In celsius: "							# result 

	.text
	.globl main

main:
	la	$a0, pr1	# load address of prompt
	li	$v0, 4		# print string service code
	syscall
	li	$v0, 5		# read integer service code
	syscall			# read in an integer temperature value

	mtc1	$v0, $f0	# copy bit pattern of $v0 into $f0
	cvt.s.w	$f0, $f0	# convert from word to single precision float

	l.s	$f1, val1	# load val1 (32.0) into $f1
	l.s	$f2, val2	# load val2 (9.0) into $f2
	l.s	$f3, val3	# load val3 (5.0) into $f3

	sub.s	$f0, $f0, $f1	# $f0 = $f0 - 32 (fahrenheit - 32)
	mul.s	$f0, $f0, $f3	# $f0 = (fahrenheit - 32) * 5
	div.s	$f0, $f0, $f2	# $f0 = ((fahremheit - 32) * 5)	/ 9

	la	$a0, lf		# load address of linefeed
	li	$v0, 4		# print string service code
	syscall
	la	$a0, msg	# load address of msg
	syscall			# print message

	mov.s	$f12, $f0	# copy calculated value into register $f12
	li	$v0, 2		# print float service code
	syscall

	li	$v0, 10		# service code to end program
	syscall	

## End of program