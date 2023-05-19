.data
	next_line: .asciiz "\n"	
.text
#input: N= how many numbers to sort should be entered from terminal. 
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


addi $s6,$s6,-1  # s6 is the counter (i) for the outer loop
addi $t1,$t1,-1  # t1 is the number of inputs(n). This step decrements 'n' by 1. Therefore t1 now stores 'n-1'

# Outer loop of bubble sort algorithm
outer_loop: move $t7,$t2  # Done so that t7 can be used for iterating over array elements in the inner loop
	    addi $s6,$s6,1    # incrementing the outer loop counter(i) = s6
	    beq $s6,$t1,end1  # condition for breaking the outer loop
		move $s4, $0
		move $s0, $t1
		sub $s0, $s0, $s6 # value of s0 is (n-i-1) to check upper bound for inner loop.
	    j loopi

# loopi = inner loop of bubble sort algorithm 
loopi: beq $s0,$s4,outer_loop # This step checks condition for breaking the inner loop.
       addi $s4, $s4, 1       # s4 is the counter (j) for the inner loop which is incremented in this step
       lw $t4,0($t7)          # t4 stores the value of arr[j]
	   addi $t7,$t7,4         
	   lw $s3, 0($t7)         # s3 stores the value of arr[j+1]
       slt $t5,$t4,$s3        # slt sets the value of t5 as '0' if t4 >= s3
       beq $t5,$0,swap        # swapping if t4 >= s3
       j loopi

# Swap Function
swap: move $t6,$s3        # The following three lines swap the values in registers t4 and s3 using a temporary register t6
	  move $s3,$t4
	  move $t4,$t6
	  addi $t7, $t7, -4   
	  sw $t4,0($t7)       # Storing the value of arr[j+1] (previously in s3) in 'j'th location
	  addi $t7, $t7, 4
	  sw $s3,0($t7)       # Storing the value of arr[j] (previously in t4) in 'j+1'th location
	  j loopi

end1:   move $s1,$0
        move $t7, $t3     # Storing the base address of output array in t7

# Following loop is used to store the sorted input array values into the output array
loop_ou: lw $t5,0($t2)    
         sw $t5,0($t3)
	 	beq $t1,$s1,end2  # s1 is the loop counter. This step is the the condition to break the loop
         addi $s1,$s1,1
		 addi $t3,$t3,4
		 addi $t2,$t2,4
		 j loop_ou

end2: move $s1,$0  
      move $t3, $t7    # t3 again stores the base address of output array.
      addi $t1,$t1,1   # This step increments t1 and hence now t1 is again equal to the number of inputs(n).


#endfunction

#print sorted numbers
move $s7,$zero	#i = 0
loop: beq $s7,$t1,end
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
