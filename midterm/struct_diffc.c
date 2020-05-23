/* Program to diff 2 structs     */
/*                               */
/*     calling convention:       */
/* struct_diff(data *,  data *); */
/*                               */
#include <stdio_1.h>
typedef struct{int i; char * p;} data;
extern int struct_diff(data *, data *);

int main(){
  data abc={15, "this is good"};
  data def={15, "I am great"};
  
   /* use inline assembly to define a  */
   /* global label similar to label:   */
    asm("label: .global label");
    if (struct_diff(&abc, &def))
      printf("The structs are not the same\n");
    else 
      printf("The structs are equal\n");
    return 0;
}
