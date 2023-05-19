# Assignment 3 - Question 2a
# Done by : Nilay Kamat(IMT2021096), Madhav Sood(IMT2021009) and Anuj Arora(IMT2021050)

with open('file0.trace', 'r') as f:
    f_contents = f.readlines()

# print(type(f_contents))

# First we consider the "Always predict TAKEN" branch predictor.
# The miss rate for this predictor will be the number of times the prediction is wrong, i.e. the branch should be NOT TAKEN.
ctr_NT = 0

for ele in f_contents:
    if 'N' in ele:  # if the line in the trace file containing the branch outcomes shows "N", this implies that our predicition is wrong.
        ctr_NT += 1   # hence we increment the number of wrong predictions, here "N" by 1.

# Since we need the mis-prediction rate and not the exact count, we update ctr_NT to the required value.
ctr_NT = ctr_NT * 100 / len(f_contents)

print(f'{ctr_NT}% is the mis-prediction rate for always predict TAKEN branch predictor.\n')

# Second we consider the "Always predict NOT TAKEN" branch predictor.
# Here the miss rate is the number of times the branch is TAKEN, i.e, T.
ctr_T = 0

for ele in f_contents:
    if 'T' in ele:  # Similar to previous case but here we check for "T".
        ctr_T += 1

ctr_T = ctr_T * 100 / len(f_contents)

print(f'{ctr_T}% is the mis-prediction rate for always predict NOT TAKEN branch predictor.\n')

# A branch predictor's accuracy is determined by its mis-prediction rate(or %age).
# If the "Always TAKEN" branch predictor has a lower mis-prediction rate then the "Always NOT TAKEN" predictor is more accurate and vice versa.

if ctr_NT>ctr_T:
    print("'Always predict not taken' branch predictor is better.")
    
else:
    print("'Always predict taken' branch predictor is better.")



# The following segment of code is to create and append to the output file "IMT2021009_IMT2021050_IMT2021096_output_2a.txt".
# The output file has the mis-prediction rate for the "Always Taken" and "Always Not Taken" predictors.

with open('IMT2021009_IMT2021050_IMT2021096_output_2a.txt', 'a') as f_out:
    f_out.write("-------------------------------------------------------------------------------------------------------\n")
    f_out.write(f'{ctr_NT}% is the mis-prediction rate for always predict TAKEN branch predictor.\n')
    f_out.write(f'{ctr_T}% is the mis-prediction rate for always predict NOT TAKEN branch predictor.\n')
    f_out.write("-------------------------------------------------------------------------------------------------------\n")