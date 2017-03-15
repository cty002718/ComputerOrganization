.text
.globl main

main:
		la		$s0, array 
		lw		$s1, size 

		li		$v0, 4
		la		$a0, msg1
		syscall
		li		$s2, 0
output1:
		li		$v0, 1
		sll		$t0, $s2, 2
		add		$t0, $s0, $t0
		lw		$a0, 0($t0)
		syscall
		li		$v0, 4
		la		$a0, space
		syscall
		addi	$s2, $s2, 1
		bne		$s2, $s1, output1
		
		move	$a0, $s0
		move	$a1, $s1
		jal		sort
		
		li		$v0, 4
		la		$a0, msg2
		syscall
		li		$s2, 0
output2:
		li		$v0, 1
		sll		$t0, $s2, 2
		add		$t0, $s0, $t0
		lw		$a0, 0($t0)
		syscall
		li		$v0, 4
		la		$a0, space
		syscall
		addi	$s2, $s2, 1
		bne		$s2, $s1, output2

exit:
		li		$v0, 4
		la		$a0, newl
		syscall
		li		$v0, 10
		syscall
		
sort:
		addi	$sp, $sp, -20
		sw		$ra, 16($sp)
		sw		$s0, 12($sp)
		sw		$s1, 8($sp)
		sw		$s2, 4($sp)
		sw		$s3, 0($sp)

		move	$s2, $a0
		move	$s3, $a1
		
		li		$s0, 0
L1:
		slt		$t0, $s0, $s3
		beq		$t0, $zero, ExitL1
		
		addi	$s1, $s0, -1 
L2:		
		slt		$t0, $s1, $zero
		bne		$t0, $zero, ExitL2
		
		move	$t0, $s1
		addi	$t1, $t0, 1
		sll		$t0, $t0, 2
		sll		$t1, $t1, 2
		add		$t0, $t0, $s2
		add		$t1, $t1, $s2
		lw		$t2, 0($t0)
		lw		$t3, 0($t1)
		
		slt		$t0, $t3, $t2
		beq		$t0, $zero, ExitL2
		
		move	$a0, $s2
		move	$a1, $s1
		jal		swap
		
		addi	$s1, $s1, -1	
		j		L2

ExitL2:
		addi	$s0, $s0, 1
		j		L1

ExitL1:
		lw		$s3, 0($sp)
		lw		$s2, 4($sp)
		lw		$s1, 8($sp)
		lw		$s0, 12($sp)
		lw		$ra, 16($sp)
		addi	$sp, $sp, 20
		jr		$ra

swap:
		move	$t0, $a1
		sll		$t0, $t0, 2
		add		$t0, $t0, $a0

		addi	$t1, $a1, 1
		sll		$t1, $t1, 2
		add		$t1, $t1, $a0
		
		lw		$t2, 0($t0)
		lw		$t3, 0($t1)
		sw		$t3, 0($t0)
		sw		$t2, 0($t1)
		
		jr		$ra

.data
array:	.word	1, 24, 3, 75, 243, 22, 31, 12, 9, 0
size:	.word	10
msg1:	.asciiz	"The array before sort :\n"
msg2:	.asciiz	"\nThe array after sort :\n"
space:	.asciiz	" "
newl:	.asciiz	"\n"


