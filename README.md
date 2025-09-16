# linux-insides
> 리눅스 커널 내부 구조와 시스템 콜, 메모리, 프로세스 스케줄링 등 리눅스 시스템 전반에 대한 학습과 기록

## 소개

**`linux-insides`**는 리눅스 커널과 시스템의 동작 원리를 학습하고 실습한 내용을 정리한 저장소입니다.  
커널 빌드부터 시스템 콜 작성, 프로세스 관리, 메모리 구조 분석까지 **리눅스의 안쪽을 파고드는 실습 중심**의 저장소입니다.

## 학습 목차
- **01. 시스템 구성 정보 확인**  
  - [README](01-system-configuration-check/README.md)
  - [1.1 커널 정보 확인](01-system-configuration-check/kernel-check.sh)
  - [1.2 CPU 정보 확인](01-system-configuration-check/cpu-check.sh)
  - [1.3 메모리 정보 확인](01-system-configuration-check/memory-check.sh)
  - [1.4 디스크 정보 확인](01-system-configuration-check/disk-check.sh)
  - [1.5 네트워크 정보 확인](01-system-configuration-check/network-check.sh)
- **02. top 명령어를 사용한 프로세스 확인**  
  - [README](02-process-with-top/README.md)
  - [2.1 시스템 상태 확인](02-process-with-top/system-status.sh)
  - [2.2 VIRT, RES, SHR](02-process-with-top/virt-res-shr.sh)
  - [2.3 VIRT, RES, Memory Commit](02-process-with-top/virt-res-memory-commit.sh)
  - [2.4 프로세스 상태 확인](02-process-with-top/process-status.sh)
  - [2.5 프로세스 우선순위](02-process-with-top/process-priority.sh)

## 📁 디렉토리 구조
```bash
linux-insides/
├── 01-system-configuration-check/   # 01장 시스템 구성 정보 확인
│   ├── cpu-check.sh
│   ├── disk-check.sh
│   ├── kernel-check.sh
│   ├── memory-check.sh
│   ├── network-check.sh
│   └── README.md                    # 01장 학습 문서
├── 02-processes-with-top/   # 02장 top 명령어를 사용한 프로세스 확인
│   ├── system-status.sh
│   ├── virt-res-shr.sh
│   ├── virt-res-memory-commit.sh
│   ├── process-status.sh
│   ├── process-priority.sh
│   └── README.md                    # 02장 학습 문서
└── README.md                        # 루트 문서
```