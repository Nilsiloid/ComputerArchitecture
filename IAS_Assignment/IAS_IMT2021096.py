def getBinary_12(num):     #function to convert number to its binary equivalent. also converts it into its 12 bits equivalent.
    s=bin(num)
    s=s[2:]
    ctr=12-len(s)
    while(ctr!=0):
        s="0"+s         #to add 0's to make the binary equivalent a 12 bit equivalent.
        ctr-=1
    return s

def getBinary_40(num):      #function to convert number to its binary equivalent. also converts it into its 40 bits equivalent.
    s=bin(num)
    s=s[2:]
    ctr=40-len(s)
    while(ctr!=0):
        s="0"+s         #to add 0's to make the binary equivalent a 40 bit equivalent.
        ctr-=1
    return s

def getDecimal(string):     #function to convert a binary number to its decimal equivalent.
    num=int(string[0:len(string)+1],2)
    return num
    
def getInstruction(string):     #obtains the instruction based on its corresponding opcode.
    Instructions={              #the instructions I used in my code are listed below. (did not use MUL and DIV but listed them.)
        "LOAD":"00000001",
        "STOR":"00100001",
        "ADD":"00000101",
        "SUB":"00000110",
        "MUL":"00001011",
        "DIV":"00001100",
        "JUMP+":"00001111",
        "JUMP":"00001101"
    }
    for k,v in Instructions.items():        #to return the corresponding instruction.
        if k==string:
            return v

def execute(memory):        #executes all the instructions and performs the necessary actions.
    global AC
    global PC
    AC=0
    while(memory[int(PC)]!=("0")*40):       #while terminating condition isn't met, i.e., user doesnt enter stop.
    
        print("PC =", PC)
        temp=PC
        MAR=PC
        MBR=memory[MAR]
        print("MBR =", MBR, end=" ")
        IR=MBR[0:8]
        print("IR =", IR, end=" ")
        MAR=MBR[8:20]
        print("MAR =", MAR, end=" ")
        IBR=MBR[20:40]
        print("IBR =", IBR, end=" ")
        if(IR=="00000001"):                             #executing LHS part of instruction.
            load(getDecimal(memory[getDecimal(MAR)]))
        elif(IR=="00000101"):
            add(getDecimal(memory[getDecimal(MAR)]))
        elif(IR=="00100001"):
            stor(getDecimal(MAR))
        elif(IR=="00000110"):
            sub(getDecimal(memory[getDecimal(MAR)]))
        elif(IR=="00001111"):
            jump_plus(getDecimal(MAR))
            # continue

        if(temp==PC):           #condition to check if jump statement was used. if not, RHS part of instruction will be executed.
            IR=IBR[0:8]
            print("IR =", IR, end=" ")
            MAR=IBR[8:20]
            print("MAR =", MAR, end=" ")
            if(IR=="00000001"):
                load(getDecimal(memory[getDecimal(MAR)]))
            elif(IR=="00000101"):
                add(getDecimal(memory[getDecimal(MAR)]))
            elif(IR=="00100001"):
                stor(getDecimal(MAR))
            elif(IR=="00000110"):
                sub(getDecimal(memory[getDecimal(MAR)]))
            elif(IR=="00001101"):
                jump(getDecimal(MAR))
                # continue

        if(temp==PC):       #increments PC by 1 if jump conditions have not been used.
            PC+=1

        print()


def load(num):      #function to Load value into Accumulator(AC).
    global AC
    if(num>=2**40):
        print("Overflow error!")
        quit()
    AC=num
    #print("AC =", AC)

def add(num):       #function to add value to Accumulator value(AC).
    global AC
    AC=AC+num
    if(AC>=2**40):
        print("Overflow error!")
        quit()
    #print("AC =", AC)

def stor(val):      #function to store value in Accumulator(AC) to provided memory location.
    global AC
    memory[int(val)]=getBinary_40(AC)
    #print("value stored in memory location", int(val), "is", getDecimal(memory[int(val)]))
    #print(memory)

def sub(num):       #function to subtract value from Accumulator(AC).
    global AC
    AC=AC-num
    #print("AC =", AC)

def jump_plus(num):     #function to jump to certain line of instruction if value in AC>0
    global AC
    global PC
    if AC>0:
        PC=num

def jump(num):      #function to jump to certain line of instruction irrespective of condition/scenario.
    global PC
    PC=num


flg=False
memory={}
PC=0
while(1):           #assesses user input and stores into memory. figures out the various instructions inputted.
    lst=list(input().split())
    if(lst[1]=="begin"):
        flg=True
        PC=int(lst[0])+1
        continue
    if(lst[1]=="stop"):
        memory[int(lst[0])]="0"*40
        break
    if(flg==False):
        memory[int(lst[0])]=getBinary_40(int(lst[1]))


    else:           #Assembler, reads the input sent as assembly language and stores in memory in binary.
        if(len(lst)>3):
            if(getInstruction(lst[1])=="00001111" and getInstruction(lst[3])=="00001101"):
                memory[int(lst[0])]=getInstruction(lst[1])+getBinary_12(int(lst[2][2:-6]))+getInstruction(lst[3])+getBinary_12(int((lst[4])[2:-6]))

                
            # elif(getInstruction(lst[1])=="00001111" or getInstruction([lst[1]])=="00001101"):
            #     memory[int(lst[0])]=getInstruction(lst[1])+getBinary_12(int(lst[2][2:-6]))+getInstruction(lst[3])+getBinary_12(int((lst[4])[2:-1]))
            # elif(getInstruction(lst[3])=="00001111" or getInstruction([lst[3]])=="00001101"):
            #     memory[int(lst[0])]=getInstruction(lst[1])+getBinary_12(int((lst[2])[2:-1]))+getInstruction(lst[3])+getBinary_12(int(lst[4][2:-6]))
            
            else:
                memory[int(lst[0])]=getInstruction(lst[1])+getBinary_12(int((lst[2])[2:-1]))+getInstruction(lst[3])+getBinary_12(int((lst[4])[2:-1]))
        
        
        else:
            temp="0"*20
            if(getInstruction(lst[1])=="00001111" or getInstruction([lst[1]])=="00001101"):
                memory[int(lst[0])]=temp+getInstruction(lst[1])+getBinary_12(int(lst[2][2:-6]))
            else:
                memory[int(lst[0])]=temp+getInstruction(lst[1])+getBinary_12(int(lst[2][2:-1]))

print("Initial memory is as follows:")
print(memory)       #printing memory before any instructions is executed.
execute(memory)     #starting execution of instructions.
print("Minimum number in array is:", getDecimal(memory[6]))     #prints the minimum no. from array of 6 integers.
print("Sum of elements of array is:", getDecimal(memory[7]))    #prints the sum of the elements in the array.
print("Final memory is as follows:")
print(memory)       #printing memory after all instructions are executed.