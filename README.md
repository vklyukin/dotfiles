# Config Initialization on a New VM
This is a Bash script called init.sh that automates the process of initializing a new virtual machine with some basic configurations.

## Prerequisites
- The script assumes that you have sudo privileges on the virtual machine.
- The script is designed for Ubuntu-based systems.
- The script requires an internet connection to install and update packages.

## What does it do?
The init.sh script performs the following actions:

- Updates and upgrades the system packages using apt.
- Installs some essential packages like git-lfs, libgl-dev, python3-pip, tmux, vim, and zsh.
- Upgrades pip3 and installs some Python packages like flatbuffers, ipython, jinja2, kornia, mypy, numpy, pylint, streamlit, and streamlit_drawable_canvas.
- Installs and configures the zsh shell with plugins like zsh-syntax-highlighting and zsh-autosuggestions.
- Copies some dotfiles to the home directory like tmux.conf, profile-full-zsh, zprofile, and ssh/rc.
- Installs nvitop package to monitor the GPU.
- Prompts the user to enter their email and name, and sets them as the global Git configuration.
- Sets the permission of some files to remove write permission for group and others.

## Usage
To use this script, simply run the following command in the terminal:

```bash
sh init.sh
```
The script will take care of the rest.

## Disclaimer
This script is provided as-is without any warranty or support. Use it at your own risk.
