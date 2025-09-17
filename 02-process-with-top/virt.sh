#!/bin/bash

LOG="virt.log"
exec > >(tee -a "$LOG") 2>&1

echo "-- 프로세스 VIRT 값 확인 --"
top -u <유저 이름>