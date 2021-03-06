; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -verify -slp-vectorizer -o - -S -mtriple=x86_64-apple-macosx10.13.0 | FileCheck %s

@global = local_unnamed_addr global [6 x double] zeroinitializer, align 16

define { i64, i64 } @patatino(double %arg) {
; CHECK-LABEL: @patatino(
; CHECK-NEXT:  bb:
; CHECK-NEXT:    [[TMP0:%.*]] = load <2 x double>, <2 x double>* bitcast ([6 x double]* @global to <2 x double>*), align 16
; CHECK-NEXT:    [[TMP1:%.*]] = load <2 x double>, <2 x double>* bitcast (double* getelementptr inbounds ([6 x double], [6 x double]* @global, i64 0, i64 2) to <2 x double>*), align 16
; CHECK-NEXT:    [[TMP2:%.*]] = insertelement <2 x double> undef, double [[ARG:%.*]], i32 0
; CHECK-NEXT:    [[TMP3:%.*]] = insertelement <2 x double> [[TMP2]], double [[ARG]], i32 1
; CHECK-NEXT:    [[TMP4:%.*]] = fmul <2 x double> [[TMP3]], [[TMP1]]
; CHECK-NEXT:    [[TMP5:%.*]] = fadd <2 x double> [[TMP0]], [[TMP4]]
; CHECK-NEXT:    [[TMP6:%.*]] = load <2 x double>, <2 x double>* bitcast (double* getelementptr inbounds ([6 x double], [6 x double]* @global, i64 0, i64 4) to <2 x double>*), align 16
; CHECK-NEXT:    [[TMP7:%.*]] = fadd <2 x double> [[TMP6]], [[TMP5]]
; CHECK-NEXT:    [[TMP8:%.*]] = fptosi <2 x double> [[TMP7]] to <2 x i32>
; CHECK-NEXT:    [[TMP9:%.*]] = sext <2 x i32> [[TMP8]] to <2 x i64>
; CHECK-NEXT:    [[TMP10:%.*]] = trunc <2 x i64> [[TMP9]] to <2 x i32>
; CHECK-NEXT:    [[TMP11:%.*]] = extractelement <2 x i32> [[TMP10]], i32 0
; CHECK-NEXT:    [[TMP12:%.*]] = sext i32 [[TMP11]] to i64
; CHECK-NEXT:    [[TMP16:%.*]] = insertvalue { i64, i64 } undef, i64 [[TMP12]], 0
; CHECK-NEXT:    [[TMP13:%.*]] = extractelement <2 x i32> [[TMP10]], i32 1
; CHECK-NEXT:    [[TMP14:%.*]] = sext i32 [[TMP13]] to i64
; CHECK-NEXT:    [[TMP17:%.*]] = insertvalue { i64, i64 } [[TMP16]], i64 [[TMP14]], 1
; CHECK-NEXT:    ret { i64, i64 } [[TMP17]]
;
bb:
  %tmp = load double, double* getelementptr inbounds ([6 x double], [6 x double]* @global, i64 0, i64 0), align 16
  %tmp1 = load double, double* getelementptr inbounds ([6 x double], [6 x double]* @global, i64 0, i64 2), align 16
  %tmp2 = fmul double %tmp1, %arg
  %tmp3 = fadd double %tmp, %tmp2
  %tmp4 = load double, double* getelementptr inbounds ([6 x double], [6 x double]* @global, i64 0, i64 4), align 16
  %tmp5 = fadd double %tmp4, %tmp3
  %tmp6 = fptosi double %tmp5 to i32
  %tmp7 = sext i32 %tmp6 to i64
  %tmp8 = load double, double* getelementptr inbounds ([6 x double], [6 x double]* @global, i64 0, i64 1), align 8
  %tmp9 = load double, double* getelementptr inbounds ([6 x double], [6 x double]* @global, i64 0, i64 3), align 8
  %tmp10 = fmul double %tmp9, %arg
  %tmp11 = fadd double %tmp8, %tmp10
  %tmp12 = load double, double* getelementptr inbounds ([6 x double], [6 x double]* @global, i64 0, i64 5), align 8
  %tmp13 = fadd double %tmp12, %tmp11
  %tmp14 = fptosi double %tmp13 to i32
  %tmp15 = sext i32 %tmp14 to i64
  %tmp16 = insertvalue { i64, i64 } undef, i64 %tmp7, 0
  %tmp17 = insertvalue { i64, i64 } %tmp16, i64 %tmp15, 1
  ret { i64, i64 } %tmp17
}
