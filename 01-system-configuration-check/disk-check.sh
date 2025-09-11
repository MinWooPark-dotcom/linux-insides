#!/bin/bash

LOG="memory-check.log"
exec > >(tee -a "$LOG") 2>&1

echo "-- 디스크 사용 현황 (마운트 지점별 용량/사용률) --"
df -h

echo "-- 디스크 물리적 정보 및 상태 로그 확인 (SMART 전체) --"
smartctl -a 