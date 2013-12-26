.PHONY: all clean

all:
	./install-package.el --pkg cmake-mode
	./install-package.el --pkg markdown-mode
	./install-package.el --pkg solarized-theme
	./install-package.el --pkg json-mode
	./install-package.el --pkg column-enforce-mode
	git submodule update --init
	make -C plug/edts all
clean:
	rm -rf elpa
