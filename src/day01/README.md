# day 1

## 進度
os的hello world

## How to compile nas file
```bash
../z_tools/nask.exe helloos.nas helloos.img
```

## How to run helloos.img
```bash
cp helloos.img ..\z_tools\qemu\fdimage0.bin
../z_tools/make.exe -r -C ../z_tools/qemu
```