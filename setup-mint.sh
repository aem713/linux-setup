#!/bin/bash

# Linux Mint settings (maybe have flags based on what distro I'm using)
#   1) Set fractional scaling to 125% (Doesn't work) 
#       xrandr --listmonitors
#       xrandr --output <monitor name> --scale 0.80x0.80
#   2) Increase Trackpad speed (I don't care) 
#   3) Switch to Local Mirror in Update Manager
#
# Firefox Settings
#   1) Install UBlock Origin and Video Speed Controller (And change VSC settings)

# 4) Install and set up Nala
sudo apt install nala -y
printf '1 2 3 4\ny\n' | sudo nala fetch

# 5) Update and Upgrade system
sudo nala upgrade -y

# 6) Create work directory
mkdir ~/work

# 7) Install all needed packages
sudo nala install -y vim neofetch v4l2loopback-dkms ffmpeg obs-studio gimp shotcut spotify-client git gnuradio gparted hwloc

# 8) Download all needed .deb files
wget -c --content-disposition -i deb.txt

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
    sudo virsh net-start default
    sudo virsh net-autostart default
    sudo virsh net-list --all
    sudo usermod -aG libvirt $USER
    sudo usermod -aG libvirt-qemu $USER
    sudo usermod -aG kvm $USER
    sudo usermod -aG input $USER
    sudo usermod -aG disk $USER
    # Also set up VM via virsh
else
    echo "Virtualization is not enabled in UEFI"
fi

# Future script for automated creation of the VM
# Download hwloc
# lstopo will show the map of CPUs
# virsh vcpuinfo win10 will show the cpu info of the VM
# virsh edit win10
#   Under <vcpu placement='static'>14</vcpu> , write:
#   <iothreads>1</iothreads>
#   <cputune>
#       <vcpupin vcpu='0' cpuset='2'/>
#       <vcpupin vcpu='1' cpuset='3'/>
#       <vcpupin vcpu='2' cpuset='4'/>
#       <vcpupin vcpu='3' cpuset='5'/>
#       <vcpupin vcpu='4' cpuset='6'/>
#       <vcpupin vcpu='5' cpuset='7'/>
#       <emulatorpin ccpuset='0-1'/>
#       <iothreadpin iothread='1' cpuset='0-1'/> 
#   </cputune>
#
# Alternatively can do <vcpu placement='static' cpuset='6-11'>14</vcpu>