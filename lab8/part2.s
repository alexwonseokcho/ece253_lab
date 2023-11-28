.global _start
.text

_start:	#take in list, then set a register to the first number, which gives the number of times we iterate through the list. We decrement this by one, and exit if it's equal to 0
	la s0, LIST
	lw s1, 0(s0) #this is the counter that will decremenet and loop over the list n times
	
	
LOOP:
	beqz s1, END #if we run through the whoe list n times, we end the program
	
	#set address back to the first one again 
	la s0, LIST
	lw s2, 0(s0) #sub counter that decrements and loops over the list n times
	addi s2, s2, -1 #since 0th element is useless to us
	
	
	addi s0, s0, 4 #1st element (first actual useful value)
	
SUBLOOP:
	beqz s2, DONE_SUB_LOOP
	
	add a0, zero, s0 #address of the left element
	
	jal SWAP
	
	addi s0, s0, 4
	addi s2, s2, -1
	j SUBLOOP
	
	
DONE_SUB_LOOP:
	
	addi s1, s1, -1 #decrement by 1
	
	j LOOP

SWAP: 
	addi sp, sp, -4
	sw ra, 0(sp)
	
	# a0 houses the address of the element and 4(a0) is the addr of next element
	add a3, a0, zero
	lw a5, 0(a3)
	lw a6, 4(a3) 
	
	addi a0, zero, 0
	blt a5, a6, SKIP_SWAP
	
	#Swapping code
	addi a0, zero, 1
	
	sw a6, 0(a3)
	sw a5, 4(a3)
	
	SKIP_SWAP: 
	lw ra, 0(sp)
	addi sp, sp, 4
	jr ra 

	

END:
	ebreak
	
.global LIST
.data
LIST: 13, 1400, 45, 23, 5, 3, 8, 17, 4, 20, 33, 203230, 23010, 0
.word
# 4, 4, 3, 2, 1
#1400, 45, 23, 5, 3, 8, 17, 4, 20, 33