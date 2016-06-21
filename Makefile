# initialize file structure
list:
	@while read -r plugin; do \
		echo "$$plugin"; \
	done <plugins.md

# create folder structure for pathogen
config-setup:
	mkdir -p .vim/autoload
	mkdir -p .vim/colors
	mkdir -p .vim/synthax
	mkdir -p .vim/plugin
	mkdir -p .vim/spell
	mkdir -p .vim/config
	mkdir -p .vim/bundle

# install all plugins
plugins-install: pathogen
	cd .vim/bundle && \ 
	while read -r plugin; do \
		git clone `$$plugin`; \
	done <plugins.md

# install pathogen plugin manager
pathogen: config-setup
	git clone https://github.com/tpope/vim-pathogen.git .vim/pathogen
	ln -s .vim/pathogen/autoload/pathogen.vim .vim/autoload/pathogen.vim

# link .vimrc
vimrc: pathogen
	cp vimrc .vim/vimrc
	ln -s .vim/vimrc .vimrc

# main task, install all
install: pathogen plugins-install vimrc
	@echo done.
