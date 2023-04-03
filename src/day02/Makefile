# image
IMG = helloos
# Initial Program Loader
IPL = ipl

$(IMG).img : $(IPL).bin Makefile
	../../z_tools/edimg.exe imgin:../../z_tools/fdimg0at.tek wbinimg src:$(IPL).bin len:512 from:0 to:0 imgout:$(IMG).img

$(IPL).bin : $(IPL).nas Makefile
	../../z_tools/nask.exe $(IPL).nas $(IPL).bin $(IPL).lst

run : $(IMG).img
	qemu-system-x86_64 -drive format=raw,file=$(IMG).img

clean:
	@rm *.lst *.bin *.img