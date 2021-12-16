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
        
        mfc0    $t0, $12                # read from the Status Reister
        ori     $t0, 0xFF11             # Store enable all interrupts
        mtc0    $t0, $12                # write back to Status Register to enable interrupts
        
        lui     $t1, 0xFFFF             # load address of Receiver Control
        ori     $t0, $zero, 2           # enable keyboard interrupt
        sw      $t0, 0( $t1 )           # write back to Receiver Control to enable KBD interrupts

inputLoop:
        bne     $a0, 113, inputLoop     # if($a0 != 'q') keep looping
        nop                             # delay slot for branch

        li      $v0, 10                 # service code to end program
        syscall                         # exit if the program gets here


        .ktext  0x80000180              # start of kernel text
                                        # no registers to save...

        mfc0    $k0, $13                # read from Cause Register
        sr1     $a0, $k0, 2             # move Exception Code field to the right
                                        # Bit 0 --> Bit 5
        andi    $a0, $a0, 0x001F        # extract Exception Code
        bne     $a0, $zero, kEnd        # Check if Exception Code is 0000
                                        # if not, go to end
                                        # Only processing I/0
        lui     $v0, 0xFFFF             # load address of Receiver Control
        lw      $a0, 4( $v0 )           # read entered data into $a0
        li      $v0, 11                 # print char service code
        syscall

kEnd:   
                                        # no registers to restore
        mtc0    $0, $13                 # Clear Cause Register
        mfc0    $k0, $12                # read from Status Register
        andi    $k0, 0xFFFD             # D = 1101; Clear exception level bit; the second bit



## End of program