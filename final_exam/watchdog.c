/* Write a watch dog function to get a program
   out of an infinite loop
    Program: watchdog.c
    Build:   make watchdog.lnx
    Date:  May 5, 2020
*/

#include <stdio.h>
void build_a_product(void);
void delay(void);

int count;
//resets all the CPU by internally calling assembly code reboot.s
extern void reboot(void);
int main(void)
{
  inittimer();
  printf("reboot...\n");
  /* build product continuously */
  for (; ; ){
     build_a_product();
     kick_watchdog();
  }
  return 0;
}

/* buggy build product function */
void build_a_product(void)
{
  count++;
  printf("build item number = %d\n", count );
  delay();
  /* infinite loop bug */
  while(count >= 50) {
  }
}
void kick_watchdog(void) {
     shutdowntimer();  // this line turns off the timer before 55 msec
     inittimer();    // and this line will turn back the timer on for another 55 msec
}
/* artificial delay function to simulate
   product build times */
void delay(void)
{
  int i,j;
  for (i=0; i<1000; i++)
  {
     for (j=0; j <1000; j++) ;
  }
}
