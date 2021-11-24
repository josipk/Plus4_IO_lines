/**********************************************
		Plus/4 Gpios v0.1
        @josip.kalebic
***********************************************/
.var PORT = $fd10
.var CHROUT = $ffd2
.var CHROUT2 = $ff4f

//sys 4096
*=$1000

mainProg: {		// <- Here we define a scope


	ldx #0
	sta counter

	lda #147
	jsr CHROUT

init:
	lda #$1
	sta port_value

loop:

	lda port_value
	sta PORT

	jsr populateStatus

	jsr printStatus

	inc port_value

	jsr setDelay

	jmp loop



	rts
}	

printStatus: {

	ldx #7
	ldy #0

loop2:

	lda #$51
	sta $0c00,x

	lda status,y 
	sta $0800,x

	cpy #7
	bcs endloop2

	clc
	
	dex

	iny

	jmp loop2

endloop2:
	rts

}



populateStatus: {

		ldx #1
		stx tmpval
		ldx #0

	loop3:
		lda port_value
		and tmpval
		cmp tmpval
		bne next1
		
		lda #100
		sta status, x

		jmp next12

	next1:		

		lda #1
		sta status, x

	next12:

		inx
		cpx #8
		bcs endloop3

		rol tmpval
		jmp loop3

	endloop3:

		rts


}


setDelay:	{
	delay:
	  sta $40  
	  lda #$80
	  sta $41  
	delayloop:
	  adc #01
	  bne delayloop
	  clc
	  inc $41
	  bne delayloop
	  clc
	  lda $40  
	  rts
}

tmpval: .byte 0
counter: .byte 0
port_value: .byte 0
status: .byte $1, $1, $1, $1, $1, $1, $1, $1
