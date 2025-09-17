# 02. top 명령어를 사용한 프로세스 확인
top 명령은 시스템 상태를 전반적으로 빠르게 파악할 수 있습니다.

## 2.1 시스템 상태 확인
- 실행 스크립트: `system-status.sh`
- 출력 로그: `system-status.log`

### 핵심 명령

시스템 상태 확인
- top 명령은 옵션 없이 입력하면 interval 간격 3초로 화면 갱신
- -b(batch mode) 옵션은 실시간으로 화면을 갱신하지 않고 모든 출력을 한 번에 터미널로 보냄.
- -n(number of iterations) 옵션은 실행 횟수를 지정
```bash
top -b -n 1
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

## 2.2 VIRT(Virtual Memory)
- 실행 JS: `test-virt.js`
- 실행 스크립트: `virt.sh`
- 출력 로그: `virt.log`

VIRT는 프로세스가 운영체제에 사용을 예약받은 전체 메모리 공간을 의미합니다.
프로세스가 당장 사용하지 않아도 확보해 둔 메모리 영역을 뜻합니다. 

메모리 영역 요청
- 프로세스가 운영체제에 메모리 공간을 사용할 수 있도록 요청하는 행위
- 운영체제는 실제 물리적 메모리를 당장 할당하지 않고도 특정 크기의 가상 메모리 주소 공간을 프로세스에 할당
- 이 단계에서는 메모리를 쓰거나 읽지 않아도 top 명령어의 VIRT 값이 증가

### 핵심 코드
다음 스크립트는 100MB의 가상 메모리 영역을 요청합니다.
- 실행 JS: `test-virt.js`

```javascript
// 100MB의 가상 메모리 공간을 요청합니다.
const sizeInBytes = 1024 * 1024 * 100; 
const virtBuffer = Buffer.alloc(sizeInBytes); 
//  <Buffer 00 00 00  ...  104857550 more bytes>
// Buffer.alloc() 메소드는 메모리를 할당할 때 기본적으로 모든 값을 0으로 초기화하며 이는 가상 메모리 주소만 확보한 상태입니다.
// 따라서 콘솔에는 16진수 값인 00이 반복해서 보임

// top 명령어를 통해 할당된 VIRT 값을 확인할 수 있도록 프로세스 종료하지 않고 대기
process.stdin.setRawMode(true);
process.stdin.resume();
process.stdin.on('data', () => {
  console.log('테스트를 종료합니다.');
  process.exit(0);
});
```

### 핵심 명령
top -u <유저 이름> 옵션을 이용하여 node 프로세스를 보다 쉽게 찾을 수 있고, test-virt.js가 실행된 node 프로세스의 VIRT 값이 증가한 것을 확인할 수 있습니다.

```bash
# 출력 예시: 
# top - 13:56:18 up 92 days,  9:32,  3 users,  load average: 0.13, 0.12, 0.12
# Tasks: 161 total,   1 running, 160 sleeping,   0 stopped,   0 zombie
# %Cpu(s):  2.5 us,  1.4 sy,  0.0 ni, 96.0 id,  0.1 wa,  0.0 hi,  0.1 si,  0.0 st 
# MiB Mem :  15736.6 total,   7938.6 free,   1188.6 used,   6962.3 buff/cache     
# MiB Swap:      0.0 total,      0.0 free,      0.0 used.  14548.0 avail Mem 

#     PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND              
# 3675605 parkmin+  20   0   13212   6400   4224 R   0.3   0.0   0:00.15 top                  
#    1470 parkmin+  20   0   20488  11520   9344 S   0.0   0.1   0:00.41 systemd              
# ...    
# 3675722 parkmin+  20   0 1113000  44672  37760 S   0.0   0.3   0:00.03 node  
```

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