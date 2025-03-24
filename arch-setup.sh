sudo pacman -S vim keepassxc fastfetch steam obs-studio spotify-launcher gnuradio-companion gparted btop qbittorrent torbrowser-launcher discord pinta
# Install vulkan-radeon

yay -S librewolf-bin mullvad-bin ungoogled-chromium-bin mullvad-browser-bin vscodium-bin minecraft-launcher onlyoffice-bin

# KDE Connect vs Android-Messages-Desktop

# Install QEMU + KVM + Virt manager
sudo pacman -S qemu virt-manager virt-viewer dnsmasq vde2 bridge-utils openbsd-netcat

# https://kskroyal.com/how-to-install-qemu-kvm-on-linux/
# lscpu | grep -i Virtualization # Should return AMD-V
# zgrep CONFIG_KVM /proc/config.gz
# sudo pacman -Syu
# sudo pacman -S --needed base-devel git
# git clone https://aur.archlinux.org/yay.git
# cd yay/
# makepkg -si
# cd ..
# rm -rf yay/
# sudo pacman -S qemu-full qemu-img libvirt virt-install virt-manager virt-viewer edk2-ovmf swtpm guestfs-tools libosinfo 
# yay -S tuned
# sudo systemctl enable libvirtd.service
# sudo systemctl start libvirtd.service
# sudo systemctl enable --now tuned
# tuned-adm list
# sudo tuned-adm profile virtual-host
# sudo reboot
# sudo virsh net-list --all
# sudo virsh net-start default
# sudo virsh net-autostart default

# https://computingforgeeks.com/install-kvm-qemu-virt-manager-arch-manjar/
# sudo pacman -S archlinux-keyring
# sudo pacman -S qemu virt-manager virt-viewer dnsmasq vde2 bridge-utils openbsd-netcat dmidecode
# sudo pacman -S ebtables iptables
# sudo pacman -S libguestfs
# sudo systemctl enable libvirtd.service
# sudo systemctl start libvirtd.service
# systemctl status libvirtd.service
# sudo vim /etc/libvirt/libvirtd.conf
# - unix_sock_group = "libvirt"
# - unix_sock_rw_perms = "0770"
# sudo usermod -a -G libvirt $(whoami)
# newgrp libvirt
# sudo systemctl restart libvirtd.service

# https://gist.github.com/tatumroaquin/c6464e1ccaef40fd098a4f31db61ab22
# lscpu | grep -i Virtualization
# zgrep CONFIG_KVM /proc/config.gz
# sudo pacman -S qemu-full qemu-img libvirt virt-install virt-manager virt-viewer edk2-ovmf dnsmasq swtpm guestfs-tools libosinfo tuned
# sudo systemctl enable libvirtd.service
# sudo virt-host-validate qemu

# https://christitus.com/setup-qemu-in-archlinux/
# sudo pacman -S qemu virt-manager virt-viewer dnsmasq vde2 bridge-utils openbsd-netcat ebtables iptables libguestfs
# unix_sock_group = "libvirt"
# unix_sock_rw_perms = "0770"
# sudo usermod -a -G libvirt $(whoami)
# newgrp libvirt

# https://www.youtube.com/watch?v=cN_a7NgBWX8
# sudo pacman -S qemu-full qemu-emulators-full virt-manager virt-viewer dnsmasq vde2 bridge-utils openbsd-netcat libvirt
# sudo systemctl enable libvirtd
# sudo systemctl start --now libvirtd
# sudo usermod -aG libvirt $(whoami)
# newgrp libvirt
# sudo EDITOR=nano virsh net-edit default
# sudo systemctl restart libvirtd
# sudo virsh net-start default
# sudo virsh net-autostart default
# qemu-system-x86_64 --version
# sudo virsh net-list --all
# virt-manager

# https://github.com/AriDeltaO/QEMU-KVM-Install-On-Arch-Linux
# sudo pacman -S qemu virt-manager virt-viewer dnsmasq vde2 bridge-utils openbsd-netcat ebtables iptables libguestfs swtpm ovmf
# sudo systemctl enable --now libvirtd
# sudo usermod -aG libvirt {user_name}
# sudo systemctl restart libvirtd
# sudo virsh start (VM-Name)
# remote-viewer spice://localhost:5900 -f