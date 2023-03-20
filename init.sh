#!/bin/bash 
DIR=$(dirname ${BASH_SOURCE[0]})
sudo apt update
sudo apt full-upgrade -y
sudo apt install -y \
    git-lfs \
    libgl-dev \
    python3-pip \
    tmux \
    vim \
    zsh
sudo apt autoremove
sudo pip3 install --upgrade pip
# Sometimes we have problem with TF if we have old fllatbuffers
sudo pip3 uninstall flatbuffers
# PyYAML has problem with deleting cause by distutils
sudo pip3 install --upgrade --ignore-installed PyYAML
sudo pip3 install --upgrade \
    flatbuffers \
    ipython \
    jinja2 \
    kornia \
    mypy \
    numpy \
    pylint \
    streamlit \
    streamlit_drawable_canvas

# zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh) -y"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
sed -i $'s/plugins=(git)/plugins=(\\\n\tgit\\\n\tzsh-syntax-highlighting\\\n\tzsh-autosuggestions)\\\n/' ~/.zshrc

# dotfiles
mkdir -p $HOME/.ssh
cp $DIR/tmux.conf $HOME/.tmux.conf
cp $DIR/profile-full-zsh $HOME/.profile
cp $DIR/zprofile $HOME/.zprofile
cp $DIR/ssh/rc $HOME/.ssh/rc

# GPU monitoring
nvidia-smi -L >/dev/null 2>&1 && sudo pip3 install --upgrade nvitop

# Prompt the user to enter their email
read -p "Enter your email: " email
# Prompt the user to enter their name
read -p "Enter your name: " name
# Set the email and name as the global Git configuration
git config --global user.email "$email"
git config --global user.name "$name"
echo "Git global configuration updated with email: $email and name: $name"

compaudit | xargs chmod g-w,o-w