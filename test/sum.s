  # as sum.s --32 -o sum.o;ld -m elf_i386 sum.o -o sum;./sum;echo $?

 .section .data
 .section .text
 .globl _start
_start:
 pushl $3 # push second argument
 pushl $2 # push first argument

 call  sum # call the function
 addl  $8, %esp # move the stack pointer back
 movl %eax,%ebx
 movl  $1, %eax  # exit (%ebx is returned)
 int   $0x80
 
 .type sum, @function
sum:
 pushl %ebp # save old base pointer
 movl  %esp, %ebp # make stack pointer the base pointer
 subl  $4, %esp # get room for our local storage

 movl  8(%ebp), %ebx  # put first argument in %eax
 movl  12(%ebp), %ecx # put second argument in %ecx

 addl %ebx, %ecx
 movl  %ecx, -4(%ebp)

 movl -4(%ebp), %eax  # return value goes in %eax
 movl %ebp, %esp      # restore the stack pointer
 popl %ebp            # restore the base pointer
 ret

