#include<bits/stdc++.h>
using namespace std;

int main(){
    int arr[6]={34, 68, 57, 169, 96, 102};
    int min=25000, sum=0;

    if(min-arr[0]>0){
        min=arr[0];
    }
    if(min-arr[1]>0){
        min=arr[1];
    }
    if(min-arr[2]>0){
        min=arr[2];
    }
    if(min-arr[3]>0){
        min=arr[3];
    }
    if(min-arr[4]>0){
        min=arr[4];
    }
    if(min-arr[5]>0){
        min=arr[5];
    }

    sum=arr[0]+arr[1]+arr[2]+arr[3]+arr[4]+arr[5];

    cout<<"Minimum number in array is: "<<min<<endl;
    cout<<"Sum of elements in the array is: "<<sum<<endl;
}