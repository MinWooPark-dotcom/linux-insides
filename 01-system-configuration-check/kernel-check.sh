#!/bin/bash

LOG="kernel-check.log"
exec > >(tee -a "$LOG") 2>&1

echo "-- 커널 정보 확인 --"
uname -a

echo ""
echo "-- 부팅 시 커널 파라미터 --"
cat /proc/cmdline

echo ""
echo "-- 실행 중인 커널 파라미터 (sysctl 인터페이스) --"
sysctl -a