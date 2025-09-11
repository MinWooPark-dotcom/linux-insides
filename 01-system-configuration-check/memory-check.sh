#!/bin/bash

LOG="memory-check.log"
exec > >(tee -a "$LOG") 2>&1

echo "-- 전체 메모리 정보 (Physical Array, Memory Device) --"
sudo dmidecode -t memory

echo "-- 실제 장착된 메모리 모듈만 출력 (No Module 제외) --"
sudo dmidecode -t memory | grep -i "Size:" | grep -v "No Module"