#!/bin/bash

# 1) Append config values to /etc/dnf/dnf.conf
sudo sh -c 'echo "fastestmirror=True" >> /etc/dnf/dnf.conf'
sudo sh -c 'echo "max_parallel_downloads=10" >> /etc/dnf/dnf.conf'
sudo sh -c 'echo "defaultyes=True" >> /etc/dnf/dnf.conf'
sudo sh -c 'echo "keepcache=True" >> /etc/dnf/dnf.conf'

# 2) Update dnf
sudo dnf update

# 3) Enable RPM Fusion
sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

# 4) Allow installation of RPM Fusion packages via GUI
sudo dnf groupupdate core

#5) Add LibreWolf Repo
sudo dnf config-manager --add-repo https://rpm.librewolf.net/librewolf-repo.repo

#6) Import VS Code GPG Key
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc 

#7) Import VS Code repository
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'

#6) Install packages
sudo dnf install -y vim git vlc gnuradio neofetch librewolf gimp lpf-spotify-client gparted discord code

#7) Install Spotify
lpf update

#8) Install VS Code Extensions
code --install-extension jdinhlife.gruvbox
code --install-extension vscodevim.vim


# 4) Create Aliases
if [ -e ~/.bashrc.d/aliases ]; then
    echo "File ~/.bashrc.d/aliases already exists!"
else
    mkdir ~/.bashrc.d
    cat << 'EOF' > ~/.bashrc.d/aliases
:() { clear $@ && pwd && ls; }
cl() { cd $@ && ls; }
ck () { cd $@ && clear && ls; }
EOF
fi

# 5) Enable Flathub
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# 6) Change hostname
sudo hostnamectl set-hostname fedora

# 7) Install media codecs
sudo dnf groupupdate multimedia --setop="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin
sudo dnf groupupdate sound-and-video

# 8) Boost by having cache
sudo dnf copr enable elxreno/preload -y && sudo dnf install preload -y

# 9) Install Virtualization
sudo dnf install @virtualization

# 10) Start libvirtd
sudo systemctl start libvirtd
sudo systemctl enable libvirtd
lsmod | grep kvm

# 11) Make isos directory
sudo mkdir /var/lib/libvirt/images/isos

# 11) Install auto-cpufreq
git clone https://github.com/AdnanHodzic/auto-cpufreq.git
cd auto-cpufreq && printf 'i\n' | sudo ./auto-cpufreq-installer
sudo auto-cpufreq --install
cd ..

# How To Completely Remove Fedora Packages
# sudo dnf remove abc
# sudo dnf autoremove (removes orphaned packages which are dependancies of removed packages)
# sudo dnf clean packages (removes cached packages)
