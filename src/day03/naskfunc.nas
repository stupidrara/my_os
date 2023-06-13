; naskfunc

[FORMAT "WCOFF"]                ; 目的檔案的製作模式
[BITS 32]                       ; 用來製作32位元模式用的機械代碼

; 為了目的檔案的資訊

[FILE "naskfunc.nas"]           ; 原始程式檔名資訊
        GLOBAL _io_hlt          ; 在這個城市裡包含的函數名稱

[SECTION .text]                 ; 目的檔案寫了這以上段敘述後再寫程式
; 實際函數
_io_hlt:  ; void io_hlt(void)
        HLT
        RET
