#echo.s
# Apr 15, 2020
#Natnael Kibe

    .text
	.global echo
echo:
        pushl   %ebp                #create a stack frame
        movl    %esp, %ebp         #setting a stack pointer
        movb    12(%ebp), %ch
        movw    $0x2fc, %dx     #modem control
        inb     (%dx), %al      #get current
        orb     $0x03, %al      #or on 2 lsbs
        outb    %al, (%dx)      #set control
        movw    $0x2fe, %dx     #modem status
#cmpr: 
 #       cmpb    %ch, %bl       #comparing with escape character
#          je      done
  #      movw    $0x2fd, %dx     #line status
  #      call xmit
loop1:
        inb     (%dx), %al      #get current
        andb    $0xb0, %al      #get 3 signals
        xorb    $0xb0, %al      #check all 3
        jnz     loop1           #some missing
loop2:
        movw    $0x2fd, %dx     #line status
        inb     (%dx), %al      #get data ready
        andb    $0x01, %al      #look at dr
        jz      loop2           #if recv data
        movw    $0x2f8, %dx     #i/o data addr
        inb     (%dx), %al      #move dx to %al
        movb    %al, %bl     #somewhere, save it somewhere
        
xmit:
       cmpb    %ch, %bl       #comparing with escape character
          je      done
        movw    $0x2fd, %dx     #line status
        inb     (%dx), %al      #get thre
        andb    $0x20, %al      #look at thre
        jz      loop2           #if tx hr empty
        movb    %bl, %al        #get data to send
        movw    $0x2f8, %dx     #i/o data addr
        outb    %al, (%dx)      #send it
        jmp     loop2           #and loop

done:
        mov     %ebp, %esp
        popl    %ebp
        ret
        .end

