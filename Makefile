# initialize file structure
config-setup:
	mkdir -p .vim/autoload
	mkdir -p .vim/colors
	mkdir -p .vim/synthax
	mkdir -p .vim/plugin
	mkdir -p .vim/spell
	mkdir -p .vim/config
	mkdir -p .vim/bundle

plugins-install: config-setup pathogen
	git clone git@github.com:vim-scripts/colorizer.git .vim/bundle/colorizer
	git clone git@github.com:Raimondi/delimitMate.git .vim/bundle/delimitMate
	git clone git@github.com:itchyny/lightline.vim.git .vim/bundle/lightline.vim
	git clone git@github.com:scrooloose/nerdtree.git .vim/bundle/nerdtree
	git clone git@github.com:vim-scripts/nextval.git .vim/bundle/nextval

pathogen: config-setup
	git clone https://github.com/tpope/vim-pathogen.git .vim/pathogen
	ln -s .vim/pathogen/autoload/pathogen.vim .vim/autoload/pathogen.vim

vimrc: pathogen
	cp vimrc .vim/vimrc
	ln -s .vim/vimrc .vimrc


install: pathogen plugins-install vimrc
	@echo done.
