#Program that counts consecutive 1's.
.global _start
.text

_start: #start code here
	la s2, LIST #address of LIST in s2 now
	addi s1, zero, -1 #load s1 with -1 to compare
	addi s10, zero, 0 #load s10 with zero for the final result
	
LOOP_MAIN:
	lw a1, 0(s2) #s0 = mem[s2] value of the element
	
	beq a1, s1, END #end if loaded element is -1 
	
	
	#loaded up parameter for the element on line 10
	jal ONES
	
	blt a0, s10, SKIPPED
	
	add s10, a0, zero #update s10 if the new result a0 is bigger. Otherwise, skip to SKIPPED:

	
	SKIPPED: addi s2, s2, 4 #increment to the next element
	
	
	j LOOP_MAIN
	

ONES: 
	addi sp, sp, -4
	sw ra, 0(sp)
	#the element will be loaded through through a1
	#lw a1, 0(a0) # value of that element is in a1 now
	addi a0, zero, 0 #register s4 holds result
	
LOOP_ONES:
	beqz a1, END_ONES #Loop until data contains no more 1's (Branch if s3 is equal to 0
	
	#save the registers to be used to stack
	
	srli a2, a1, 1 #SHIFT RIGHT logical 
	and a1, a1, a2 #bitwise and operation
	addi a0, a0, 1 #increment s4 (count)
	
	#restore used registers from stack
	
	b LOOP_ONES

END_ONES: 
lw ra, 0(sp)
addi sp, sp, 4
jr ra

END: ebreak
	
 .global LIST
 .data
 LIST:
 .word 0x103fe00f, 0x00000001, 0x0FFFFFFF, 0x0FFFF000, 0x00000000, -1
 #0x103fe00f,
 #0x0FFFF000, 
 #0001 0000 0011 1111 1110 0000 0000 1111
