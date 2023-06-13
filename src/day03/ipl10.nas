; nask assembly
; RaRaOS

; DB:Data byte
; DW:Data word
; DD:Data double word
; RESB: Reserve byte


    ORG     0x7c00              ; 將IPL讀入0x7c00(硬性規定)

; 以下是標準FAT12格式的軟式磁片的描述資訊

    JMP     entry
    DB		0x90
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
    DB      "RaRaOS     "       ; 磁碟片的名稱(11個位元組)
    DB      "FAT12   "          ; 格式名稱(8個位元組)
    RESB    18                  ; 暫時騰出18個位元組

; 程式碼本身
CYLS EQU    10

entry:
    MOV     AX, 0x0820
    MOV     ES, AX
    MOV     CH, 0               ; 磁柱 0
    MOV     DH, 0               ; 磁頭 0
    MOV     CL, 2               ; 磁區 2

readloop:
    MOV     SI, 0               ; 計算失敗次數的暫存器

retry:
    MOV     AH, 0x02            ; 讀入磁碟片
    MOV     AL, 1               ; 處理1磁區
    MOV     BX, 0               ;
    MOV     DL, 0x00            ; A磁碟機
    INT     0x13                ; 呼叫 BIOS interrupt
    JNC     next                ; 沒出現錯誤就跳到next
    ADD     SI, 1               ; SI++
    CMP     SI, 5               ; 比較SI和5
    JAE     error               ; 如果SI >= 5 則跳到error
    MOV     AH, 0x00            ;
    MOV     DL, 0x00            ; A磁碟機
    INT     0x13                ; 磁碟機重設
    JMP     retry

next:
    MOV     AX, ES
    ADD     AX, 0x0020
    MOV     ES, AX
    ADD     CL, 1               ; CL++ (sector)
    CMP     CL, 18              ; 比較CL和18
    JBE     readloop            ; CL <= 18則到readloop
    MOV     CL, 1
    ADD     DH, 1
    CMP     DH, 2
    JB      readloop            ; 
    MOV     DH, 0
    ADD     CH, 1
    CMP     CH, CYLS
    JMP     fin

fin:
    JMP     0xc200

error:
    MOV     AX, 0               ; AX = 0
    MOV     SS, AX              ; SS = AX
    MOV     SP, 0x7c00
    MOV     DS, AX
    MOV     ES, AX
    MOV     SI, err_msg
putloop:
    MOV     AL, [SI]            ; AL = *SI
    ADD     SI, 1               ; SI += 1
    CMP     AL, 0
    JE      fin
    MOV     AH, 0x0e            ; 一個文字表示功能
    MOV     BX, 15              ; 顏色代碼
    INT     0x10                ; 呼叫視訊BIOS
    JMP     putloop
err_msg:
    DB      0x0a, 0x0a          ; 兩個換行
    DB      "error"
    DB      0x0a                ; 換行
    DB      0


    ;RESB    0x1fe-($-$$)        ; '$' 代表目前行的位址，'$$' 為目前 section 的位址，在此為0x7c00
    RESB    0x7dfe-$
    DB      0x55, 0xaa          ; 需讀到 55 AA 才可開機


; 以上為開機磁區(512B)
