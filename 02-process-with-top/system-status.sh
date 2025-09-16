#!/bin/bash

LOG="system-status.log"
exec > >(tee -a "$LOG") 2>&1

echo "-- 시스템 상태 확인 --"
top -b -n 1