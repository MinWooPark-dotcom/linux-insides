# 01. 시스템 구성 정보 확인 (Linux)
시스템 문제를 파악하는 출발점인 커널·CPU·메모리·디스크·네트워크의 현재 상태 분석하는 것이 중요합니다.

## 1.1 커널 정보 확인
- 실행 스크립트: `kernel-check.sh`
- 출력 로그: `kernel-check.log`

### 핵심 명령

커널/아키텍처/빌드 요약  
```bash
uname -a
# 현재 실행 중인 커널과 시스템 아키텍처 정보를 출력하는 명령어
# 커널 버전, 빌드 옵션, 아키텍처, eBPF, 컨테이너 기능 등 요구 조건과 일치하는지 점검
# e.g. 
# Linux k8s-master 6.8.0-60-generic #63-Ubuntu SMP PREEMPT_DYNAMIC Tue Apr 15 19:04:15 UTC 2025 x86_64 x86_64 x86_64 GNU/Linux
```

부팅 시 전달된 커널 파라미터
```bash
cat /proc/cmdline
# 부팅 시 bootloader가 커널에 넘겨준 인자를 확인할 수 있는 가상 파일
# cgroup, root=, ro/rw, quiet 등 부팅 인자 확인
# e.g.
# BOOT_IMAGE=/vmlinuz-6.8.0-60-generic root=/dev/mapper/ubuntu--vg-ubuntu--lv ro
```

런타임 커널 파라미터(튜너블)
```bash
sysctl -a | less
# 리눅스 커널 파라미터를 확인하거나(runtime) 변경하는 명령어
# sysctl은 실제로 /proc/sys 디렉토리 밑의 가상 파일들을 읽고 씀
# sysctl 값들은 운영 중 조정되는 튜너블이므로, 변경 이력(Ansible/파일)에 반영 필요
```

자주 보는 키만 추려보기
```bash
sysctl net.ipv4.ip_forward  # 패킷 포워딩 여부
sysctl vm.swappiness        # 메모리 스와핑 정책
sysctl fs.file-max          # 열 수 있는 최대 파일 수
# e.g.
# net.ipv4.ip_forward = 1
# vm.swappiness = 60
# fs.file-max = 9223372036854775807
```


dmesg 관련
```bash
dmesg | less
# 커널의 순환 로그 버퍼를 읽어 하드웨어 인식/드라이버/부팅 메시지를 확인하는 명령어
# 오래되면 덮어쓰기 됨, 부팅 직후 로그가 링버퍼에서 밀려났거나(UFW 등 다른 로그로 덮임)
```

```bash
sudo journalctl -k | less
# systemd의 로그 관리 도구로, 
# 커널만 journald에 보관된 로그(systemd 환경), 최신 배포판에서는 부팅 메시지에 kernel 문자열이 직접 포함되지 않을 수도 있음. 
# 영구 보관은 -k 옵션 커널 관련 로그만 필터링하여 확인
# e.g.
# Jun 17 04:23:58 k8s-master kernel: Linux version 6.8.0-60-generic (buildd@lcy02-amd64-054) (x86_64-linux-gnu-gcc-13 (Ubuntu 13.3.0-6ubuntu2~24.04) 13.3.0, GNU ld (GNU Binutils for Ubuntu) 2.42) #63-Ubuntu SMP PREEMPT_DYNAMIC Tue Apr 15 19:04:15 UTC 2025 (Ubuntu 6.8.0-60.63-generic 6.8.12)
# Jun 17 04:23:58 k8s-master kernel: Command line: BOOT_IMAGE=/vmlinuz-6.8.0-60-generic root=/dev/mapper/ubuntu--vg-ubuntu--lv ro
# Jun 17 04:23:58 k8s-master kernel: KERNEL supported cpus:
# Jun 17 04:23:58 k8s-master kernel:   Intel GenuineIntel
# Jun 17 04:23:58 k8s-master kernel:   AMD AuthenticAMD
# Jun 17 04:23:58 k8s-master kernel:   Hygon HygonGenuine
# Jun 17 04:23:58 k8s-master kernel:   Centaur CentaurHauls
# Jun 17 04:23:58 k8s-master kernel:   zhaoxin   Shanghai  
# Jun 17 04:23:58 k8s-master kernel: x86/split lock detection: #AC: crashing the kernel on kernel split_locks and warning on user-space split_locks ...
```

## 1.2 CPU 정보 확인
- 실행 스크립트: `cpu-check.sh`
- 출력 로그: `cpu-check.log`

### 핵심 명령

bios 정보 확인
```bash
sudo dmidecode -t bios
# 펌웨어 자체에 대한 정보
# 특정 BIOS 버전에 문제가 있거나, 하드웨어 호환성 확인할 때 사용
# e.g.
# dmidecode 3.5
# Getting SMBIOS data from sysfs.
# SMBIOS 3.6.0 present.
# # SMBIOS implementations newer than version 3.5.0 are not
# # fully supported by this version of dmidecode.

# Handle 0x0000, DMI type 0, 26 bytes
# BIOS Information
# 	Vendor: American Megatrends International, LLC.
# 	Version: 5.27
# 	Release Date: 11/06/2024
# 	Address: 0xF0000
# 	Runtime Size: 64 kB
# 	ROM Size: 0 MB
# 	Characteristics: ...
```

