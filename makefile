.PHONY: all clean

all:
	./install-package.el --pkg cmake-mode
	./install-package.el --pkg markdown-mode
	./install-package.el --pkg solarized-theme
	git submodule update --init
	make -C plug/edts all
clean:
	rm -rf elpa
