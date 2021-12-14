# Jagjit Singh
# Question 1
# 12/13/2021

        .text
        .globl main

main:
        li      $t0, 1                  # counter for loop
        li      $t1, 3                  # loop counter limit
        lui     $t2, 0xFFFF             # load address of Receiver Control
        li      $t3, 100                # Multiplier

rd_wait:
        lw      $t4, 0( $t2 )           # load bits of Receiver Control Register
        andi    $t4, $t4, 0x0001        # clear all bits except the Lowest Order Bit
        beq     $t4, $zero, rd_wait     # Input device is not ready, so loop back
        nop                             # delay slot for the branch

        lw      $s0, 4( $t2 )           # Input device is ready, so read value from Receiver Data Register

        beq     $t0, $t1, end           # The loop counter is reached, so break out of the loop
        nop                             # delay slot for the branch

        

end:
        li      $v0, 10                 # service code to end program
        syscall                         # End program

## End of program