system 정보 확인
```bash
sudo dmidecode -t system
# 시스템 장비 단위의 관리 정보
# 하드웨어 제조사, 모델명, 시리얼, UUID 등 시스템 정보를 확인할 때 사용
# e.g.
# # dmidecode 3.5
# Getting SMBIOS data from sysfs.
# SMBIOS 3.6.0 present.
# # SMBIOS implementations newer than version 3.5.0 are not
# # fully supported by this version of dmidecode.

# Handle 0x0001, DMI type 1, 27 bytes
# System Information
# 	Manufacturer: GMKtec
# 	Product Name: NucBoxG3 Plus
# 	Version: Default string
# 	Serial Number: Default string
# 	UUID: REDACTED
# 	Wake-up Type: Power Switch
# 	SKU Number: G3 Plus-001
# 	Family: G3 Plus ...
```

processor 정보 확인
```bash
sudo dmidecode -t processor
# CPU 소켓 단위 정보
# 벤더, 모델, 속도, 코어, 스레드 수 등을 확인할 때 사용
# e.g.
# # dmidecode 3.5
# Getting SMBIOS data from sysfs.
# SMBIOS 3.6.0 present.
# # SMBIOS implementations newer than version 3.5.0 are not
# # fully supported by this version of dmidecode.

# Handle 0x0036, DMI type 4, 48 bytes
# Processor Information
# 	Socket Designation: U3E1
# 	Type: Central Processor
# 	Family: Other
# 	Manufacturer: Intel(R) Corporation
# 	ID: REDACTED
# 	Version: Intel(R) N150
# 	Voltage: 1.0 V
# 	External Clock: 100 MHz
# 	Max Speed: 3600 MHz
# 	Current Speed: 2871 MHz
# 	Status: Populated, Enabled
# 	Upgrade: Other ...
```

커널 관점에서 CPU 정보 확인
```bash
lscpu
# CPU 정보는 lscpu로도 확인할 수 있음
# 커널 관점에서 CPU 아키텍처/코어/스레드/플래그를 확인
# dmidecode(펌웨어 관점)과 비교하여 OS가 실제 활용 가능한 기능을 교차 검증할 수 있음
# e.g.
# Architecture:             x86_64
#   CPU op-mode(s):         32-bit, 64-bit
#   Address sizes:          39 bits physical, 48 bits virtual
#   Byte Order:             Little Endian
# CPU(s):                   4
#   On-line CPU(s) list:    0-3
# Vendor ID:                GenuineIntel
#   Model name:             Intel(R) N150
#     CPU family:           6
#     Model:                190
#     Thread(s) per core:   1
#     Core(s) per socket:   4
#     Socket(s):            1
#     Stepping:             0
#     CPU(s) scaling MHz:   22%
#     CPU max MHz:          3600.0000
#     CPU min MHz:          700.0000
#     BogoMIPS:             1612.80
#     Flags:                fpu vme de pse tsc msr pae mce cx8 apic sep mtrr ...
```

## 1.3 메모리 정보 확인
- 실행 스크립트: `memory-check.sh`
- 출력 로그: `memory-check.log`

### 핵심 명령

메모리 전체 구조 (Physical Array, Memory Device) 확인
```bash
dmidecode -t memory
# 메모리 정보는 크게 Physical Memory Array, Memory Device 두 영역으로 나눌 수 있음
# Physical Memory Array는 CPU 소켓과 연결된 메모리 뱅크 전체, 메모리를 꽂을 수 있는 틀 자체
# Memory Device는 실제로 슬롯에 꽂혀 있는 RAM 모듈 하나하나를 의미함
# e.g.
# # dmidecode 3.5
# Getting SMBIOS data from sysfs.
# SMBIOS 3.6.0 present.
# # SMBIOS implementations newer than version 3.5.0 are not
# # fully supported by this version of dmidecode.

# Handle 0x0027, DMI type 16, 23 bytes
# Physical Memory Array
# 	Location: System Board Or Motherboard
# 	Use: System Memory
# 	Error Correction Type: None
# 	Maximum Capacity: 32 GB
# 	Error Information Handle: Not Provided
# 	Number Of Devices: 1

# Handle 0x0028, DMI type 17, 92 bytes
# Memory Device
# 	Array Handle: 0x0027
# 	Error Information Handle: Not Provided
# 	Total Width: 64 bits
# 	Data Width: 64 bits
# 	Size: 16 GB
# 	Form Factor: SODIMM
# 	Set: None ...
```

Memory Device 중 실제 장착된 모듈의 용량만 확인
```bash
dmidecode -t memory | grep -i "Size:" | grep -v "No Module"
# 빈 슬롯(No Module Installed)은 제외하고 장착된 메모리 모듈의 크기만 확인
# e.g.
# Size: 16 GB
# Non-Volatile Size: None
# Volatile Size: 16 GB
# Cache Size: None
# Logical Size: None
```