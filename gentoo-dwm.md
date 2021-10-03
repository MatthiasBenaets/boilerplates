# Gentoo - DWM - Setup

### Installation Gentoo
<details>
<summary>**Start Up**</summary>
On boot:
```
gentoo
2 = azerty
```
</details>
<details>
<summary>**Prepare Disks**</summary>
```
lsblk (find disk name, for example sda)
fdisk /dev/sda
o 
n - p - 1 - enter - +256M
n - p - 2 - enter - enter
a - 1
w

mkfs.ext2 /dev/sda1
mkfs.ext4 /dev/sda2
mount /dev/sda2 /mnt/gentoo
```
</details>
<details>
<summary>**Install Stage3**</summary>
```
cd /mnt/gentoo
links gentoo.org/downloads
select Stage 3 openrc - save
tar xpvf stage3-*.tar.xz --xattrs-include='*.*' --numeric-owner

nano -w  /mnt/gentoo/etc/portage/make.conf
	>COMMON_FLAGS="-O2 -pipe -march=native" OR for HP "-march=skylake -O2 -pipe"
below FFLAGS:
	>MAKEOPTS="-j[cores]" [cores]=amount
	>ACCEPT_LICENSE="*"
	>VIDEO_CARDS="intel/nvidia/radeon/amdgpu/vesa"
	>USE="-aqua -gnome -ios -ipod -kde -systemd -wayland -xfce alsa X"
```
</details>
<details>
<summary>**Install Base System**</summary>
```
mirrorselect -i -o >> /mnt/gentoo/etc/portage/make.conf
select [country] mirrors

mkdir --parents /mnt/gentoo/etc/portage/repos.conf
cp /mnt/gentoo/usr/share/portage/config/repos.conf /mnt/gentoo/etc/portage/repos.conf/gentoo.conf

cp --dereference /etc/resolv.conf /mnt/gentoo/etc/

mount --types proc /proc /mnt/gentoo/proc
mount --rbind /sys /mnt/gentoo/sys
mount --make-rslave /mnt/gentoo/sys
mount --rbind /dev /mnt/gentoo/dev
mount --make-rslave /mnt/gentoo/dev

chroot /mnt/gentoo /bin/bash
. /etc/profile
export PS1="(chroot) ${PS1}"
mount /dev/sda1 /boot

emerge-webrsync

eselect profile list
select amd64 stable -> eselect profile set [number]

emerge --ask --verbose --update --deep --newuse @world

echo "Europe/Brussels" > /etc/timezone
emerge --config sys-libs/timezone-data

nano -w /etc/locale.gen
	>nl_BE ISO-8859-1
	>nl_BE.UTF-8 UTF-8
	>en_US ISO-8859-1
	>en_US.UTF-8 UTF-8
	>C.UTF8 UTF-8
```
<details>
<summary>**Optional**</summary>
```
nano -w /etc/env.d/02locale
	>LANG=en_US.UTF-8
	>LC_CTYPE=en_US.UTF-8
	>LC_NUMERIC=nl_BE.UTF-8
	>LC_TIME=nl_BE.UTF-8
	>LC_COLLATE=nl_BE.UTF-8
	>LC_MONETARY=nl_BE.UTF-8
	>LC_MESSAGES=en_US.UTF-8
	>LC_PAPER=nl_BE.UTF-8
	>LC_NAME=nl_BE.UTF-8
	>LC_ADDRESS=nl_BE.UTF-8
	>LC_TELEPHONE=nl_BE.UTF-8
	>LC_MEASUREMENT=nl_BE.UTF-8
	>LC_IDENTIFICATION=nl_BE.UTF-8
```
</details>
```
locale-gen

eselect locale list
select locale en_BE.utf8 -> eselect locale set [number]
. /etc/profile
export PS1="(chroot) ${PS1}"
```
</details>
<details>
<summary>**Configure Kernel (Genkernel)**</summary>
```
emerge --ask sys-kernel/gentoo-sources
eselect kernel list 
eselect kernel set [number]
ls -l /usr/src/linux

Optional: emerge --ask sys-apps/pciutils
emerge --ask sys-kernel/genkernel
if error:
	echo "sys-kernel/linux-firmware @BINARY-REDISTRIBUTABLE" | tee -a /etc/portage//package.license

genkernel all

emerge --ask sys-kernel/linux-firmware
```
</details>
<details>
<summary>**Configure System**</summary>
```
nano -w /etc/fstab
	>/dev/sda1	/boot		ext2	defaults,noatime	0 2
	>/dev/sda2	/			ext4	noatime				0 1
	>/dev/cdrom	/mnt/cdrom	auto	noauto,ro			0 0

nano -w /etc/conf.d/hostname
	>hostname="gentoo"

emerge --ask --noreplace net-misc/netifrc


nano -w /etc/conf.d/keymaps
	>keymap="azerty"
nano -w /etc/conf.d/hwclock
	>clock="UTC+2"
ip a (check ethernet name, for example eth0)
nano -w /etc/conf.d/net
	>config_eth0="dhcp"
cd /etc/init.d
ln -s net.lo net.eth0
rc-update add net.eth0 default

nano -w /etc/hosts
	>127.0.0.1	[hostname] localhost
	>::1		[hostname] localhost

passwd
	[password]
```    
</details>
<details>
<summary>**Installing Tools**</summary>
```
emerge --ask app-admin/sysklogd
rc-update add sysklogd default
Optional install cron deamon (see handbook)

emerge --ask sys-fs/e2fsprogs
emerge --ask net-misc/dhcpcd
```
<details>
<summary>**Optional wifi**</summary>
```
emerge --ask net-wireless/iw net-wireless/wpa_supplicant
```
</details>
</details>
<details>
<summary>**Configure Bootloader**</summary>
```
emerge --ask --verbose sys-boot/grub:2
grub-install /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg

exit
cd
umount -l /mnt/gentoo/dev{/shm,/pts,}
umount -R /mnt/gentoo
reboot
```
</details>
<details>
<summary>**Finalizing**</summary>
```
root
[password]

useradd -m -G users,wheel,audio,video,cdrom,usb -s /bin/bash matthias
passwd [username]
	[password]

emerge app-admin/sudo
nano -w /etc/sudoers
	>%wheel ALL = (ALL)ALL   OR ADD "[username] ALL=(ALL) ALL" bellow root

rm /stage3-*.tar.*

su [username]
```
</details>
<details>
<summary>**Setup Wifi**</summary>
```
ip a "find name of networkcard, for example wlo1"

emerge net-wirless/wpa_supplicant

nano /etc/network/interfaces:
	>auto wlo1
	>allow-hotplug wlo1
	>iface wlo1 inet dhcp
	>wpa-conf /etc/wpa_supplicant/wpa_supplicant.conf
	>iface default inet dhcp

nano /etc/wpa_supplicant/wpa_supplicant.conf:
	>ctrl_interface=/run/wpa_supplicant
	>update_control=1
	>network{
	>ssid="name"
	>psk="pass"
	>proto=RSN
	>key_mgmt=WPA-PSK
	>pairwise=CCMP
	>auth_alg=OPEN
	>}
```
</details>

