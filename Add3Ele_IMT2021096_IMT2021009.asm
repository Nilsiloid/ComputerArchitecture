.data
	next_line: .asciiz "\n"	
.text
#input: N= numbers that should be inputted should be a multiple of 3 
#It is stored in $t1	
jal input_int 
move $t1,$t4			

#input: X=The Starting address of input numbers (each 32bits) should be entered from
# terminal in decimal format. It is stored in $t2
jal input_int
move $t2,$t4

#input:Y= The Starting address of output numbers(each 32bits) should be entered
# from terminal in decimal. It is stored in $t3
jal input_int
move $t3,$t4 

#input: The numbers to be sorted are now entered from terminal.
# They are stored in memory array whose starting address is given by $t2
move $t8,$t2
move $s7,$zero	#i = 0
loop1:  beq $s7,$t1,loop1end
	jal input_int
	sw $t4,0($t2)
	addi $t2,$t2,4
      	addi $s7,$s7,1
        j loop1      
loop1end: move $t2,$t8       

	

move $t4,$t2  # Done to save base address of input array in t4 
move $s3,$t3  # Done to save base address of output array in s3
move $s0,$0   # Initializing value of s0. s0 acts as the loop counter (i)
move $s1,$0   # Initializing value of s1. s1 is used as counter for printing the output array.
addi $t1,$t1,-3  # t1 initially stores the number of input variables in input array (3*n). Now making value of t1 as (3*n-3)

loop_ou: lw $t5,0($t2)  # t5 = arr[i]
	  lw $t6,4($t2) # t6 = arr[i+1]
	  lw $t7,8($t2) # t7 = arr[i+2]
	  add $s2,$t5,$t6
	  add $s2,$s2,$t7  # s2 = arr[i] + arr[i+1] + arr[i+2]
	  bltz $s2,negate  # Condition to check if sum is less than zero
         sw $s2,0($t3)     # Storing the summation of 3 consecutive elements in output array
         addi $s1,$s1,1    # Incrementing s1
	 beq $t1,$s0,end2  # Exit condition for loop
        addi $s0,$s0,3
        addi $t3,$t3,4     
	addi $t2,$t2,12
        j loop_ou

# The following makes the value of s2 positive and stores it in output array (basically it is part of the big loop)
negate: negu $s2,$s2
        sw $s2,0($t3)     # Storing the summation of 3 consecutive elements in output array
         addi $s1,$s1,1    # Incrementing s1
	 beq $t1,$s0,end2  # Exit condition for loop
        addi $s0,$s0,3
        addi $t3,$t3,4     
	addi $t2,$t2,12
        j loop_ou

end2: move $t3,$s3  # Storing original base address of output array in t3
      move $t2,$t4  # Storing original base address of input array in t2
      addi $t1,$t1,3  # Making value of t1 as 3*n again

# Printing loop is changed so that printing happens according to value in s1.

#endfunction

#print numbers of aarray B.
move $s7,$zero	#i = 0
loop: beq $s7,$s1,end  # Printing happens according to value in s1
      lw $t4,0($t3)
      jal print_int
      jal print_line
      addi $t3,$t3,4
      addi $s7,$s7,1
      j loop 
#end
end:  li $v0,10
      syscall
#input from command line(takes input and stores it in $t6)
input_int: li $v0,5
	   syscall
	   move $t4,$v0
	   jr $ra
#print integer(prints the value of $t6 )
print_int: li $v0,1		#1 implie
	   move $a0,$t4
	   syscall
	   jr $ra
#print nextline
print_line:li $v0,4
	   la $a0,next_line
	   syscall
	   jr $ra

