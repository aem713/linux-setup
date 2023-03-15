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
printf '1\ny\n' | sudo nala fetch
sudo nala fetch

# 5) Update and Upgrade system
sudo nala upgrade -y

# 6) Install all needed packages
sudo apt install -y vim git v4l2loopback-dkms ffmpeg obs-studio neofetch gimp shotcut spotify-client gnuradio gparted hwloc

# 7) Download all needed .deb files
wget -c --content-disposition -i deb.txt

# 8) Install all .deb files
for file in *.deb; do
    [ -f "$file" ] || continue
    sudo gdebi $file --n;
done

# 9) Delete all .deb files
rm *.deb

#10) Install VS Code Extensions
code --install-extension jdinhlife.gruvbox

# 10) Create .bash_aliases file
if [ -e ~/.bash_aliases ]; then
    echo "File ~/.bash_aliases already exists!"
else
    cat << 'EOF' > ~/.bash_aliases
:() { clear $@ && pwd && ls; }
cl() { cd $@ && ls; }
ck () { cd $@ && clear && ls; }
EOF
fi

# 11) Install auto-cpufreq
cd ..
git clone https://github.com/AdnanHodzic/auto-cpufreq.git
cd auto-cpufreq && printf 'i\n' | sudo ./auto-cpufreq-installer
sudo auto-cpufreq --install
cd ..

# 12) Set up QEMU-KVM
if [ $(egrep -c '(vmx|svm)' /proc/cpuinfo) -gt 0 ]; then
    sudo apt install -y qemu-kvm qemu-system qemu-utils python3 python3-pip libvirt-clients libvirt-daemon-system bridge-utils virtinst libvirt-daemon virt-manager
    sudo apt install -y qemu-system-x86 libvirt-clients libvirt-daemon-system libvirt-daemon-config-network bridge-utils virt-manager ovmf
    sudo virsh net-start default
    sudo virsh net-autostart default
    sudo virsh net-list --all
    newgrp libvirt # Allows user to join libvirt group without logout
    sudo usermod -aG libvirt $USER
    sudo usermod -aG libvirt-qemu $USER
    sudo usermod -aG kvm $USER
    sudo usermod -aG input $USER
    sudo usermod -aG disk $USER
    # Also set up VM via virsh
else
    echo "Virtualization is not enabled in UEFI"
fi

sudo mkdir /var/lib/libvirt/images/isos
#sudo cp /media/*/*/Windows10-22H2.iso /media/*/*/virtio-win.iso /var/lib/libvirt/images/isos
#sudo wget -cP /var/lib/libvirt/images/isos https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/stable-virtio/virtio-win.iso
#sudo wget -cP /var/lib/libvirt/images/isos https://software.download.prss.microsoft.com/dbazure/Win10_22H2_English_x64.iso?t=7ba00706-ef7a-4923-8f53-bd4b65fc75aa&e=1672445294&h=1ac5458900406bdd047d283039b3a18a2dc574e2583d49cf8f01a2ec373daf26

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
