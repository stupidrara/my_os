; nask assembly
; hello-os

; DB:Data byte
; DW:Data word
; DD:Data double word
; RESB: Reserve byte

; 以下是標準FAT12格式的軟式磁片的描述資訊

    DB      0xeb, 0x4e, 0x90
    DB      "HELLOIPL"          ; 開機磁區的名稱
    DW      512                 ; 1磁區的大小
    DB      1                   ; 叢集的大小(必須是1磁區)
    DW      1                   ; FAT要從哪開始(通常是從第1磁區開始)
    DB      2                   ; FAT的個數(必須是2)
    DW      224                 ; 根目錄的大小(普通是設成224項目)
    DW      2880                ; 這個磁碟機大小(必須是2880磁區)
    DB      0xf0                ; 媒體的格式(必須是0xf0)
    DW      9                   ; FAT區域範圍的長度(必須是9磁區)
    DW      18                  ; 1磁軌有幾個磁區(必須是18)
    DW      2                   ; 磁頭個數(必須是2)
    DD      0                   ; 不使用磁碟分割，此處必須是0
    DD      2880                ; 這個磁碟機大小再寫一次
    DB      0, 0, 0x29          ; ?
    DD      0xffffffff          ; 大概是磁碟區序號
    DB      "HELLO_OS   "       ; 磁碟片的名稱(11個位元組)
    DB      "FAT12   "          ; 格式名稱(8個位元組)
    RESB    18                  ; 暫時騰出18個位元組

; 程式碼本身

    DB      0xb8, 0x00, 0x00, 0x8e, 0xd0, 0xbc, 0x00, 0x7c
    DB      0x8e, 0xd8, 0x8e, 0xc0, 0xbe, 0x74, 0x7c, 0x8a
    DB      0x04, 0x83, 0xc6, 0x01, 0x3c, 0x00, 0x74, 0x09
    DB      0xb4, 0x0e, 0xbb, 0x0f, 0x00, 0xcd, 0x10, 0xeb
    DB      0xee, 0xf4, 0xeb, 0xfd

; 訊息部分

    DB      0x0a, 0x0a          ; 兩個換行
    DB      "hello, world"
    DB      0x0a                ; 換行
    DB      0

    RESB    0x1fe-$             ; 填入0x00直到0x001fe為止的命令

    DB      0x55, 0xaa          ; 需讀到 55 AA 才可開機
; 以上為開機磁區(512B)
;---------------------------------------

; 以下是開機磁區以外部分的描述內容

    DB      0xf0, 0xff, 0xff, 0x00, 0x00, 0x00, 0x00, 0x00
    RESB    4600
    DB      0xf0, 0xff, 0xff, 0x00, 0x00, 0x00, 0x00, 0x00
    RESB    1469432
