#!/bin/bash 
DIR=$(dirname ${BASH_SOURCE[0]})
echo $(hostname -I | cut -d\  -f1) $(hostname) | sudo tee -a /etc/hosts

sudo apt update
# sudo apt full-upgrade -y
sudo apt install -y \
    git-lfs \
    python3-pip \
    tmux \
    vim \
    zsh
sudo apt-get remove docker docker-engine docker.io containerd runc
sudo apt-get update
sudo apt-get install \
    ca-certificates \
    curl \
    gnupg
sudo mkdir -m 0755 -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo apt autoremove
sudo pip3 install --upgrade pip
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
    streamlit

# zsh
export RUNZSH=no
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
[ ! -z "lspci | grep -i nvidia" ] && sudo pip3 install --upgrade nvitop

# Prompt the user to enter their email
read -p "Enter your email: " email
# Prompt the user to enter their name
read -p "Enter your name: " name
# Set the email and name as the global Git configuration
git config --global user.email "$email"
git config --global user.name "$name"
echo "Git global configuration updated with email: $email and name: $name"

compaudit | xargs chmod g-w,o-w