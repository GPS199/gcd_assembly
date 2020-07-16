.data
	str1:.asciiz "\nEnter an integer: "
	str2:.asciiz "\nEnter another integer: "
	str3: .asciiz "\nThe greatest common divisor is: "

	
.text
main:

#-----------------------------------
#Request first integer from the user
#-----------------------------------

	
	la $a0, str1
	li $v0, 4      #print str1
	syscall
	
        li $v0, 5     #read integer        
        syscall         
        
        add $s0, $v0, $zero 
        
#-----------------------------------
#Request second integer from the user
#------------------------------------
        
	la $a0, str2   #print str2
	li $v0, 4
	syscall
	
        li $v0, 5      #read int   
        syscall         
        
        add $s1, $v0, $zero 
#-------------------------------------   
#Output 
#-------------------------------------

	

	# Output GCD of A & B
	li  $v0, 4
	la  $a0, str3   # Print str3
	syscall

	add $s2,$v0,$zero      
#----------------------------------------------
#swapping part
#---------------------------------------------
       
        slt $t0, $s0, $s1       
        addi $sp, $sp, -4         #if n1 < n2  swap
        bne $t0, 0, swap          
        jal gcdRec        
        j exit

    
        
swap:
	add $t0, $s0, $zero       #move n1 to temp
	add $s0, $s1, $zero
	add $s1, $t0, $zero
	jal gcdRec               #call gcdRec
	j exit                                               


	

#-------------------------------------------------
#Find the gcd of the given two integers recursively
#--------------------------------------------------
	
gcdRec:


	addi $sp, $sp, -12
	sw $ra, 8($sp)
	sw $s0, 4($sp)
	sw $s1, 0($sp)
	bne $s1, 0, else           #if n2 == 0 return n1 
	add $v0, $s0, $zero
	jr $ra
else:                              #return gcd( n2, n1 % n2 )
	add $t0, $s0, $zero
	add $s0, $s1, $zero
	add $s1, $t0, $zero
	rem $s1, $s1, $s0
	jal gcdRec
	
	lw $s1, 0($sp) 
 	lw $s0, 4($sp)
 	lw $ra, 8($sp) 
 	addi $sp, $sp, 12 
 	jr $ra
 	

	


	
	
#------------------------------------------------
#Exit part
#------------------------------------------------

	
	exit:	
	
	move $a0, $v0    # Output A value, which is now GCD
	li  $v0, 1
	syscall
	
	# Exit
	li  $v0, 10     # exit call
	syscall
	
 #-----------------------------------------------------------
 #Exit part
 #------------------------------------------------------------
 
 #exit:
 	
 	
 	#move $a0, $v0		
        #li $v0, 1

        #syscall         	
        #li $v0, 10                 
        #syscall 



      
#----------------------------------------------------------          
#private static int findGCD(int number1, int number2) {
#if(number2 == 0){                    //base case 
# return number1;
# } 
# return findGCD(number2, number1%number2); }
#-----------------------------------------------------------        
