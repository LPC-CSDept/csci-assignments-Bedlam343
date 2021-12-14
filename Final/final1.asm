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

        li      $a0, 0                  # clear register $s2 (will hold the final result)

rd_wait:
        lw      $t4, 0( $t2 )           # load bits of Receiver Control Register
        andi    $t4, $t4, 0x0001        # clear all bits except the Lowest Order Bit
        beq     $t4, $zero, rd_wait     # Input device is not ready, so loop back
        nop                             # delay slot for the branch

        lw      $s0, 4( $t2 )           # Input device is ready, so read value from Receiver Data Register
        addu    $s0, $s0, -48           # Subtract 48 from enetered digit to get decimal value
        beq     $t0, $t1, end           # The loop counter is reached, so break out of the loop
        nop                             # delay slot for the branch

        mult    $s0, $t3                # $s0 * Multiplier
        mflo    $s1                     # move the product into register $s1
        add     $a0, $a0, $s1           # add the new number into the number in $a0
        div     $t3, 10                 # Multiplier / 10 = new Multiplier
        mflo    $t3                     # $t3 = new Multiplier
        b       rd_wait                 # loop back
        nop                             # delay slot for branch
        

end:
        li      $v0, 10                 # service code to end program
        syscall                         # End program

## End of program