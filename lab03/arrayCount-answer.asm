# arrayCount.asm
  .data 
arrayA: .word 11, 0, 31, 22, 9, 17, 6, 9   # arrayA has 8 values
count:  .word 999             # dummy value

  .text
main:
    # code to setup the variable mappings
    la $t0, arrayA
    la $t8, count

    # code for reading in the user value X
    li $v0, 5
    syscall
    addi $t1, $v0, -1 # store user input as mask in $t1

    # code for counting multiples of X in arrayA
    addi $t2, $zero, 8 # $t2 as limit
    addi $t7, $zero, 0 # $t7 as counter of multiples
loop:
    beq $t2, $zero, endLoop
    lw $t3, 0($t0) # load value of current pointer into $t3
    and $t4, $t3, $t1
ifMultiple:
    bne $t4, $zero, endif
    addi $t7, $t7, 1
endif:
    addi $t0, $t0, 4 # increment pointer
    addi $t2, $t2, -1 # decrement limit
    j loop
endLoop:

    # code for printing result
    li $v0, 1
    addi $a0, $t7, 0
    syscall

    # code for storing count
    sw $t7, 0($t8)

    # code for terminating program
    li  $v0, 10
    syscall
