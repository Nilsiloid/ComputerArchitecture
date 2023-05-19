.globl main

.equ N, 10


.text
main:
    li t0, 0x80001400   # li(load immediate) stores base address of array A.
    li t1, 0x80001500   # li(load immediate) stores base address of array B.
    li t2, 0x80001600   # li(load immediate) stores base address of array C.
    mv s5, zero         # mv instruction stores 0(zero) in register s5.
    addi s3, s3, N      # addi(add immediate) adds N, the number of elements in array, to register s3.
    mv t3,t0            # registers t3 and t4 store value in t0 and t1 respectively, i.e. base addresses of arrays A and B.
    mv t4,t1            # these are then used to restore the values into t0 and t1 after elements are added to array.

    addi t5, t5, 9      # t5 contains the input for A.
    sw t5, 0(t0)        # stores value of A in memory location pointed by value in t0.
    mv t5, zero         # resets t5 to 0 to receive input of B.
    addi t5, t5, 3      # t5 stores input of B and then proceeds to do the same as previous 3 instructions.
    sw t5, 0(t1)
    mv t5, zero
    addi t0, t0, 4      # increments t0 and t1 value by 4 to move to next location to where we want to store A and B respectively.
    addi t1, t1, 4

    # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    addi t5, t5, 12     # the next 9 blocks of such instructions take input for array A and array B.
    sw t5, 0(t0)        # these blocks of code take input of 10 'A's and 10 'B's.
    mv t5, zero
    addi t5, t5, 7
    sw t5, 0(t1)
    mv t5, zero
    addi t0, t0, 4
    addi t1, t1, 4

    # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    addi t5, t5, 2
    sw t5, 0(t0)
    mv t5, zero
    addi t5, t5, 8
    sw t5, 0(t1)
    mv t5, zero
    addi t0, t0, 4
    addi t1, t1, 4

    # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    addi t5, t5, 13
    sw t5, 0(t0)
    mv t5, zero
    addi t5, t5, 26
    sw t5, 0(t1)
    mv t5, zero
    addi t0, t0, 4
    addi t1, t1, 4

    # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    addi t5, t5, 30
    sw t5, 0(t0)
    mv t5, zero
    addi t5, t5, 29
    sw t5, 0(t1)
    mv t5, zero
    addi t0, t0, 4
    addi t1, t1, 4

    # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    addi t5, t5, 69
    sw t5, 0(t0)
    mv t5, zero
    addi t5, t5, 23
    sw t5, 0(t1)
    mv t5, zero
    addi t0, t0, 4
    addi t1, t1, 4

    # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    addi t5, t5, 3
    sw t5, 0(t0)
    mv t5, zero
    addi t5, t5, 2
    sw t5, 0(t1)
    mv t5, zero
    addi t0, t0, 4
    addi t1, t1, 4

    # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    addi t5, t5, 4
    sw t5, 0(t0)
    mv t5, zero
    addi t5, t5, 16
    sw t5, 0(t1)
    mv t5, zero
    addi t0, t0, 4
    addi t1, t1, 4

    # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    addi t5, t5, 16
    sw t5, 0(t0)
    mv t5, zero
    addi t5, t5, 30
    sw t5, 0(t1)
    mv t5, zero
    addi t0, t0, 4
    addi t1, t1, 4

    # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    addi t5, t5, 25
    sw t5, 0(t0)
    mv t5, zero
    addi t5, t5, 75
    sw t5, 0(t1)
    mv t5, zero
    addi t0, t0, 4
    addi t1, t1, 4

    # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    
    mv t0, t3       # mv instruction resets t0 and t1 to the base addresses of arrays A and B, which are stored in t3 and t4.
    mv t1, t4

    inp:
        lw s6,0(t0)     #lw(load word) instruction stores A in register s6.
        lw s1,0(t1)     #lw(load word) instruction stores B in register s1.

    loop:
        beq s6, zero, end1 # stores value of B in array C. Is exit condition for loop.
        beq s1, zero, end2 # stores value of A in array C.
        bge s6, s1, L1  # checks for A>=B
        rem s4, s1, s6  # if A<B, rem instruction causes register s4 to store s1%s6, i.e., remainder obtained on dividing value in s1 by value in s6.
        mv s1, s4       # mv instruction stores the value in s4 back into register s1, thus causing B=B%A to be implemented.
        j loop          # jumps back to loop to implement set of instructions again until it exits to either end1 or end2.


    L1:                 # if A>=B, we come to L1 loop.
        rem s4, s6, s1  # similar to the previous set of instructions for B=B%A, this line and the next implements A=A%B.
        mv s6, s4
        j loop          #jumps back to loop to implement set of instructions again until it exits to end1 or end2.

    
    end1:                   # end1 is used to store B in array C(B here is the GCD of original A and B). This is the exit condition for loop.
        sw s1, 0(t2)        # we store the GCD value(here B) at the address given by t2.
        beq s5, s3, DONE    # checking condition to see if all integers in the array have been used up. stops at s5=N condition.
        addi t0, t0, 4      # the following 3 lines increment the address stored in t0, t1, t2 by 4. This causes the next A,B to be the values in the next location of the arrays.
        addi t1, t1, 4
        addi t2, t2, 4
        addi s5, s5, 1      # incrementing counter, i.e, s5 by 1. s5 is used to check for terminating condition of our code. code must exit when value in s5 equals N.
        j inp               # jumps back to inp loop to store new A and B.

    end2:                   # end2 is used to store A in array C(A here is the GCD of original A and B). Again, this is the exit condition for loop.
        sw s6, 0(t2)        # we store the GCD value(here A) at the address given by t2.
        beq s5, s3, DONE    # checking condition to see if all integers in the array have been used up. stops at s5=N condition.
        addi t0, t0, 4      # the following 3 lines increment the address stored in t0, t1, t2 by 4. This causes the next A,B to be the values in the next location of the arrays.
        addi t1, t1, 4
        addi t2, t2, 4
        addi s5, s5, 1      # incrementing counter, i.e, s5 by 1. s5 is used to check for terminating condition of our code. code must exit when value in s5 equals N.
        j inp               # jumps back to inp loop to store new A and B.

    DONE:           # end condition for code.
    j .
.end