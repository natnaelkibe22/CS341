# printbin.s: Print binary values from hex
# Natnael Kibe
# Apr 1, 2020


.text
.global printbin
.data
str:
   .ascii "xxxx xxxx\0"

printbin:
       pushl %ebp       #enter (setup stack frame)
    movl %esp, %ebp
    subl $4, %esp
    movl 8(%ebp), %eax      # save 8(%ebp) address into %eax register
    movl %eax, -4(%ebp)     # save an unsigned charater in -4(%ebp)
    movl $0, -8(%ebp)
    movl %eax, -8(%ebp)      #setting an eax into -8(%ebp) address
    shrl $4, -8(%ebp)      #let's do an unsigned shift of decimal 4 byte from -8(%ebp)
    movl $str, %edx
    call donibble              # a new call to setup loop! changed (call -> jmp)
prep:
    add $1, %edx             # add $1. %edx
    movl -4(%ebp), %eax
    movl %eax, -8(%ebp)          #local user inputs to eax register
    call donibble              # call -> jmp
    movl $str, %eax
    movl %ebp, %esp
    popl %ebp              #remove ebp from stack
    ret
    movl $str, %eax
    mov %ebp, %esp
    popl %ebp              #remove ebp again from stack
    ret
donibble:
    pushl %ebp
    movl %esp, %ebp
    decl -16(%esp)            # subl $16, %esp
    movl 8(%ebp), %eax
    movb %al, -4(%ebp)	# character passed into function
    movl $4, -12(%ebp)	# -12(%ebp) holds the counter for the loop
    movl $3, -16(%ebp)	# -16(%ebp) hold the number of the right shift
    jmp loops

loops:
   movl 8(%ebp), %eax
   movl %eax, -8(%ebp) # copying character that is passed into donibble, used for shifting
   movl -16(%ebp), %ecx
   shrl %cl, -8(%ebp)
   andl $1, -8(%ebp)
   movzbl -8(%ebp), %eax
   addb $0x30, %al
   movb %al, (%edx)	# let's replace str string with 1 or 0
   # addl $1, %edx, sub $1, -16(%ebp), sub $1, -12(%ebp)
   incl %edx
   decl -16(%ebp)
   decl -12(%ebp)
   cmpb $0, -12(%ebp)
   jne loops            #jne-> jmp
 done:
    movl %ebp, %esp
    popl %ebp                #let's leave and remove stack frame by popping
    ret
.end
