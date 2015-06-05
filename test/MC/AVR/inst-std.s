; RUN: llvm-mc -triple avr-none -mattr=sram -show-encoding < %s | FileCheck %s


foo:

  std Y+2, r2
  std Y+0, r0

  std Z+12, r9
  std Z+30, r7

; CHECK: std y+2,  r2                 ; encoding: [0x2a,0x82]
; CHECK: std y+0,  r0                 ; encoding: [0x08,0x82]

; CHECK: std z+12, r9                 ; encoding: [0x94,0x86]
; CHECK: std z+30, r7                 ; encoding: [0x76,0x8e]
