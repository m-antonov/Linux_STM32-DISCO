target = stm32f746
version = 2020.05
board = $(target)

ifeq ($(target),stm32f746)
	board = stm32f7
endif

path = buildroot-$(version)
url = https://buildroot.org/downloads/$(path).tar.gz
dir_download = download
dir_source = source
dir_tftp = /srv/tftp/

bootstrap:
	mkdir -p $(dir_download)
	mkdir -p $(dir_source)
	wget -O $(dir_download)/$(path).tar.gz $(url)
	tar xvf $(dir_download)/$(path).tar.gz -C $(dir_source)
	cp config/$(target)_disco_defconfig $(dir_source)/$(path)/configs

build:
	make -C $(dir_source)/$(path) $(target)_disco_defconfig
	make -C $(dir_source)/$(path)

tftp:
	cp $(dir_source)/$(path)/output/images/$(target)-disco.dtb $(dir_tftp)
	cp $(dir_source)/$(path)/output/images/zImage $(dir_tftp)

flash_bootloader:
	cd $(dir_source)/$(path)/output/build/host-openocd-0.10.0/tcl && ../../../host/usr/bin/openocd \
		-f board/$(board)discovery.cfg \
		-c "init" \
		-c "reset init" \
		-c "flash probe 0" \
		-c "flash info 0" \
		-c "flash write_image erase ../../../images/u-boot-spl.bin 0x08000000" \
		-c "flash write_image erase ../../../images/u-boot.bin 0x08008000" \
		-c "reset run" \
		-c shutdown

clean:
	rm -rf $(dir_source) $(dir_download)
