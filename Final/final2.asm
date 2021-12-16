# Jagjit Singh
# Question 2
# 12/15/2021

        .data
pr1:    .asciiz "Enter any character ('q' to quit): "   # prompt message


        .text
        .globl main

main:
        la      $a0, pr1                # load prompt message address
        li      $v0, 4                  # print string service code
        syscall
        
        mfc0    $t0, $12                # read from the status reister
        ori     $t0, 0xFF11             # Store enable all interrupts
        mtc0    $t0, $12                # write back to status register to enable interrupts
        
        lui     $t1, 0xFFFF             # load address of Receiver Control
        ori     $t0, $zero, 0x0002      # enable keyboard interrupt
        sw      $t0, 0( $t1 )           # write back to Receiver control to enable KBD interrupts

        li      $v0, 10                 # service code to end program
        syscall                         # exit if the program gets here

## End of program