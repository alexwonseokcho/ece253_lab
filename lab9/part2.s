.data

#Messages
msg_1: .asciz "Please take a deep breath"
msg_2: .asciz "Please drink some water"
msg_3: .asciz "Please give your eyes a break"

#Timer Related
timeNow: .word 0xFFFF0018 #current time
cmp: .word 0xFFFF0020 #time for new interrupt

.text

#Display related
.eqv OUT_CTRL 0xFFFF0008
.eqv OUT 0xFFFF000C

main:
	la s0, cmp
	lw s0, 0(s0) 
	li s1, 5000 #5000 milliseconds
	sw s1, 0(s0) #set timer value for interrupt
	#set up interrupts
	la t0, timer_handler
	csrrw zero, utvec, t0 #set utvec to handler address
	
	csrrsi zero, ustatus, 0x1 #set interrupt enable bit
	csrrsi zero, uie, 0x10 #set bit 4 in uie to enable timer interrupt
	
	addi s3, zero, 1 #flag to print to ASCII - print as soon as the program starts
	addi s4, zero, 0 #index 0 is the first message, 1, is the second, and 2 is the third
	
LOOP:
	beqz s3, LOOP 
	#if the flag is raised, then print, and lower flag
	
	lw s6, OUT_CTRL #check ready signal of display
	andi s7, s6, 0x1 #only keep 1 bit
	beqz s7, LOOP #go back if s
	
	
	la s8, msg_1
	beqz s4, LOOP_WORD
	
	addi t1, zero, 1
	la s8, msg_2
	beq s4, t1, LOOP_WORD
	
	la s8, msg_3





LOOP_WORD: #until byte loaded is 00 (null terminator)
	lb s9, 0(s8) #value of the character
	beqz s9, DONE_LOOPING_WORD
	li s10, OUT
	sw s9, 0(s10)  #store the data to the display
	addi s8, s8, 1
	j LOOP_WORD
	
DONE_LOOPING_WORD:
	addi s3, zero, 0
	
	j LOOP

timer_handler:
	addi sp, sp, -4
	sw t0, 0(sp)
	
	addi s3, zero, 1 
	
	lw t0, 0(sp)
	addi sp, sp, 4
	
	#li a2, 5000 
	#lw a3, timeNow
	li a3, 0xFFFF0018
	lw a2, 0(a3) #value of the current count
	li a6, 5000
	
	addi s4, s4, 1 #increment which message to print out
	addi a7, zero, 3 #compare to 3
	blt s4, a7, SKIP_SETTING_ZERO
	
	addi s4, zero, 0
	
SKIP_SETTING_ZERO:
	add s1, a2, a6 #5000 milliseconds
	li s0, 0xFFFF0020  #load address didn't work for some reason??
	sw s1, 0(s0)
	uret 
	
	
	
	
