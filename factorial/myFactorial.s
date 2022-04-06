 # as myFactorial.s --32 -o myFactorial.o;ld -m elf_i386 myFactorial.o -o myFactorial;./myFactorial;echo $?
 # PURPOSE - Given a number, this program computes the
 #          factorial.  For example, the factorial of
 # 3is3*2*1,or6. Thefactorialof
 #          4 is 4 * 3 * 2 * 1, or 24, and so on.
 #

# This program shows how to call a function recursively.

.section .data
 # This program has no global data
 .section .text
 .globl _start
 .globl factorial # this is unneeded unless we want to share
                  # this function among other programs

_start:
 pushl $5         # The factorial takes one argument - the
                  # number we want a factorial of.  So, it
                  # gets pushed

movl $1,%eax
call  factorial  # run the factorial function
addl  $4, %esp   # Scrubs the parameter that was pushed on
                  # the stack
 movl  %eax, %ebx # factorial returns the answer in %eax, but
                  # we want it in %ebx to send it as our exit status

 movl  $1, %eax   # call the kernel’s exit function
 int   $0x80


 # This is the actual function definitione
.type factorial, @function
factorial:
 pushl %ebx
 pushl %ebp # save old base pointer
 movl  %esp, %ebp # make stack pointer the base pointer
 subl  $4, %esp # get room for our local storage

 movl  12(%ebp), %ebx  # put first argument in %ebx

 cmpl  $1, %ebx # check if the number is 1, then return 1
 je    end_factorial 

 movl %ebx,%ecx
 decl %ecx
 movl %ecx,-4(%ebp)
 call  factorial
 imull %ebx, %eax
 je    end_factorial


 end_factorial:
 movl %ebp, %esp      # restore the stack pointer
 popl %ebp
 popl %ebx
 ret

