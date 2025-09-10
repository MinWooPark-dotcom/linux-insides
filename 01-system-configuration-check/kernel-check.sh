#!/bin/bash

LOG="kernel-check.log"
exec > >(tee -a "$LOG") 2>&1

echo "-- 커널 정보 확인 --"
uname -a
# 예시 출력:
# Linux k8s-master 6.8.0-60-generic #63-Ubuntu SMP PREEMPT_DYNAMIC Tue Apr 15 19:04:15 UTC 2025 x86_64 x86_64 x86_64 GNU/Linux

echo ""
echo "-- 부팅 시 커널 파라미터 --"
cat /proc/cmdline
# 예시 출력:
# BOOT_IMAGE=/vmlinuz-6.8.0-60-generic root=/dev/mapper/ubuntu--vg-ubuntu--lv ro

echo ""
echo "-- 실행 중인 커널 파라미터 (sysctl 인터페이스) --"
sysctl -a
# 예시 출력:
# net.ipv4.ip_forward = 1
# vm.swappiness = 60
# fs.file-max = 9223372036854775807