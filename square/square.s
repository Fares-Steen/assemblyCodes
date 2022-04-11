 # as square.s --32 -o square.o;ld -m elf_i386 square.o -o square;./square;echo $?

.section .data

.section .text
.globl _start
.globl square

_start:
 pushl $5

 call square

addl  $4, %esp 
 movl  %eax, %ebx # factorial returns the answer in %eax, but
                  # we want it in %ebx to send it as our exit status

 movl  $1, %eax   # call the kernel’s exit function
 int   $0x80


.type square,@function
square:
 pushl %ebp       # standard function stuff - we have to
                  # restore %ebp to its prior state before
                  # returning, so we have to push it

movl  %esp, %ebp # This is because we don’t want to modify
                  # the stack pointer, so we use %ebp.

movl  8(%ebp), %eax # This moves the first argument to %eax
                  # 4(%ebp) holds the return address, and

imull %eax,%eax

call end_square

end_square:
movl  %ebp, %esp # standard function return stuff - we reload our parameter into %ebx
popl  %ebp       # have to restore %ebp and %esp to where
                 # they were before the function started
ret   
