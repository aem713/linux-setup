#!/bin/bash

# Linux Mint settings
#   1) Set fractional scaling (Doesn't work)
#       xrandr --listmonitors
#       xrandr --output <monitor name> --scale 0.80x0.80
#   2) Increase Trackpad speed (I don't care) 
#   3) Switch to Local Mirror in Update Manager

# 4) Install and set up Nala
sudo apt install nala -y
printf '1 2 3 4\ny\n' | sudo nala fetch

# 5) Update and Upgrade system
sudo nala upgrade -y

# 6) Create work directory
mkdir ~/work

# 7) Install all needed packages
sudo nala install -y vim neofetch v4l2loopback-dkms ffmpeg obs-studio gimp shotcut spotify-client git gnuradio gparted

# 8) Download all needed .deb files
wget -ci --content-disposition deb.txt

# 9) Install all .deb files
for file in *.deb; do
    [ -f "$file" ] || continue
    sudo gdebi $file --n;
done

# 10) Delete all .deb files
rm *.deb

# 11) Create .bash_aliases file
if [ -e ~/.bash_aliases ]; then
    echo "File ~/.bash_aliases already exists!"
else
    cat << 'EOF' > ~/.bash_aliases
:() { clear $@ && pwd && ls; }
cl() { cd $@ && ls; }
ck () { cd $@ && clear && ls; }
EOF
fi

# 12) Set up QEMU-KVM
if [ $(egrep -c '(vmx|svm)' /proc/cpuinfo) -gt 0 ]; then
    sudo nala install -y qemu-kvm qemu-system qemu-utils python3 python3-pip libvirt-clients libvirt-daemon-system bridge-utils virtinst libvirt-daemon virt-manager
    sudo systemctl status libvirtd.service
    sudo virsh net-start default
    sudo virsh net-autostart default
    sudo virsh net-list --all
    sudo usermod -aG libvirt $USER
    sudo usermod -aG libvirt-qemu $USER
    sudo usermod -aG kvm $USER
    sudo usermod -aG input $USER
    sudo usermod -aG disk $USER
else
    echo "Virtualization is not enabled in UEFI"
fi