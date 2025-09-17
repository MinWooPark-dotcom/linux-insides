const sizeInBytes = 1024 * 1024 * 100;
const virtBuffer = Buffer.alloc(sizeInBytes); 

console.log("VIRT 값 증가, RES 값은 거의 변하지 않음.");

process.stdin.setRawMode(true);
process.stdin.resume();
process.stdin.on('data', () => {
  console.log('테스트를 종료합니다.');
  process.exit(0);
});
