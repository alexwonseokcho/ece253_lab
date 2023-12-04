.global _start
.text

_start: 
	li s0, 0xffff0004 #Receiver data register 
	li s1, 0xffff0000 #Receiver control register
	
	li s2, 0xffff0008 #Transmitter control register
	li s3, 0xffff000c #Transmitter data register (lowest 8 bits)
	

POLL: 
	lw s5, 0(s1) #ready bit
	andi s6, s5, 0x1 #only keep the last bit alive
	beqz s6, POLL#if ready bit is 0, then go back to POLL
	
	lw s5, 0(s0) #data
	
	lw s6, 0(s2) #check ready signal of display
	andi s7, s6, 0x1 #only keep 1 bit
	beqz s7, POLL
	
	sw s5, 0(s3)  #store the data to the display
	
	j POLL #go back to loop again
	

END: ebreak