---

### Installation Display Server / Window Manager / Terminal

<details>
<summary>**Xorg**</summary>
```
nano -w /etc/portage/make.conf
below USEFLAGS:
	>INPUT_DEVICES="libinput synaptics"
	>VIDEO_CARDS="(nvideo=nouveau;amd=radeon/amdgpu;intel=intel;virtualbox=virtio)"

emerge -av x11-base/xorg-server x11-base/xorg-drivers
nano -w /etc/portage/make.conf
	>USE=" ... elogind X"
```
<details>
<summary>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Optional Xterm**</summary>
```
emerge -av x11-terms/xterm

env-update
source /etc/profile
```
</details>
</details>
<details>
<summary>**Window Manager**</summary>
```
emerge -av x11-wm/dwm x11-terms/st x11-misc/dmenu x11-apps/setxkbmap (x11-apps/xrandr [for VB])
startx /usr/bin/dwm
rc-update add elogind boot
If error:
	dispatch-conf
```
</details>
<details>
<summary>**Edit Startup Files**</summary>
```
su [username]
cd
nano -w .xinitrc
	>#!/bin/sh
	>setxkbmap be
	(>xrandr --output Virtual-1 --mode 1280x960)
	>exec dwm
nano -w /etc/profile
	>startx

sudo reboot
[username]
[my.password]
startx
```
</details>

---

### Patching Suckless dwm/st/dm
<details>
<summary>**Patching suckless and edit config**</summary>
```
nano /etc/portage/package.use/dwm
	>x11-wm/dwm savedconfig (or add global use-flag)
cd /etc/portage/savedconfig/x11-wm/

ln -a dwm-* dwm-*.h
nano dwm-*.h
	>edit
	>check .diff and add(+) or remove(-)

mv /home/[user]/Downloads/random-0.0.1.diff /etc/portage/patches/x11-wm/dwm/01-random_0.0.1.diff

emerge dwm
alt+shift+q
startx
```
</details>

---

### Wiki Notes
<details>
<summary>**Use Flags**</summary>
For example: neofetch needs imlib
<details>
<summary>General</summary>
```
nano /etc/portage/make.conf
	 >USE="imlib"
```
</details>
<details>
<summary>Specific</summary>
```
nano /etc/portage/package.use/neofetch
	>www-client/w3m-* imlib
```
</details>
</details>
<details>
<summary>**Install, Uninstall, Update Packages**</summary>
<details>
<summary>Install</summary>
```
emerge --ask [package]
```
</details>
<details>
<summary>Uninstall</summary>
-Remove without checking dependencies:
```
emerge --unmurge --ask [package]
```
-Remove but check dependcencies first:
```
emerge --ask --verbose --depclean [package]
```
-Remove unused dependencies:
```
emerge --ask --depclean
. /etc/profile
```
-Remove from world favorites and afterwards delete with dependencies only used by package **Recommended**
```
emerge --ask --deselect [package] (removed from world favorites)
emerge --ask --depclean
```
-Add back to world favorites
```
emerge --ask --noreplace [package]
```
</details>
<details>
<summary>Update</summary>
-Update
```
emerge --sync
```
-Upgrade
```
emerge -avDuN @world --> upgrades all packages from /var/lib/portage/world
```
-Getting IMPORTANT messages when emerging
```
cd [PathThatIsGiven]
ls -a > check ._cfg0000* file and replace/delete if needed
etc-update -> should not have any messages anymore
```
</details>
<details>
<summary>Check Dependencies</summary>
```
emerge gentoolkit
equery d [package/dependency] -> get list of packages that depend on it
```
</details>
<details>
<summary>Check Vulnerable packages</summary>
```
glsa-check -t all
if found: glsa-check -f all
```
</details>
<details>
<summary>Clean Up System</summary>
```
emerge gentoolkit
eclean-dist -dp
eclean-dist -d
```
</details>
<details>
<summary>**DO BIWEEKLY**</summary>
emerge --sync
glsa-check -t all
eclean-dist -d
etc-update
</details>
</details>