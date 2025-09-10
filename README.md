# linux-insides
> 리눅스 커널 내부 구조와 시스템 콜, 메모리, 프로세스 스케줄링 등 리눅스 시스템 전반에 대한 학습과 기록

## 소개

**`linux-insides`**는 리눅스 커널과 시스템의 동작 원리를 학습하고 실습한 내용을 정리한 저장소입니다.  
커널 빌드부터 시스템 콜 작성, 프로세스 관리, 메모리 구조 분석까지 **리눅스의 안쪽을 파고드는 실습 중심**의 저장소입니다.

## 학습 목차
- **01. 시스템 구성 정보 확인**  
  - 1.1 커널 정보 확인
  - 1.2 CPU 정보 확인
  - 1.3 메모리 정보 확인
  - 1.4 디스크 정보 확인
  - 1.5 네트워크 정보 확인

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
└── README.md                        # 루트 문서
```