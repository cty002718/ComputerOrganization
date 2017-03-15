.text
.globl main

main:
		li		$v0, 4
		la		$a0, msg
		syscall

input:
		li		$v0, 5
		syscall
		move	$s0, $v0

		li		$s1, 0
L1:
		slt		$t0, $s1, $s0
		beq		$t0, $zero, EXIT
		
		li		$s2, 0
L2:
		slt		$t0, $s1, $s2
		bne		$t0, $zero, ExitL2

		beq		$s2, $zero, IF
		beq		$s2, $s1, IF
		
		sub		$t0, $s1, $s2
		addi	$t0, $t0, 1
		mul		$s3, $s3, $t0
		div		$s3, $s2
		mflo	$s3
		j		PRINT
IF:
		li		$s3, 1
PRINT:
		li		$v0, 4
		la		$a0, space
		syscall
		li		$v0, 1
		move	$a0, $s3
		syscall
		
		addi	$s2, $s2, 1
		j		L2

ExitL2:
		li		$v0, 4
		la		$a0, newl
		syscall
		addi	$s1, $s1, 1
		j		L1
EXIT:
		li		$v0, 10
		syscall

.data
msg:	.asciiz	"Pascal Triangle \nPlease enter the number of levels(1~30): "
space:	.asciiz " "
newl:	.asciiz "\n"
