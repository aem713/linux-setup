#!/bin/sh

# Linux Mint settings
#   1) Set fractional scaling (Doesn't work)
#       xrandr --listmonitors
#       xrandr --output <monitor name> --scale 0.80x0.80
#   2) Increase Trackpad speed (I don't care) 
#   3) Switch to Local Mirror in Update Manager

# 4) Update and Upgrade system
sudo apt update && sudo apt upgrade -y

# 5) Create work directory
mkdir ~/work

# 6) Install all needed packages
sudo apt install -y vim v4l2loopback-dkms ffmpeg obs-studio gimp kdenlive spotify-client git gnuradio

# 7) Download all needed .deb files
wget -i /media/*/*/linux-quickstart/deb.txt

# 8) Install all .deb files
for file in *.deb; do
    [ -f "$file" ] || continue
    sudo gdebi $file --n;
done

# 9) Delete all .deb files
rm *.deb

# 10) Create .bash_aliases file
if [ -e ~/.bash_aliases ]; then
    echo "File ~/.bash_aliases already exists!"
else
    cat > ~/.bash_aliases <<EOF
:() { clear $@ && pwd && ls; }
cl() { cd $@ && ls; }
ck () { cd $@ && clear && ls; }
EOF
fi

# 11) Set up QEMU-KVM
if [ egrep -c '(vmx|svm)' /proc/cpuinfo -ge 0 ]; then
    sudo apt install -y qemu-kvm qemu-system qemu-utils python3 python3-pip libvirt-clients libvirt-daemon-system bridge-utils virtinst libvirt-daemon virt-manager
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
    echo "Virtualization is not enabled in UEFI. Either that or I'm bad at bash scripting"
fi


