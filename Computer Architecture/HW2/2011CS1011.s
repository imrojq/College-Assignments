	.file	"stub.c"
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC0:
	.ascii	"Input 1 = %x \n\000"
	.align	2
.LC1:
	.ascii	"Operator = %c \n\000"
	.align	2
.LC2:
	.ascii	"Input 2 = %x \n\000"
	.text
	.align	2
	.global	process
	.type	process, %function
process:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {r4, r5, fp, ip, lr, pc}
	sub	fp, ip, #4
	and	r4, r1, #255
	mov	r1, r0
	ldr	r0, .L2
	mov	r5, r2
	mov r7, r1 	
	bl	printf
	mov	r1, r4
	ldr	r0, .L2+4
	mov r8, r1
	bl	printf
	mov	r1, r5
	mov r9, r1
	ldr	r0, .L2+8
	bl	printf

### INSERT YOUR CODE HERE
	### r7 contains the first operand
	### r8 contains the sign (+, -, *)
	### r9 contains the second operand
	lsr	r1, r7, #31	@sign bit of r7
	lsl	r2, r7, #1
	lsr 	r2, r2, #24	@exp of r7
	lsl	r3, r7, #9
	lsr	r3, r3, #9
	orr	r3, r3, #0x00800000	@mantissa of r7 with 24th bit1  
	lsr	r4, r9, #31
	lsl	r5, r9, #1
	lsr 	r5, r5, #24
	lsl	r6, r9, #9
	lsr	r6, r6, #9
	orr	r6, r6, #0x00800000
	cmp	r8, #42
	beq	.multiply
	cmp	r8, #45
	lsleq	r4, r4, #31	@reversing the sign bit of r9
	mvneq	r4, r4
	lsreq	r4, r4, #31
	cmp	r1, #1		@checkinh sign of r7
	mvneq	r3, r3
	addeq	r3, r3, #1
	cmp	r4, #1		@checking sign of r9
	mvneq	r6, r6
	addeq	r6, r6, #1
	cmp	r2, r5		@getting the bigger exponent
	subge	r10,r2, r5
	asrge	r6, r6, r10
	movge	r5, r2		@ " "   "
	sublt	r10,r5, r2
	asrlt	r3, r3, r10
	movlt	r2, r5		@updating r2
	add	r11,r3, r6		@getting sum of mantissa
	lsr	r10,r11,#31	@cheking sign of answer
	cmp	r10,#1
	mvneq	r11,r11
	addeq	r11,r11,#1
	lsr	r12,r11,#24	@checkinh 25th bit of ans for lsr
	cmp	r12,#1
	lsreq	r11,r11,#1
	addeq	r2, r2, #1
	bl	.dshift
	lsl	r11,r11,r8
	sub	r2 ,r2, r8		
	b	.exit			@move to exit to update the answer


.dshift:
	mov	r8, #0
	mov	r1, #0x00800000
.loop:
	and	r4, r11, r1
	cmp	r4,#0
	addeq	r8, r8, #1
	lsreq	r1, r1, #1
	beq	.loop
	mov	pc,lr


.multiply:
	eor	r10,r1, r4
	add	r2, r2, r5
	sub	r2, r2, #127
	umull	r11,r5,r3,r6
	mov	r1,r11
	mov	r4, #23
	lsr	r11,r11,#23
	lsl	r5, r5, #9
	orr	r11,r5,r11
	bl	.rounding
	add	r11, r11, r12
	lsr	r12,r11,#24	@checkinh 25th bit of ans for lsr
	cmp	r12,#1
	lsreq	r11,r11,#1
	addeq	r2, r2, #1
	b	.exit

.rounding:
	mov	r8, #31
	sub	r8, r8, r4
	lsl	r9, r1, r8
	lsr	r9, r9, #31
	add	r8, r8, #1
	lsl	r1, r1, r8
	lsr	r7, r1, #31
	lsr	r1, r1, r8
	add 	r8, r8, #1
	lsl	r1, r1, r8
	lsr	r1, r1, r8
	cmp	r1, #0
	movne	r12,r7
	andeq	r12,r7,r9
	mov	pc,lr

.exit:
	mov	r0, #0
	orr	r0, r0, r11
	lsl	r0,r0,#9
	lsr	r0,r0,#9
	orr	r0, r0, r2, lsl #23
	orr	r0, r0, r10,lsl #31
	### Put the final output in r0
	### YOUR CODE ENDS HERE

	ldmfd	sp, {r4, r5, fp, sp, pc}
.L3:
	.align	2
.L2:
	.word	.LC0
	.word	.LC1
	.word	.LC2
	.size	process, .-process
	.section	.rodata
	.align	2
	.type	filename.0, %object
	.size	filename.0, 9
filename.0:
	.ascii	"input.txt\000"
	.global	__extendsfdf2
	.section	.rodata.str1.4
	.align	2
.LC3:
	.ascii	"r\000"
	.align	2
.LC4:
	.ascii	"%f %c %f\000"
	.align	2
.LC6:
	.ascii	"Result = %f (float) , %x (hex)\n\000"
	.align	2
.LC5:
	.ascii	"File Not Found \000"
	.text
	.align	2
	.global	main
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 140
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {r4, r5, fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #144
	ldr	r0, .L12
	ldr	r1, .L12+4
	bl	fopen
	subs	r5, r0, #0
	subne	r4, fp, #152
	bne	.L6
	b	.L11
.L8:
	sub	ip, fp, #160
	str	ip, [sp, #0]
	bl	sscanf
.L6:
	mov	r1, #128
	mov	r2, r5
	mov	r0, r4
	bl	fgets
	cmp	r0, #0
	ldr	r1, .L12+8
	sub	r2, fp, #156
	sub	r3, fp, #21
	mov	r0, r4
	bne	.L8
	mov	r0, r5
	bl	fclose
.L9:
	ldr	r2, [fp, #-160]
	ldrb	r1, [fp, #-21]	@ zero_extendqisi2
	ldr	r0, [fp, #-156]
	bl	process
	mov	r4, r0
	bl	__extendsfdf2
	mov	r3, r4
	mov	r2, r1
	mov	r1, r0
	ldr	r0, .L12+12
	bl	printf
	sub	sp, fp, #20
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L11:
	ldr	r0, .L12+16
	bl	puts
	b	.L9
.L13:
	.align	2
.L12:
	.word	filename.0
	.word	.LC3
	.word	.LC4
	.word	.LC6
	.word	.LC5
	.size	main, .-main
	.ident	"GCC: (GNU) 3.4.3"
