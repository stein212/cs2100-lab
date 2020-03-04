# arrayFunction.asm
       .data 
array: .word 8, 2, 1, 6, 9, 7, 3, 5, 0, 4
newl:  .asciiz "\n"

       .text
main:
	# Print the original content of array
	# setup the parameter(s)
    la $a0, array           # Load address for array
    li $a1, 10              # Load size of array into $a1

	# call the printArray function
    jal printArray          # Run printArray function

	# Ask the user for two indices
	li   $v0, 5         	# System call code for read_int
	syscall           
	addi $t0, $v0, 0    	# first user input in $t0
 
	li   $v0, 5         	# System call code for read_int
	syscall           
	addi $t1, $v0, 0    	# second user input in $t1

	# Call the findMin function
	# setup the parameter(s)
    la $t8, array           # Load address for array again in case $t8 is used for something else somehow even tho won't
    sll $t0, $t0, 2         # Shift left by 2 to multiply by 4
    add $a0, $t8, $t0       # Add the shifted value to get starting address
    sll $t1, $t1, 2         # Same idea for end address
    add $a1, $t8, $t1
	# call the function
    jal findMin

	# Print the min item
	# place the min item in $t3	for printing
    addi $t4, $v0, 0        # Store the address of the smallest in $t4 for later use
    lw $t3, 0($t4)          # Load the value of the smallest address into $t3

	# Print an integer followed by a newline
	li   $v0, 1   		# system call code for print_int
    addi $a0, $t3, 0    # print $t3
    syscall       		# make system call

	li   $v0, 4   		# system call code for print_string
    la   $a0, newl    	# 
    syscall       		# print newline

	#Calculate and print the index of min item
	sub $t3, $t4, $t8       # Subtract the address of min by starting address
    srl $t3, $t3, 2         # Shift right by 2 to divide by 4 to get index
	# Place the min index in $t3 for printing

	# Print the min index
	# Print an integer followed by a newline
	li   $v0, 1   		# system call code for print_int
    addi $a0, $t3, 0    # print $t3
    syscall       		# make system call
	
	li   $v0, 4   		# system call code for print_string
    la   $a0, newl    	# 
    syscall       		# print newline
	
	# End of main, make a syscall to "exit"
	li   $v0, 10   		# system call code for exit
	syscall	       	# terminate program
	

#######################################################################
###   Function printArray   ### 
#Input: Array Address in $a0, Number of elements in $a1
#Output: None
#Purpose: Print array elements
#Registers used: $t0, $t1, $t2, $t3
#Assumption: Array element is word size (4-byte)
printArray:
	addi $t1, $a0, 0	#$t1 is the pointer to the item
	sll  $t2, $a1, 2	#$t2 is the offset beyond the last item
	add  $t2, $a0, $t2 	#$t2 is pointing beyond the last item
l1:	
	beq  $t1, $t2, e1
	lw   $t3, 0($t1)	#$t3 is the current item
	li   $v0, 1   		# system call code for print_int
    addi $a0, $t3, 0    	# integer to print
    syscall       		# print it
	addi $t1, $t1, 4
	j l1				# Another iteration
e1:
	li   $v0, 4   		# system call code for print_string
     	la   $a0, newl    	# 
     	syscall       		# print newline
	jr $ra			# return from this function


#######################################################################
###   Student Function findMin   ### 
#Input: Lower Array Pointer in $a0, Higher Array Pointer in $a1
#Output: $v0 contains the address of min item 
#Purpose: Find and return the minimum item 
#              between $a0 and $a1 (inclusive)
#Registers used: <Fill in with your register usage>
#Assumption: Array element is word size (4-byte), $a0 <= $a1
findMin:
    addi $t0, $a0, 0
    addi $t1, $a1, 4
    lw $t3, 0($t0)
    addi $t4, $t0, 0
    addi $t0, $t0, 4
l2:
    beq $t0, $t1, e2
    lw $t2, 0($t0)
    slt $t5, $t2, $t3
    beq $t5, $zero, m2
    addi $t3, $t2, 0 
    addi $t4, $t0, 0
m2:
    addi $t0, $t0, 4
    j l2
e2:
    addi $v0, $t4, 0
	jr $ra			# return from this function
