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
	lda #$00
	sta port_value

	lda #$00
	sta direction

loop:

	lda port_value
	sta PORT

	jsr clearStatus

	jsr populateStatus

	jsr printStatus

	//----manipulate with bits	

	lda port_value
	cmp #$00
	bne continue11    

	lda #$00
	sta direction
    
continue11:
    
    
	lda port_value
	cmp #$ff
	bne continue12    

	lda #$01
	sta direction
    
continue12:

	ldx direction
	cpx #$01
	beq direction_to_left

	sec
	rol port_value  

	jmp continue3	

direction_to_left:
	clc
	ror port_value  

continue3:

	jsr setDelay

	jmp loop



	rts
}	

printStatus: {

	ldx #0

loop2:

	lda #$51
	sta $0c00,x

	lda status,x 
	sta $0800,x


	cpx #7
	bcs endloop2

	inx 

	jmp loop2

endloop2:
	rts

}

clearStatus: {

	ldx #0

loop22:
	lda #$1
	sta status,x

	cpx #7
	bcs endloop22

	inx 

	jmp loop22

endloop22:
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

	next1:		

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
	  lda #$00 	
	  sta $40  
	  lda #$a0
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
direction: .byte 0 
counter: .byte 0
port_value: .byte 0
status: .byte $1, $1, $1, $1, $1, $1, $1, $1
