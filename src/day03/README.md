# day03

## 進度
參考 [wiki BIOS中斷呼叫(interrupt)](https://wiki.osdev.org/ATA_in_x86_RealMode_(BIOS))

- 查詢 interrupt 中斷表 `INT 0x13`  
- interrupt 使用 register 中的值作為引數
  -  如 `AH 0x02` 代表讀取硬碟，詳情參考wiki

ipl10.nas 可將磁碟中10個磁柱讀進 memory。
asmhead.nas 在編譯後會是磁碟內的檔案，在ipl執行完成後會跳到此執行。
bootpack.c 會接著執行 asmhead 內的程式碼，若有C語言無法辦到的程式碼能 link naskfunc.nas 的 function 來執行。
naskfunc.nas 可用 assembly 寫 function，編譯時會link。
