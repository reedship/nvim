#!/usr/bin/env bash
is_linux=false
tmux_doesnt_exist_or_is_empty=false



if [[ "$(uname -s)" == "Linux" ]]; then
    is_linux=true
fi
file="~/.tmux.conf"

if [ -f "$file" ]; then
    if [ ! -s "$file" ]; then
        echo "tmux file is empty"
        # file is empty
        tmux_doesnt_exist_or_is_empty=true
    fi
else
    echo "tmux file does not exist."
    tmux_doesnt_exist_or_is_empty=true
fi

if ! command -v nvim 2>&1 >/dev/null; then
    if ! $is_linux; then
        echo "Installing for mac"
        # install homebrew if it's not present
        if ! command -v brew 2>&1 >/dev/null; then
            curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh
        fi
        git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim
        export HOMEBREW_NO_AUTO_UPDATE=1
        brew install ripgrep
        brew install fzf
        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
        source ~/.zshrc
        nvm install --lts
        brew install neovim
        brew install typescript
        brew install typescript-language-server
    else
        echo "Installing for linux"
        git clone --depth 1 https://github.com/wbthomason/packer.nvim\
             ~/.local/share/nvim/site/pack/packer/start/packer.nvim
        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
        sudo apt install -y build-essential rg libtool autoconf automake cmake libncurses5-dev g++
        sudo add-apt-repository ppa:neovim-ppa/unstable
        sudo apt install neovim
    fi
else
    echo "nvim already installed."
fi

if ! command -v tmux 2>&1 >/dev/null; then
    echo "Tmux not found. Installing"
    if ! $is_linux; then
        echo "installing tmux on mac"
        brew install tmux
    else
        echo "installing tmux on linux"
        sudo apt install tmux
    fi
else
    echo "tmux already installed"
    if $tmux_doesnt_exist_or_is_empty; then
        # call wget to get upto date .tmux.conf
        echo "getting .tmux.conf file"
        wget https://raw.githubusercontent.com/reedship/tmux-conf/refs/heads/main/.tmux.conf -P ~/
    fi
fi

# what else do I need to get configured?
# for mac I think all i need is nvm, node
