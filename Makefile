# initialize file structure
list:
	@while read -r plugin; do \
		echo "$$plugin"; \
	done <plugins.md

config-setup:
	mkdir -p .vim/autoload
	mkdir -p .vim/colors
	mkdir -p .vim/synthax
	mkdir -p .vim/plugin
	mkdir -p .vim/spell
	mkdir -p .vim/config
	mkdir -p .vim/bundle

plugins-install: config-setup pathogen
	cd .vim/bundle && \ 
	@while read -r plugin; do \
		git clone `$$plugin`; \
	done <plugins.md

pathogen: config-setup
	git clone https://github.com/tpope/vim-pathogen.git .vim/pathogen
	ln -s .vim/pathogen/autoload/pathogen.vim .vim/autoload/pathogen.vim

vimrc: pathogen
	cp vimrc .vim/vimrc
	ln -s .vim/vimrc .vimrc

install: pathogen plugins-install vimrc
	@echo done.
