# Start .data segment (data!)
.data 
str1: .asciiz "Enter an integer: "
str2: .asciiz "\nEnter another integer: "
str3: .asciiz "\nThe greatest common divisor is: "



# All program code follows the .txt directive
 .text
 


 main:
 
#-----------------------------------
#Request first integer from the user
#-----------------------------------

	 la $a0 str1 #print string
 	 li $v0 4
 	 syscall
 
	 li $v0 5 #read integer
 	 syscall

	 add  $a1, $v0 , $zero    # syscall results returned in $v0, move $v0 to $t0

#-----------------------------------
#Request second integer from the user
#------------------------------------

        la $a0, str2   #print str2
        li $v0, 4	
	syscall
	
        li $v0, 5      #read int   
        syscall   
      
        add $a2, $v0, $zero       

#-------------------------------------   
#Output 
#-------------------------------------

	
	
	# Output GCD of A & B
	li  $v0, 4
	la  $a0, str3   # Print str3
	syscall

	jal gcd
	add $v0,$a0,$zero
	
	li $v0, 1
	syscall
	#addi $a2, $v0, 0
	
	#Exit the program
	li $v0 10
	syscall
	

       

#-------------------------------------   
#find the gcd of the given two integers using a loop
#-------------------------------------


	gcd:
	
	beq $a1,$a2,exit         # if a = b, go to exit
	slt $t0, $a2, $a1       # Is b > a?
	bne $t0, $zero, L1      # Yes, goto .L1	
	sub $a2, $a2, $a1      # Subtract b from a (b < a)   
	j  gcd                 # and repeat
	
	L1:
	sub $a1, $a1, $a2      # Subtract a from b (a < b) 
	j  gcd                   # and repeat
	
	exit:
			
	add $a0, $a2, $zero
	jr $ra
	
	
	#exit:
 	  
 	#li $v0,1 
 	#syscall 
 	#add $v0, $s0, $zero
 	#li $v0, 10
	#syscall
 	




#------------------------------------------------
#Exit part
#------------------------------------------------

	
	#exit:	
	
	#move $a0, $v0    # Output A value, which is now GCD
	#li  $v0, 1
	#syscall
	
	# Exit
	#li  $v0, 10     # exit call
	#syscall
	
	
#------------------------------------------
#int gcd(int a, int b)
#{
#while (a != b) {
#if (a > b) a = a - b;
#else b = b - a;
#}
#return a;	
	
#------------------------------------------
# int GCD (int a, int b) {
# while(a!=b) {
# if (a > b)
# a -= b;
# else
# b -= a;
# }
# return a;
# }
#------------------------------------------------   
#GCD := proc(a,b)
#if b = 0 then
#a;
#elif a < b then
#GCD(b,a);
#else GCD(a-b, b);
#end if;
#end:
