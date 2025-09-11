# 01. 시스템 구성 정보 확인 (Linux)
시스템 문제를 파악하는 출발점인 커널·CPU·메모리·디스크·네트워크의 현재 상태 분석하는 것이 중요합니다.

## 1.1 커널 정보 확인하기
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