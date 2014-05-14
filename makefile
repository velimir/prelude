.PHONY: all clean

all:
	./install-package.el --pkg cmake-mode
	./install-package.el --pkg markdown-mode
	./install-package.el --pkg solarized-theme
	./install-package.el --pkg json-mode
	./install-package.el --pkg column-enforce-mode
	./install-package.el --pkg magit
	./install-package.el --pkg jedi
	./install-package.el --pkg window-number
	./install-package.el --pkg yasnippet
	./install-package.el --pkg yaml-mode
	./install-package.el --pkg ruby-tools
	git submodule update --init
	make -C plug/edts all
clean:
	rm -rf elpa
