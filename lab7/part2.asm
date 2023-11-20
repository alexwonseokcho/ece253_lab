#Program that counts consecutive 1's.
.global _start
.text

_start: 
	la s2, LIST #load the memory address into s2
	lw s3, 0(s2)
	addi s4, zero, 0 #register s4 holds result
	
LOOP:
	beqz s3, END #Loop until data contains no more 1's (Branch if s3 is equal to 0
	srli s2, s3, 1 #SHIFT RIGHT logical 
	and s3, s3, s2 #bitwise and operation
	addi s4, s4, 1 #increment s4 (count)
	b LOOP
	
END:
	ebreak
	
 .global LIST
 .data
 LIST:
 .word 0x103fe00f
 
 #0001 0000 0011 1111 1110 0000 0000 1111