#!/bin/bash

LOG="cpu-check.log"
exec > >(tee -a "$LOG") 2>&1

echo "-- bios 정보 확인 --"
sudo dmidecode -t bios

echo "-- system 정보 확인 --"
sudo dmidecode -t system

echo "-- processor 정보 확인 --"
sudo dmidecode -t processor