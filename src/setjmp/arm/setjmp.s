.global __setjmp
.global _setjmp
.global setjmp
.type __setjmp,%function
.type _setjmp,%function
.type setjmp,%function
__setjmp:
_setjmp:
setjmp:
	mov ip,r0
	stmia ip!,{v1,v2,v3,v4,v5,v6,sl,fp,sp,lr}
	mov r0,#0

	adr r1,1f
	ldr r2,1f
	ldr r1,[r1,r2]

	tst r1,#0x260
	beq 3f
	tst r1,#0x20
	beq 2f
	stc p2, c4, [ip], #48
2:	tst r1,#0x40
	beq 2f
    # Filcab: teensy's chip doesn't have an FPU
	#stc p11, c8, [ip], #64
2:	tst r1,#0x200
	beq 3f
	stcl p1, c10, [ip], #8
	stcl p1, c11, [ip], #8
	stcl p1, c12, [ip], #8
	stcl p1, c13, [ip], #8
	stcl p1, c14, [ip], #8
	stcl p1, c15, [ip], #8
3:	tst lr,#1
	moveq pc,lr
	bx lr

.hidden __hwcap
1:	.word __hwcap-1b
