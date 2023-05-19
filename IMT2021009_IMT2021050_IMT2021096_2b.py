# Assignment 3 - Question 2a
# Done by : Nilay Kamat(IMT2021096), Madhav Sood(IMT2021009) and Anuj Arora(IMT2021050)



with open('file0.trace', 'r') as f:     # opens the trace file for reading, f_contents is a list of all the elements in the...
    f_contents = f.readlines()          # trace file, i.e, the address and the branch outcome.

def getBinary_32(num):     #function to convert number to its binary equivalent. also converts it into its 32 bits equivalent.
    s=bin(num)
    s=s[2:]
    ctr=32-len(s)
    while(ctr!=0):
        s="0"+s         #to add 0's to make the binary equivalent a 32 bit equivalent.
        ctr-=1
    return s

def BinaryToDecimal(num):       # function to convert a binary string to the decimal equivalent and return the integer value.
    a=int(num,2)
    return a

def getIndex(num, bits):        # function to get the index bits from the 32-bit binary address given. The index bits are then converted into decimal...
    return num[len(num)-bits:]  # value to check with the key value in predictor list given in the next segment of the code.

index_size=2        # index_size stores the number of index bits. Initially the number of index bits is 2, thus index_size is 2.
while(index_size!=21):  # We have to evaluate the miss rate for index bits being 2 till 20. Thus, we ran a while loop to evaluate all the miss rates of the Branch Predictor.

    count_correctP=0    # stores the number of predictions which turned out to be correct.
    count_wrongP=0
    predictor = []      # List which has dictionaries of decimal value of index bits as key and the prediction for that index bit as the value.

    for i in range(0, 2**index_size):
        predictor.append({i:0})     # Sets the initial value of prediction to be strongly taken.

    for ele in f_contents:
        
        space_index = ele.find(' ') # finds the index of the whitespace in every line of the trace file to differentiate between the address and the branch outcome.
        address=ele[:space_index]   # stores the given address by slicing the string until the whitespace.
        bit_address = getBinary_32(int(address))    # converts the given address into its binary equivalent using getBinary
        index = BinaryToDecimal(getIndex(bit_address, index_size))
        # index stores the value corresponding to which we have to check for Strongly Taken, Weakly Taken, Weakly Not Taken or Strongly Not Taken.
        # We have assigned the following for branch predictor states.
        # 0 - Strongly Taken
        # 1 - Weakly Taken
        # 2 - Weakly Not Taken
        # 3 - Strongly Not Taken



        # If the branch outcome value is T, then we check the corresponding value in the dictionary(in predictor list) whose key value is the index found previously.
        # we increment the correct prediction counter if the prediction is true, else we increment wrong prediction counter.
        if 'T' in ele:
            if predictor[index][index]==0 or predictor[index][index]==1:
                count_correctP+=1
            else:
                count_wrongP+=1

            if predictor[index][index]!=0:  # If the predictor has anything other than Strongly Taken, we decrement it by 1.
                predictor[index][index]-=1

        # If the branch outcome value is N, then we check the corresponding value in the dictionary(in predictor list) whose key value is the index found previously.
        # we increment the correct prediction counter if the prediction is true, else we increment wrong prediction counter.
        elif 'N' in ele:
            if predictor[index][index]==2 or predictor[index][index]==3:
                count_correctP+=1
            else:
                count_wrongP+=1

            if predictor[index][index]!=3: # If the predictor has anything other than Strongly Not Taken, we decrement it by 1.
                predictor[index][index]+=1

    miss_rate = (100*count_wrongP)/(count_correctP+count_wrongP)    # calculating miss and hit rate for the predictor.
    hit_rate= (100*count_correctP)/(count_correctP+count_wrongP)
    pred_size = 2**index_size   # pred_size stores the size of the predictor.

    print("-------------------------------------------------------------------")
    print(f'Predictor Size = {pred_size}')
    print(f'Number of Index Bits = {index_size}')
    print(f'Miss Rate is {miss_rate}%')
    print(f'Hit Rate is {hit_rate}%')
    print("-------------------------------------------------------------------")


# The following segment of code is to create and append to the output file "IMT2021009_IMT2021050_IMT2021096_output_2b.txt".
# The output file has the predictor size, number of index bits, miss rate and hit rate for each of the different branch predictors.

    with open('IMT2021009_IMT2021050_IMT2021096_output_2b.txt', 'a') as f_out:
        f_out.write("-------------------------------------------------------------------\n")
        f_out.write(f'Predictor Size = {pred_size}\n')
        f_out.write(f'Number of Index Bits = {index_size}\n')
        f_out.write(f'Miss Rate is {miss_rate}%\n')
        f_out.write(f'Hit Rate is {hit_rate}%\n')
        f_out.write("-------------------------------------------------------------------\n")


    index_size+=1