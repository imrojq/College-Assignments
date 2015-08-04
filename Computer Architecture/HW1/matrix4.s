	.file	"matrix.c"
	.text
	.align	2
	.global	matrix
	.type	matrix, %function
matrix:
	@ args = 0, pretend = 0, frame = 36
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #36
	str	r0, [fp, #-40]
	str	r1, [fp, #-44]
	str	r2, [fp, #-48]
	mov	r3, #50
	str	r3, [fp, #-16]
	mov	r3, #1
	str	r3, [fp, #-36]
	b	.L2
.L3:
	ldr	r2, [fp, #-36]
	mov	r3, r2
	mov	r3, r3, asl #1
	add	r3, r3, r2
	mov	r2, r3, asl #4
	add	r3, r3, r2
	mov	r3, r3, asl #2
	mov	r2, r3
	ldr	r3, [fp, #-48]
	add	r1, r2, r3
	ldr	r2, [fp, #-36]
	mov	r3, #0
	str	r3, [r1, r2, asl #2]
	ldr	r3, [fp, #-36]
	add	r3, r3, #1
	str	r3, [fp, #-36]
.L2:
	ldr	r3, [fp, #-36]
	cmp	r3, #50
	ble	.L3
	mov	r3, #2
	str	r3, [fp, #-28]
	b	.L5
.L6:
	mov	r3, #1
	str	r3, [fp, #-36]
	b	.L7
.L8:
	ldr	r2, [fp, #-36]
	ldr	r3, [fp, #-28]
	add	r3, r2, r3
	sub	r3, r3, #1
	str	r3, [fp, #-32]
	ldr	r2, [fp, #-36]
	mov	r3, r2
	mov	r3, r3, asl #1
	add	r3, r3, r2
	mov	r2, r3, asl #4
	add	r3, r3, r2
	mov	r3, r3, asl #2
	mov	r2, r3
	ldr	r3, [fp, #-48]
	add	r2, r2, r3
	ldr	r1, [fp, #-32]
	mov	r3, #1996488704
	add	r3, r3, #3506176
	add	r3, r3, #5120
	str	r3, [r2, r1, asl #2]
	ldr	r3, [fp, #-36]
	str	r3, [fp, #-24]
	b	.L9
.L10:
	ldr	r2, [fp, #-36]
	mov	r3, r2
	mov	r3, r3, asl #1
	add	r3, r3, r2
	mov	r2, r3, asl #4
	add	r3, r3, r2
	mov	r3, r3, asl #2
	mov	r2, r3
	ldr	r3, [fp, #-48]
	add	r2, r2, r3
	ldr	r3, [fp, #-24]
	ldr	r1, [r2, r3, asl #2]
	ldr	r2, [fp, #-24]
	mov	r3, r2
	mov	r3, r3, asl #1
	add	r3, r3, r2
	mov	r2, r3, asl #4
	add	r3, r3, r2
	mov	r3, r3, asl #2
	mov	r2, r3
	ldr	r3, [fp, #-48]
	add	r3, r2, r3
	add	r2, r3, #204
	ldr	r3, [fp, #-32]
	ldr	r3, [r2, r3, asl #2]
	add	r0, r1, r3
	ldr	r3, [fp, #-36]
	mov	r3, r3, asl #2
	mov	r2, r3
	ldr	r3, [fp, #-40]
	add	r3, r2, r3
	sub	r3, r3, #4
	ldr	r1, [r3, #0]
	ldr	r3, [fp, #-24]
	mov	r3, r3, asl #2
	mov	r2, r3
	ldr	r3, [fp, #-40]
	add	r3, r2, r3
	ldr	r3, [r3, #0]
	mul	r1, r3, r1
	ldr	r3, [fp, #-32]
	mov	r3, r3, asl #2
	mov	r2, r3
	ldr	r3, [fp, #-40]
	add	r3, r2, r3
	ldr	r3, [r3, #0]
	mul	r3, r1, r3
	add	r3, r0, r3
	str	r3, [fp, #-20]
	ldr	r2, [fp, #-36]
	mov	r3, r2
	mov	r3, r3, asl #1
	add	r3, r3, r2
	mov	r2, r3, asl #4
	add	r3, r3, r2
	mov	r3, r3, asl #2
	mov	r2, r3
	ldr	r3, [fp, #-48]
	add	r2, r2, r3
	ldr	r3, [fp, #-32]
	ldr	r2, [r2, r3, asl #2]
	ldr	r3, [fp, #-20]
	cmp	r2, r3
	ble	.L11
	ldr	r2, [fp, #-36]
	mov	r3, r2
	mov	r3, r3, asl #1
	add	r3, r3, r2
	mov	r2, r3, asl #4
	add	r3, r3, r2
	mov	r3, r3, asl #2
	mov	r2, r3
	ldr	r3, [fp, #-48]
	add	r1, r2, r3
	ldr	r2, [fp, #-32]
	ldr	r3, [fp, #-20]
	str	r3, [r1, r2, asl #2]
	ldr	r2, [fp, #-36]
	mov	r3, r2
	mov	r3, r3, asl #1
	add	r3, r3, r2
	mov	r2, r3, asl #4
	add	r3, r3, r2
	mov	r3, r3, asl #2
	mov	r2, r3
	ldr	r3, [fp, #-44]
	add	r1, r2, r3
	ldr	r2, [fp, #-32]
	ldr	r3, [fp, #-24]
	str	r3, [r1, r2, asl #2]
.L11:
	ldr	r3, [fp, #-24]
	add	r3, r3, #1
	str	r3, [fp, #-24]
.L9:
	ldr	r3, [fp, #-32]
	sub	r2, r3, #1
	ldr	r3, [fp, #-24]
	cmp	r2, r3
	bge	.L10
	ldr	r3, [fp, #-36]
	add	r3, r3, #1
	str	r3, [fp, #-36]
.L7:
	ldr	r2, [fp, #-16]
	ldr	r3, [fp, #-28]
	rsb	r3, r3, r2
	add	r2, r3, #1
	ldr	r3, [fp, #-36]
	cmp	r2, r3
	bge	.L8
	ldr	r3, [fp, #-28]
	add	r3, r3, #1
	str	r3, [fp, #-28]
.L5:
	ldr	r2, [fp, #-28]
	ldr	r3, [fp, #-16]
	cmp	r2, r3
	ble	.L6
	sub	sp, fp, #12
	ldmfd	sp, {fp, sp, pc}
	.size	matrix, .-matrix
	.section	.rodata
	.align	2
.LC0:
	.ascii	"A%d\000"
	.text
	.align	2
	.global	printparens
	.type	printparens, %function
printparens:
	@ args = 0, pretend = 0, frame = 12
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #12
	str	r0, [fp, #-16]
	str	r1, [fp, #-20]
	str	r2, [fp, #-24]
	ldr	r2, [fp, #-20]
	ldr	r3, [fp, #-24]
	cmp	r2, r3
	bne	.L18
	ldr	r0, .L22
	ldr	r1, [fp, #-20]
	bl	printf
	b	.L21
.L18:
	mov	r0, #40
	bl	putchar
	ldr	r2, [fp, #-20]
	mov	r3, r2
	mov	r3, r3, asl #1
	add	r3, r3, r2
	mov	r2, r3, asl #4
	add	r3, r3, r2
	mov	r3, r3, asl #2
	mov	r2, r3
	ldr	r3, [fp, #-16]
	add	r2, r2, r3
	ldr	r3, [fp, #-24]
	ldr	r3, [r2, r3, asl #2]
	ldr	r0, [fp, #-16]
	ldr	r1, [fp, #-20]
	mov	r2, r3
	bl	printparens
	mov	r0, #120
	bl	putchar
	ldr	r2, [fp, #-20]
	mov	r3, r2
	mov	r3, r3, asl #1
	add	r3, r3, r2
	mov	r2, r3, asl #4
	add	r3, r3, r2
	mov	r3, r3, asl #2
	mov	r2, r3
	ldr	r3, [fp, #-16]
	add	r2, r2, r3
	ldr	r3, [fp, #-24]
	ldr	r3, [r2, r3, asl #2]
	add	r3, r3, #1
	ldr	r0, [fp, #-16]
	mov	r1, r3
	ldr	r2, [fp, #-24]
	bl	printparens
	mov	r0, #41
	bl	putchar
.L21:
	sub	sp, fp, #12
	ldmfd	sp, {fp, sp, pc}
.L23:
	.align	2
.L22:
	.word	.LC0
	.size	printparens, .-printparens
	.section	.rodata
	.align	2
.LC1:
	.ascii	"r\000"
	.align	2
.LC2:
	.ascii	"%d\000"
	.text
	.align	2
	.global	main
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 21040
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #20992
	sub	sp, sp, #48
	mvn	r5, #20992
	sub	r3, r5, #43
	sub	r4, fp, #12
	str	r0, [r4, r3]
	sub	r3, r5, #47
	str	r1, [r4, r3]
	@sub	r3, r5, #43
	@sub	r2, fp, #12
	@ldr	r3, [r4, r3]
	cmp	r0, #1
	ble	.L35
	@sub	r3, r5, #47
	@ldr	r3, [r4, r3]
	@add	r3, r3, #4
	ldr	r0, [r1, #4]
	@mov	r0, r3
	ldr	r1, .L36
	bl	fopen
	@mov	r3, r0
	str	r0, [fp, #-28]
	mov	r7, #0
	@str	r7, [fp, #-20]
	b	.L27
.L28:
	@ldr	r3, [fp, #-20]
	and	r3, r7, #1
	cmp	r3, #0
	bne	.L29
	@ldr	r2, [fp, #-20]
	mov	r2, r7, lsr #31
	add	r2, r2, r7
	mov	r2, r2, asr #1
	@mov	r2, r3
	sub	r3, r5, #39
	ldr	r1, [r4, r3]
	sub	r3, r5, #35
	mov	r2, r2, asl #2
	add	r2, r2, r4
	add	r3, r2, r3
	str	r1, [r3, #0]
.L29:
	@ldr	r3, [fp, #-20]
	cmp	r7, #99
	bne	.L31
	sub	r3, r5, #39
	ldr	r1, [r4, r3]
	sub	r3, r5, #35
	mov	r2, #200
	add	r3, r4, r3
	add	r3, r3, r2
	str	r1, [r3, #0]
.L31:
	@ldr	r3, [fp, #-20]
	add	r7, r7, #1
	@str	r7, [fp, #-20]
.L27:
	sub	r6, fp, #20992
	sub	r2, r6, #52
	ldr	r0, [fp, #-28]
	ldr	r1, .L36+4
	bl	fscanf
	@mov	r3, r0
	cmn	r0, #1
	bne	.L28
	mov	r3, #50
	str	r3, [fp, #-16]
	sub	r0, r6, #48
	add	r1, r6, #156
	add	r2, r6, #10560
	bl	matrix
	sub	r0, fp, #20736
	sub	r0, r0, #100
	mov	r1, #1
	mov	r2, #50
	bl	printparens
.L35:
	sub	sp, fp, #12
	ldmfd	sp, {fp, sp, pc}
.L37:
	.align	2
.L36:
	.word	.LC1
	.word	.LC2
	.size	main, .-main
	.ident	"GCC: (GNU) 4.1.1"
