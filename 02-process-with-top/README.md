# 02. top 명령어를 사용한 프로세스 확인
top 명령은 시스템 상태를 전반적으로 빠르게 파악할 수 있습니다.

## 2.1 시스템 상태 확인
- 실행 스크립트: `system-status.sh`
- 출력 로그: `system-status.log`

### 핵심 명령

시스템 상태 확인
```bash
top -b -n 1
# top 명령은 옵션 없이 입력하면 interval 간격 3초로 화면 갱신
# -b(batch mode) 옵션은 실시간으로 화면을 갱신하지 않고 모든 출력을 한 번에 터미널로 보냄.
# -n(number of iterations) 옵션은 실행 횟수를 지정
# 출력 예시:
# top - 09:07:05 up 91 days,  4:43,  2 users,  load average: 0.07, 0.08, 0.13
# Tasks: 156 total,   1 running, 155 sleeping,   0 stopped,   0 zombie
# %Cpu(s):  2.4 us,  2.4 sy,  0.0 ni, 95.2 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st 
# MiB Mem :  15736.6 total,   8673.4 free,   1135.9 used,   6280.2 buff/cache     
# MiB Swap:      0.0 total,      0.0 free,      0.0 used.  14600.7 avail Mem 
#
#     PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND
#   31518 root      20   0 1464800 278400  80128 S  18.2   1.7     12,40 kube-apiserver
# 3235858 parkmin+  20   0   13200   6016   3968 R   9.1   0.0   0:00.01 top
#       1 root      20   0   22936  14336   9600 S   0.0   0.1   9:53.00 systemd
#       2 root      20   0       0      0      0 S   0.0   0.0   0:02.99 kthreadd
#       3 root      20   0       0      0      0 S   0.0   0.0   0:00.00 pool_workqueue_release
#       4 root       0 -20       0      0      0 I   0.0   0.0   0:00.00 kworker/R-rcu_g
# ...

```

## 2.2 CPU 정보 확인
- 실행 스크립트: `virt-res-shr.sh`
- 출력 로그: `virt-res-shr.log`

### 핵심 명령

```bash

# 
# 출력 예시:
# 
```

## 2.3 메모리 정보 확인
- 실행 스크립트: `virt-res-memory-commit.sh`
- 출력 로그: `virt-res-memory-commit.log`

### 핵심 명령

```bash

# 
# 출력 예시:
# 
```

## 2.4 디스크 정보 확인
- 실행 스크립트: `process-status.sh`
- 출력 로그: `process-status.log`

### 핵심 명령

```bash

# 
# 출력 예시:
# 
```

## 2.5 네트워크 정보 확인
- 실행 스크립트: `process-priority.sh`
- 출력 로그: `process-priority.log`

### 핵심 명령

```bash

# 
# 출력 예시:
# 
```