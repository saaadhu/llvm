; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=fma -enable-unsafe-fp-math -enable-fmf-dag=1 | FileCheck %s

; If fast-math-flags are propagated correctly, the mul1 expression
; should be recognized as a factor in the last fsub, so we should
; see a mul and add, not a mul and fma:
; a * b - (-a * b) ---> (a * b) + (a * b)

define float @fmf_should_not_break_cse(float %a, float %b) {
; CHECK-LABEL: fmf_should_not_break_cse:
; CHECK:       # BB#0:
; CHECK-NEXT:    vmulss %xmm1, %xmm0, %xmm0
; CHECK-NEXT:    vaddss %xmm0, %xmm0, %xmm0
; CHECK-NEXT:    retq

  %mul1 = fmul fast float %a, %b
  %nega = fsub fast float 0.0, %a
  %mul2 = fmul fast float %nega, %b
  %abx2 = fsub fast float %mul1, %mul2
  ret float %abx2
}

