#!/bin/sh
#part1
printf '\033c'
echo "Welcome to the parabola-install script"
echo "Freeedoooommmm"
loadkeys fr
lsblk
sleep 1
sleep 1
echo "Enter the drive: "
read drive
cfdisk $drive 
lsblk
echo "Enter the linux partition: "
read partition
mkfs.ext4 $partition 
echo "Enter boot partition: "
read bootpartition
mkfs.ext4 $bootpartition
echo "Enter home partition: "
read homepartition
mkfs.ext4 $homepartition
mount $partition /mnt 
mkdir /mnt/boot
mkdir /mnt/home
mount $bootpartition /mnt/boot
mount $homepartition /mnt/home
pacman -Sy archlinux-keyring archlinuxarm-keyring parabola-keyring sed
pacman -U https://www.parabola.nu/packages/core/i686/archlinux32-keyring-transition/download/
pacman-key --refresh-keys
pacstrap /mnt base linux-libre networkmanager parabola-base grub wpa_supplicant dialog
genfstab -p /mnt >> /mnt/etc/fstab
sed '1,/^#part2$/d' parabola-install.sh > /mnt/arch_install2.sh
chmod +x /mnt/arch_install2.sh
arch-chroot /mnt ./arch_install2.sh
exit


#part2
printf '\033c'
pacman -S --noconfirm sed
ln -sf /usr/share/zoneinfo/Africa/Algiers /etc/localtime
hwclock --systohc
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf
echo "KEYMAP=fr" > /etc/vconsole.conf
echo "Hostname: "
read hostname
echo $hostname > /etc/hostname
echo "127.0.0.1       localhost" >> /etc/hosts
echo "::1             localhost" >> /etc/hosts
echo "127.0.1.1       $hostname.localdomain $hostname" >> /etc/hosts
mkinitcpio -P
passwd
systemctl enable NetworkManager
lsblk
echo "Enter boot partition: " 
grub-install $bootpartition
grub-mkconfig -o /boot/grub/grub.cfg
pacman -Sy archlinux-keyring archlinuxarm-keyring archlinux32-keyring parabola-keyring
pacman -Syu
echo "do you want to install sudo or doas [sudo/doas]"
read elevation
if [[ $elevation = sudo ]] ; then
	pacman -S sudo
	echo "what will be your username" 
        read username
	echo "$username ALL=(ALL) ALL"
fi
if [[ $elevation = doas ]] ; then 
        echo "The right choice was chosen"
	echo "what will be your username" 
        read username
	pacman -S doas
	touch /etc/doas.conf
        echo "permit $username as root" >> /etc/doas.conf
fi
echo "Enter Username again please: "
read username
useradd -m $username
passwd $username
echo "Pre-Installation Finish Reboot now"
ai3_path=/home/$username/arch_install3.sh
sed '1,/^#part3$/d' arch_install2.sh > $ai3_path
chown $username:$username $ai3_path
chmod +x $ai3_path
su -c $ai3_path -s /bin/sh $username
exit 


#part3
printf '\033c'
cd $HOME
mkdir .config
cd .config/
echo "sorry to ask again [sudo/doas]"
read sorry
$sorry pacman -S base-devel git xorg-xinit noto-fonts noto-fonts-emoji \
	ffmpeg imagemagick fzf man-db papirus-icon-theme \
	pipewire pipewire-pulse vim arc-gtk-theme rsync \
	jq rxvt-unicode dhcpcd rsync picom xorg-xrdb xorg-xinit
git clone https://github.com/RealBlissIO/Dotfiles
git clone https://git.suckless.org/dmenu
cp -r Dotfiles/dwm/ .
cp -r Dotfiles/slstatus/ .
cp Dotfiles/urxvt .
cd $HOME
cp .config/Dotfiles/.xinitrc .
cp .config/Dotfiles/.Xresources .
cp .config/Dotfiles/.bashrc .
cd .config/dwm/
$sorry make clean install
cd ..
cd slstatus/
$sorry make clean install
cd ..
cd dmenu/
$sorry make clean install
rm -Rf .config/Dotfiles
echo "done-----exiting..."
exit
