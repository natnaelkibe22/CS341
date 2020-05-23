   # function to restart the application
.globl reboot
   .text
reboot:
      call 0x100100    #jmp to 0x100100
      ret          #ret
.end
