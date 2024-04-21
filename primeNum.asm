; 	primeNum.asm
;   Author: Cache Fulton
;	PURPOSE:  Reading a positive decimal number from the keyboard below 32767
;   		  and telling you if it is a prime number or not.
;	DEPENDENCIES:  getn, printn, checkFactor
;
.orig x3000
	br Welcome

newline
	.fill #10
welMessage
	.stringz "Welcome to Cache's prime number detector!\n"
Prompt
	.stringz "Enter a positive number below 33000> "
yourNum
	.stringz "Your number, "
isPrime
	.stringz "is prime!\n"
notPrime
	.stringz "is not prime.\n"
Illegal
	.stringz "\nPlease only enter positive digits\n"
Overflow
	.stringz "\nNumber is too large\n"
checkFactor
	.fill x4300
printn
	.fill x4200
getn
	.fill x4100

Welcome
	lea r0, welMessage
	puts
Start
	lea r0, Prompt
	puts 
	ld r1, getn			;get input
	jsrr r1
	add r1, r1, #1 		;check error codes
	brn CharacterError
	brz OverflowError
	add r4, r0, #0		;input number in r0 to r4
	lea r0, yourNum		;print your number
	puts
	add r0, r4, #0		;set r0 to input num for printn
	ld r1, printn		
	jsrr r1
	add r0, r0, #1 		;check error codes
	brz OverflowError
	ld r0, newline
	out
	add r1, r4, #-2		;check if number = 2 by subtracting 2
	brz PrimePrint		;2 is prime so print prime if 0
	brn notPrimePrint	;if number is negative it means it was 0 or 1 and they are not prime
	and r1, r4, #1		;check if even or odd, isolate last bit
	brz notPrimePrint	;if zero, meaning even, the number is not prime
	add r5, r4, #0		;put input number into r5 and r1 below
CheckPossFactors		;because we checked num 2, odd, and even before, we can break when we hit 1
	add r1, r4, #0		;get ready to use checkFactor
	add r5, r5, #-2		;subtract two from input number and consecutive numbers to check every possible factor
	add r6, r5 #-1		;check if next possible factor is 1, put in r6
	brz PrimePrint		;if r6 is zero, break
	add r0, r5, #0		;store r5 in r0 for checkFactor
	ld r3, checkFactor	;r5 holds changing possible factors, r4 holds original input
	jsrr r3
	add r1, r1, #0		;check message from checkFactor and break if needed
	brn CheckPossFactors 
	brz notPrimePrint	;if it is a factor, input is not prime
PrimePrint
	lea r0, isPrime
	puts
	br End
notPrimePrint
	lea r0, notPrime
	puts
	br End
CharacterError
	lea r0, Illegal
	puts
	br Start
OverflowError
	lea R0, Overflow
	puts
	and r4, r4, #0		;reset r4, don't think i need this
	br Start
End	
	halt
.end
