# Jagjit Singh
# Question 1
# 12/13/2021

    .text
    .globl main

main:
    li  $t0, 1              # counter for loop
    li  $t1, 3              # loop counter limit
    lui $t2, 0xFFFF         # load address of Receiver Control

rd_wait:

    blt $t0, $t1, rd_wait   # if ($t0 < $t1) loop back
    nop                     # delay slot for the branch

    li  $v0, 10             # service code to end program
    syscall                 # End program

## End of program