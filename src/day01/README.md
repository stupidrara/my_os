# day 1

## How to compile nas file
```bash
../../z_tools/nask.exe helloos.nas helloos_nas.img
```

## How to run helloos.img
- You need to install qemu
```bash
qemu-system-x86_64 -drive format=raw,file=helloos.img
```