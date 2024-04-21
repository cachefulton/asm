; 	checkFactor.asm
;   author: Cache Fulton
;	PURPOSE:  reading a positive number from r0 and checking if it is a factor of number in r1
;	DEPENDENCIES:  none
;
.orig X4300
br start
errNum .fill #1
start
                    ;because even numbers are not prime except 2, we will only pass in odd
    add r0, r0, #0
    brnz error      ;check if r0 negative or 0
    add r1, r1, #0
    brnz error      ;check if r1 negative or 0
    not r0, r0      ;get negative r0 in order to subtract
    add r0, r0, #1  ;add one to number
subtract
    add r1, r1, r0  ;subtract r0 from r1
    brp subtract    ;check if positive
    br end          ;if negative or 0 jump to end
error
    ld r1, errNum   ;put 1 in r1
end
    ret
.end