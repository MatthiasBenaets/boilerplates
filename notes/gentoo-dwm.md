# Gentoo - DWM - Setup

### Installation Gentoo
<details>
<summary>Start Up</summary>
On boot:
<pre>
gentoo
2 = azerty
</pre>
</details>
<details>
<summary>Prepare Disks</summary>
<pre>
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
</pre>
</details>
<details>
<summary>Install Stage3</summary>
<pre>
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
</pre>
</details>
<details>
<summary>Install Base System</summary>
<pre>
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
</pre>
<details>
<summary>Optional</summary>
<pre>
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
</pre>
</details>
<pre>
locale-gen

eselect locale list
select locale en_BE.utf8 -> eselect locale set [number]
. /etc/profile
export PS1="(chroot) ${PS1}"
</pre>
</details>
<details>
<summary>Configure Kernel (Genkernel)</summary>
<pre>
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
</pre>
</details>
<details>
<summary>Configure System</summary>
<pre>
nano -w /etc/fstab
	>/dev/sda1	/boot		ext2	defaults,noatime	0 2
	>/dev/sda2	/		ext4	noatime			0 1
	/*>/dev/cdrom	/mnt/cdrom	auto	noauto,ro		0 0*/

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
	My_hard_password
</pre>
</details>
<details>
<summary>Installing Tools</summary>
<pre>
emerge --ask app-admin/sysklogd
rc-update add sysklogd default
Optional install cron deamon (see handbook)

emerge --ask sys-fs/e2fsprogs
emerge --ask net-misc/dhcpcd
</pre>
<details>
<summary>Optional Wifi</summary>
<pre>
emerge --ask net-wireless/iw net-wireless/wpa_supplicant
</pre>
</details>
</details>
<details>
<summary>Configure Bootloader</summary>
<pre>
emerge --ask --verbose sys-boot/grub:2
grub-install /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg

exit
cd
umount -l /mnt/gentoo/dev{/shm,/pts,}
umount -R /mnt/gentoo
reboot
</pre>
</details>
<details>
<summary>Finalizing</summary>
<pre>
root
My_hard_password

useradd -m -G users,wheel,audio,video,cdrom,usb -s /bin/bash matthias
passwd matthias
	My_hard_password

emerge app-admin/sudo
nano -w /etc/sudoers
	>%wheel ALL = (ALL)ALL   OR ADD "matthias ALL=(ALL) ALL" bellow root

rm /stage3-*.tar.*

su matthias
</pre>
</details>
<details>
<summary>Setup Wifi</summary>
<pre>
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
</pre>
</details>

---

### Install Display Server / Window Manager / Terminal

<details>
<summary>Xorg</summary>
<pre>
nano -w /etc/portage/make.conf
below USEFLAGS:
	>INPUT_DEVICES="libinput synaptics"
	>VIDEO_CARDS="(nvideo=nouveau;amd=radeon/amdgpu;intel=intel;virtualbox=virtio)"

emerge -av x11-base/xorg-server x11-base/xorg-drivers
nano -w /etc/portage/make.conf
	>USE=" ... elogind X"

Optional xterm:
emerge -av x11-terms/xterm

env-update
source /etc/profile
</pre>
</details>
<details>
<summary>Window Manager</summary>
<pre>
emerge -av x11-wm/dwm x11-terms/st x11-misc/dmenu x11-apps/setxkbmap (x11-apps/xrandr [for VB])
startx /usr/bin/dwm
rc-update add elogind boot
If error:
	dispatch-conf
</pre>
</details>
<details>
<summary>Edit Startup Files</summary>
<pre>
su matthias
cd
nano -w .xinitrc
	>#!/bin/sh
	>setxkbmap be
	(>xrandr --output Virtual-1 --mode 1280x960)
	>exec dwm
nano -w /etc/profile
	>startx

sudo reboot
matthias
My_hard_password
startx
</pre>
</details>

---

### Patching Suckless dwm/st/dm
<details>
<summary>Patching Suckless and edit config</summary>
<pre>
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
</pre>
</details>

---

### Wiki Notes
<details>
<summary>Use Flags</summary>
For example: neofetch needs use-flag imlib
<details>
<summary>General</summary>
<pre>
neofetch: imlib (=use flag)
nano /etc/portage/make.conf
	 >USE="imlib"
</pre>
</details>
<details>
<summary>Specific</summary>
<pre>
nano /etc/portage/package.use/neofetch
	>www-client/w3m-* imlib
</pre>
</details>
</details>
<details>
<summary>Install, Uninstall, Update Packages</summary>
<details>
<summary>Install</summary>
<pre>
emerge --ask [package]
</pre>
</details>
<details>
<summary>Uninstall</summary>
-Remove without checking dependencies:
<pre>
emerge --unmurge --ask [package]
</pre>
-Remove but check dependcencies first:
<pre>
emerge --ask --verbose --depclean [package]
</pre>
-Remove unused dependencies:
<pre>
emerge --ask --depclean
. /etc/profile
</pre>
-Remove from world favorites and afterwards delete with dependencies only used by package **Recommended**
<pre>
emerge --ask --deselect [package] (removed from world favorites)
emerge --ask --depclean
</pre>
-Add back to world favorites
<pre>
emerge --ask --noreplace [package]
</pre>
</details>
<details>
<summary>Update</summary>
-Update
<pre>
emerge --sync
</pre>
-Upgrade
<pre>
emerge -avDuN @world --> upgrades all packages from /var/lib/portage/world
</pre>
-Getting IMPORTANT messages after emerging
<pre>
cd [PathThatIsGiven]
ls -a > check ._cfg0000* file and replace/delete if needed
etc-update -> should not have any messages anymore
</pre>
</details>
<details>
<summary>Check Dependencies</summary>
<pre>
emerge gentoolkit
equery d [package/dependency] -> get list of packages that depend on it
</pre>
</details>
<details>
<summary>Check Vulnerable Packages</summary>
<pre>
glsa-check -t all
if found: glsa-check -f all
</pre>
</details>
<details>
<summary>Clean Up System</summary>
<pre>
emerge gentoolkit
eclean-dist -dp
eclean-dist -d
</pre>
</details>
<details>
<summary>DO BIWEEKLY</summary>
<pre>
emerge --sync
glsa-check -t all
eclean-dist -d
etc-update
</pre>
</details>
</details>
