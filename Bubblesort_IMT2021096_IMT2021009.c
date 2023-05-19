// #define GPIO_SWs 0x80001400
#define GPIO_LEDs 0x80001400   // we have defined GPIO_LEDs to store base address of array.
#define GPIO_Sorted 0x80001500 // GPIO_Sorted stores the base address of array after sorting.
// #define GPIO_INOUT 0x80001408

#define READ_GPIO(dir) (*(volatile unsigned *)dir)
#define WRITE_GPIO(dir, value)               \
   {                                         \
      (*(volatile unsigned *)dir) = (value); \
   }

#if defined(D_NEXYS_A7)
#include <bsp_printf.h>
#include <bsp_mem_map.h>
#include <bsp_version.h>
#else
PRE_COMPILED_MSG("no platform was defined")
#endif
#include <psp_api.h>

#define N 10 // N here is the number of integers to be stored in the array. Since question needs array to be of size 10, we have intitialized N to 10.

int main()
{
   int A[N] = {9, 42, 13, 164, 68, 96, 29, 50, 65, 31}; // We have used a testcase with random integers.
   int i;

   /* Initialize Uart */
   uartInit();


   for (i = 0; i < N; i++)
   {
      int memory = GPIO_LEDs + i; // memory variable is used to store the memory location at which A[i] must be stored.
      WRITE_GPIO(memory, A[i]);   // this line of code writes the value of A[i] at the memory location memory.
   }

   for (i = 0; i < N; i++) // Bubble sort algorithm to sort the array.
   {
      for (int j = 0; j < N - i - 1; j++)
      {
         if (A[j] > A[j + 1])
         {
            int temp = A[j + 1]; // swaps the adjacent elements if in decreasing order.
            A[j + 1] = A[j];
            A[j] = temp;
         }
      }
   }

   for (i = 0; i < N; i++)
   {
      int memory = GPIO_Sorted + i; // memory variable is used to store the memory location at which A[i] must be stored.
      WRITE_GPIO(memory, A[i]);     // this line of code writes the value of A[i] at the memory location memory.s
   }
}
