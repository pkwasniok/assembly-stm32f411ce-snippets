@ This code generates 50% filled PWM with ~100Hz frequency using TIM3 CH1



@ Vectors table
.section .vectors
_vector_stack: .word 0x20020000
_vector_reset: .word reset+1



@ Code
.thumb
.section .text
reset:
  b init

init:
  @ Enable GPIOA clock
  ldr r0, =0x40023830
  ldr r1, [r0]
  ldr r2, =1<<0
  orr r1, r2
  str r1, [r0]

  @ Enable TIM3 clock
  ldr r0, =0x40023840
  ldr r1, [r0]
  ldr r2, =1<<1
  orr r1, r2
  str r1, [r0]

  @ Set PA6 mode to alternate function
  ldr r0, =0x40020000
  ldr r1, [r0]
  ldr r2, =0b10<<12
  orr r1, r2
  str r1, [r0]

  @ Set PA6 alternate function to AF2 (TIM3_CH1)
  ldr r0, =0x40020020
  ldr r1, [r0]
  ldr r2, =0b0010<<24
  orr r1, r2
  str r1, [r0]

  @ Set TIM3 ARR
  ldr r0, =0x4000042c
  ldr r1, [r0]
  ldr r2, =0xffff
  mov r1, r2
  str r1, [r0]

  @ Set TIM PSC
  ldr r0, =0x40000428
  ldr r1, [r0]
  ldr r2, =1 @ +1
  mov r1, r2
  str r1, [r0]

  @ Set TIM3 CH1 mode to PWM1
  ldr r0, =0x40000418
  ldr r1, [r0]
  ldr r2, =0b110<<4
  orr r1, r2
  str r1, [r0]

  @ Set TIM3 CCR1
  ldr r0, =0x40000434
  ldr r1, [r0]
  ldr r2, =0x7fff
  mov r1, r2
  str r1, [r0]

  @ Enable TIM3 CH1 and invert polarity (PA6 led is active low)
  ldr r0, =0x40000420
  ldr r1, [r0]
  ldr r2, =1<<0
  orr r1, r2
  ldr r2, =1<<1
  orr r1, r2
  str r1, [r0]

  @ Enable TIM3
  ldr r0, =0x40000400
  ldr r1, [r0]
  ldr r2, =1<<0
  orr r1, r2
  str r1, [r0]

  b main

main:
  b .
