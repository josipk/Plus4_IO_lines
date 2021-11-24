/**********************************************
		Plus/4 Gpios v0.1
        @josip.kalebic
***********************************************/
.var PORT = $fd10
.var CHROUT = $ffd2
.var CHROUT2 = $ff4f

//sys 4096
*=$1000

mainProg: {	

	ldx #0
	sta counter

	lda #147
	jsr CHROUT	

init:
	lda #$1
	sta port_value

	ldx counter
	lda #$20
	sta $0C00,x

loop:
	ldx counter
	lda #$51
	sta $0C00,x

	lda counter
	sta $0800,x

	lda port_value
	sta PORT
	
	jsr setDelay

	lda port_value
	cmp #$80
	bcs init

	clc
	rol port_value

	lda #$20
	sta $0C00,x

	inc counter
	ldx counter
	cpx #8
	bcc continue1

	ldx #0
	stx counter

continue1:

	jmp loop

	rts
}	

setDelay:	{
	delay:
	  sta $40  
	  lda #$00
	  sta $41  
	delayloop:
	  adc #2
	  bne delayloop
	  clc
	  inc $41
	  bne delayloop
	  clc
	  lda $40  
	  rts
}

counter: .byte 0
port_value: .byte 0
