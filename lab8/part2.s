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
	
	lw a0, 0(s0) #value of the first element (change to the address of it instead)
	
	
	addi s0, s0, 4
	addi s2, s2, -1
	j SUBLOOP
	
	
DONE_SUB_LOOP:
	
	addi s1, s1, -1 #decrement by 1
	
	j LOOP

SWAP: 


	jr ra 


END:
	ebreak
	
.global LIST
.data
LIST:
.word 4, 1, 2, 3, 4
#1400, 45, 23, 5, 3, 8, 17, 4, 20, 33