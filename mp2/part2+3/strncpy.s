# strcpy.s
#Natnael Kibe
#Apr 1, 2020
	.text
	.global mystrncpy
mystrncpy:
	pushl %ebp         #creating a stack fram
	movl %esp, %ebp    #set esp to ebp register
	subl $8, %esp       #subl $8, %esp
	movl 8(%ebp), %ecx     #setting ebp to ecx
	movl %ecx, -8(%ebp)    #movl %ecx, -8(%ebp)
	movl 12(%ebp), %eax
    movl %eax, -4(%ebp)    #movl %eax, -4(%ebp)
    movl 16(%ebp), %ebx    #new cod
    movl %ebx, -12(%ebp)
	# deleted line xor %edx, %edx
	jmp str
str:                #string copy operation
	movzbl (%eax), %edx
	movl %dl, (%ecx)   #  movb %dl, (%ecx)
	testl %dl, %dl
	je endline
	incl %eax
	incl %ecx
	decl %ebx
	cmpl $0, %ebx
	jnz str
endline:
	movl 8(%ebp), %eax      #-8
	mov %ebp, %esp
    popl %ebp
    ret
.end
