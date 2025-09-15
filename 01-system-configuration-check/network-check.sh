#!/bin/bash

LOG="network-check.log"
exec > >(tee -a "$LOG") 2>&1

echo "-- 네트워크 카드 정보 확인 --"
lspci | grep -i ether

echo "-- 네트워크 인터페이스 IP 주소 및 상태 확인 --"
ip a

echo "-- 네트워크 연결 상태 확인 --"
ethtool <인터페이스 이름>

echo "-- 네트워크 카드 Ring Buffer 크기 확인 --"
ethtool -g <인터페이스 이름>

echo "-- 네트워크 카드 성능 최적화 옵션 확인 --"
ethtool -k <인터페이스 이름>

echo "-- 네트워크 카드 성능 최적화 옵션 설정 --"
ethtool -K <인터페이스 이름> <옵션> on|off 

echo "-- 네트워크 카드 커널 모듈 정보 표시 확인 --"
ethtool -i <인터페이스 이름>