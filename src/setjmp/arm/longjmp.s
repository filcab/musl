.global _longjmp
.global longjmp
.type _longjmp,%function
.type longjmp,%function
_longjmp:
longjmp:
	mov ip,r0
	movs r0,r1
	moveq r0,#1
	ldmia ip!, {v1,v2,v3,v4,v5,v6,sl,fp,sp,lr}

	adr r1,1f
	ldr r2,1f
	ldr r1,[r1,r2]

	tst r1,#0x260
	beq 3f
	tst r1,#0x20
	beq 2f
	ldc p2, c4, [ip], #48
2:	tst r1,#0x40
	beq 2f
    # Filcab: teensy's chip doesn't have an FPU
	#ldc p11, c8, [ip], #64
2:	tst r1,#0x200
	beq 3f
	ldcl p1, c10, [ip], #8
	ldcl p1, c11, [ip], #8
	ldcl p1, c12, [ip], #8
	ldcl p1, c13, [ip], #8
	ldcl p1, c14, [ip], #8
	ldcl p1, c15, [ip], #8
3:	tst lr,#1
	moveq pc,lr
	bx lr

.hidden __hwcap
1:	.word __hwcap-1b
