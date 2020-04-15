.syntax unified
.cpu cortex-m4
.thumb
#define A #3
#define B #4
#define C #5

// Global memory locations.
.global vtable_kernel
.global __kernel_reset__

.type vtable_kernel, %object
.type __kernel_reset__, %function
.section .interrupt_vector

vtable_kernel:
	.word __stack_start
	.word __kernel_reset__+1
	.size vtable_kernel, .-vtable_kernel

.section .rodata
	data: .asciz "Kernel started!\n"
	final: .asciz "Kernel finished! Value in register #4: "

.section .text
__kernel_reset__:
	ldr r0, =data
	bl dbgput_line

	mov r0, A
	mov r1, B
	mov r2, C
	mul r3, r0, r1
	cmp r3, #10
	ite ge
	orrGE r4, r0, r1
	andLT r4, r0, r1
	mul r4, r2

	ldr r0, =final
	bl dbgput
	mov r0, r4
	bl dbgput_num

	end:
	b end
