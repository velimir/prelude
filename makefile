.PHONY: all clean

all:
	./install-package.el --pkg cmake-mode
	./install-package.el --pkg markdown-mode
	./install-package.el --pkg color-theme-solarized
	./install-package.el --pkg json-mode
	./install-package.el --pkg column-enforce-mode
	./install-package.el --pkg magit
	./install-package.el --pkg jedi
	./install-package.el --pkg window-number
	./install-package.el --pkg yasnippet
	./install-package.el --pkg yaml-mode
	./install-package.el --pkg ruby-tools
	./install-package.el --pkg robe
	./install-package.el --pkg flymake-ruby
	./install-package.el --pkg haml-mode
	./install-package.el --pkg flymake-haml
	./install-package.el --pkg projectile
	./install-package.el --pkg projectile-rails
	./install-package.el --pkg flx-ido
	./install-package.el --pkg w3m
	./install-package.el --pkg ix
	./install-package.el --pkg feature-mode
	./install-package.el --pkg coffee-mode
	./install-package.el --pkg company
	./install-package.el --pkg rspec-mode
	./install-package.el --pkg wgrep
	./install-package.el --pkg erlang
	./install-package.el --pkg elixir-mode
	./install-package.el --pkg elixir-mix
	./install-package.el --pkg elixir-yasnippets
	./install-package.el --pkg alchemist
	./install-package.el --pkg smex
	./install-package.el --pkg format-sql
	git submodule update --init
	make -C plug/edts all
clean:
	rm -rf elpa
