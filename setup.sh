#!/usr/bin/env zsh

echo "Please go away for a cup for coffee, it may take for a while."
if which apt-get >/dev/null; then
	sudo apt-get update
	sudo add-apt-repository ppa:jonathonf/vim
	sudo apt-get install -y vim exuberant-ctags clang-format fzf
	pip3 install pathtools
else
	echo "Platforms other than Ubuntu are not supported currently."
	exit
fi

# use google style as the default format style, and backup it first
if [[ -f "$HOME"/.clang-format ]]; then mv "$HOME"/.clang-format "$HOME"/.clang-format.bak; fi
clang-format -style=google -dump-config > $HOME/.clang-format

# Save old vim configurations
mv -f ~/.vim ~/.vim_old
mv -f ~/.vimrc ~/.vimrc_old

# Clone current repo and install plugins
git clone --recurse-submodules https://github.com/sunbingfeng/dot-vim.git ~/.vim && cd ~/.vim
ln -s ~/.vim/.vimrc ~/.vimrc
ln -s ~/.vim/ftplugin.vim/ftdetect ~/.vim/ftdetect
ln -s ~/.vim/ftplugin.vim/after ~/.vim/after

# Install vim-plug package manager
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

temp_file="$(mktemp -t "install.XXXXXXXXXX")"
echo "Installing the plugins" > $temp_file
echo "Please wait for a while." >> $temp_file

vim $temp_file -c "PlugInstall" -c "q" -c "q"
rm -f -- "$temp_file"

echo "Install Successed."
