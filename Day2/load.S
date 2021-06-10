.section .text
.global load
.type load, @function

load:
        add     a4, a0, zero //Setting a4 to zero
        add     a2, a0, a1  //Storing function second input to a2
        add     a3, a0, zero //Setting counter to zero
loop:   add     a4, a3, a4 //Adding the counter to the result store
        add     a3, a3, 1 //Incrementing the counter
        blt     a3, a2, loop //Comparing a3 and a2 and jumping to loop if a3 is smaller
        add     a0, a4, zero //Storing result value to a0
        ret