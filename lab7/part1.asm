.global _start
.text

_start:
	la s2, LIST
	addi s10, zero, 0
	addi s11, zero, 0
	
#Code here

la s1, LIST #s1 = address of LIST
addi s3, zero, -1 #for comparison

LOOP1: lw s2, 0(s1) #s2 = mem[List[i]] = 1

#if loaded thing is -1, jump to end

beq s2, s3, END 

addi s11, s11, 1
add s10, s10, s2
addi s1, s1, 4
j LOOP1


END:
	ebreak
	
.global LIST
.data
LIST:
.word 1, 2, 3, 5, 0XA, -1
