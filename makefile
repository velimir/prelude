.PHONY: all clean

all:
	./install-package.el --pkg cmake-mode
	./install-package.el --pkg markdown-mode
	./install-package.el --pkg solarized-theme

clean:
	rm -rf elpa
