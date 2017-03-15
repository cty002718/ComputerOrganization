.text
.globl main

main:
		li		$v0, 4
		la		$a0, msg1
		syscall
		li		$v0, 5
		syscall
		move	$t0, $v0
		
		li		$v0, 4
		la		$a0, msg2
		syscall
		li		$v0, 5
		syscall
		move	$t1, $v0

		move	$a0, $t0
		move	$a1, $t1
		jal		GCD
		
		move	$s0, $v0
		li		$v0, 4
		la		$a0, msg3
		syscall
		li		$v0, 1
		move	$a0, $s0
		syscall

EXIT:
		li		$v0, 10
		syscall

GCD:
		addi	$sp, $sp, -4
		sw		$ra, 0($sp)

		bne		$a1, $zero, ELSE
		move	$v0, $a0
		j		EXIT2
ELSE:
		div		$a0, $a1
		mfhi	$t0
		move	$a0, $a1
		move	$a1, $t0
		jal		GCD
EXIT2:
		lw		$ra, 0($sp)
		addi	$sp, $sp, 4
		jr		$ra

.data
msg1:	.asciiz	"Enter first integers: "
msg2:	.asciiz	"Enter second integers: "
msg3:	.asciiz	"Greatest common divisor: "



