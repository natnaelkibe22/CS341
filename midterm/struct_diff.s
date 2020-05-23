#struct_diff.s
# Apr 10, 2020

    .text
	.global struct_diff
struct_diff:
	pushl %ebp         #creating a stack frame
	movl %esp, %ebp    #copy stack pointer to ebp or set esp to ebp register
    movl 8(%ebp), %eax   # copy the first struct into eax register
    movl 12(%ebp), %edx  # copy the second struct into edx register
    movl (%eax), %ecx  #
    movl (%edx), %ebx
	cmpl %ecx, %ebx
	   jne notequal      #return if not equal
	add $4, %edx
	add $4, %eax
    movl $0, %ecx     # set up a counter
loopcompare: 
    movb (%eax), %cl  #
    movb (%edx), %dl
    cmpb %dl, %cl
      jne notequal
    cmpb $0, %dl     # is not the null terminator)
      jz done
    cmpb %dl, %cl        # if the character of first struct equals second struct jump loop
     je equal   
    cmpl 8(%ebp), %ecx   # if (counter < n)
      jae done 
    incl %ecx            #increment the counter
    incl %eax            # increment first struct pointer
    incl %edx            # increment second struct pointer
    jmp loopcompare

notequal:
   movl $1, %eax
   jmp done
equal:
   movl $0, %eax
done:
 movl %ebp, %esp
 popl %ebp
 ret
.end
