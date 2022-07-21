# Apt - Pacman - Xbps - DWM - Setup
### Installation
<details>
<summary>Initial Install Debian</summary>
lang=en <br>
loc=belgium <br>
key=belgian <br>
hostname=debian <br>
install with ethernet enp0s25 <br>
usb with correct iwlwifi .deb package: <br>
- HP: <a href="www.packages.debian.org/search?keywords=firmware-iwlwifi">iwlwifi-7260-17.ucode</a><br>

software=ONLY standard system utilities (+web/print/ssh server) <br>
</details>
<details>
<summary>Install Needed Packages</summary>
<pre>
su
apt update &&apt upgrade
pacman -Syu
xbps-install -Suy

apt install sudo xorg make git
pacman -S xorg make git
xbps-install xorg make git

nano /etc/sudoers
	>ROOT ...
	>[username] ALL=(ALL:ALL) ALL
su [username]
</pre>
</details>
<details>
<summary>Wifi</summary>
<pre>
ip a "find name of networkcard, for example wlo1"

nano /etc/network/interfaces:
	>auto wlo1
	>allow-hotplug wlo1
	>iface wlo1 inet dhcp
	>wpa-conf /etc/wpa_supplicant/wpa_supplicant.conf
	>iface default inet dhcp

nano /etc/wpa_supplicant/wpa_supplicant.conf:
	>network={
	>ssid="name"
	>psk="pass"
	>proto=RSN
	>key_mgmt=WPA-PSK
	>pairwise=CCMP
	>auth_alg=OPEN
	>}

reboot

OR

apt-get install network-manager
pacman -S networkmanager
systemctl enable NetworkManager.service
xbps-install NetworkManager
sv down dhcpcd
sudo rm /var/service/dhcpcd
sudo ln -s /etc/sv/NetworkManager /var/service
</pre>
</details>

---

### Installation Window Manager, Terminal, Menu
<details>
<summary>Install Window Manager, Terminal, Menu</summary>
<pre>
git clone https://www.github.com/[github.username]/dwm .dwm
git clone https://www.github.com/[github.username]/st .st
git clone https://www.github.com/[github.username]/dmenu .dmenu
git clone https://www.github.com/[github.username]/dwmblocks .dwmblocks

make clean install x4
git clone https://www.github.com/[github.username]/dotfiles .dotfiles
cp -r .dotfiles/. $HOME 
</pre>
</details>
<details>
<summary>Dependencies</summary>
<pre>
apt install gcc libx11-dev libxft-dev libxinerama-dev (libx11-xcb-dev libxcb-res0-dev fonts-font-awesome sxhkd feh compton python3-pip)
pip3 install ueberzug

pacman -s gcc libx11 libxft libxinerama (libxcb xorg-setxkbmap xorg-xrandr xorg-xsetroot ttf-font-awesome sxhkd  feh xcompmgr ueberzug)

xbps-install pkg-config libX11-devel libXft-devel libXinerama-devel (setxkbmap setxkbmap sxetroot font-awesome sxhkd feh compton ranger ueberzug)
</pre>
</details>
<details>
<summary>Startup Edits</summary>
<pre>
if using clean suckless download:
	nano /home/matthias/dwm/config.h:
      { .v = (const char$[]{ "/usr/local/bin/st", "-e", cmd, NULL} }
vim /etc/profile:
	>startx
vim /home/matthias/.xinitrc:
	>xrandr --output Virtual1 --mode 1280x960
	>exec dwm
</pre>
</details>

---

### Enable Computer Features
<details>
<summary>Audio</summary>
<pre>
apt install alsa-utils pulseaudio pulsemixer
pacman -S alsa-utils pulseaudio pulsemixer
xbps-install alsa-utils pulseaudio pulsemixer

pulseaudio --check
pulseaudio -D
alsamixer -> press M for unmute -> select correct sound card
</pre>
</details>
<details>
<summary>Bluetooth</summary>
<pre>
apt install bluez blueman pulseaudio-module-bluetooth
pacman -S bluez bluez-utils blueman pulseaudio-bluetooth
systemctl enable bluetooth.service
xbps-install bluez blueman bluez-alsa
sudo ln -s /etc/sv/bluetoothd /var/service/
sudo ln -s /etc/sv/dbus /var/service/

</pre>
<details>
<summary>auto switch</summary>
<pre>
vim /etc/pulse/default.pa
	>.ifexists module-bluetooth-discover.so
	>load-module module-bluetooth-discover
	>load-module module-switch-on-connect
	>.endif
vim /etc/bluetooth/audio.conf
	>[General]
	>Disable=Headset

pulseaudio -k
reboot
</pre>
</details>
<br>
dmenu: <br>
blueman-applets <br>
blueman-manager
</details>
<details>
<summary>Webcam and Microphone</summary>
Should work out of the box
</details>
<details>
<summary>Synaptics Trackpad</summary>
<pre>
apt-get install libinput-bin
pacman -S libinput
xbps-install libinput

cd /etc/X11/xorg.conf.d
nano -w 30-tocuhpad.conf
	>Section "InputClass"
	>Identifier "devname"
	>Driver "libinput"
	>Option "Tapping" "on"
	>Option "NaturalScrolling" "true"
	>EndSection
</pre>
</details>
<details>
<summary>Power Management Laptop</summary>
<pre>
apt-get install tlp
pacman -S tlp
systemctl enable tlp.service
xbps-install tlpln -s /etc/sv/tlp /var/service
</pre>
</details>
<details>
<summary>Error managing Debian</summary>
AMD:
<pre>
vim /etc/apt/sources.list:
	>add "non-free" to all sources
apt-get update
apt install firmware-amd-graphics
vim /etc/modprobe.d/radeon.conf
	>blacklist radeon
vim /etc/modprobe.d/amdgpu.conf
	>options amdgpu si_support=1
	>options amdgpu cik_support=1
</pre>
Wifi:
<pre>
vim /etc/modprobe.d/iwlwifi.conf
	>options iwlwifi enbale_ini=N
</pre>
</details>
<details>
<summary>Compositor & Image Viewer</summary>
<pre>
apt install feh compton
pacman -S feh xcompmgr
xbps-install feh compton

vim .xinitrc (always before >exec dwm)
	>feh --bg-center $HOME/[PATHTOIMG]
	>compton -f & / xcompmgr -f &
</pre>
</details>
<details>
<summary>File Manager</summary>
<pre>
apt install ranger
pacman -S ranger
xbps-install ranger
</pre>
</details>

---

### Customization

<details>
<summary>Patching and Dotfiles</summary>
<details>
<summary>Suckless Patching</summary>
Save patches from Suckless website and move to correct directory.
<pre>
sudo patch < [patch.name]
Best practice: manually change the config.def.h files
rm config.h
sudo make clean install
reboot
</pre>
</details>
<details>
<summary>Dotfiles</summary>
<pre>
cp -r $HOME/.dotfiles .
</details>
<details>
<summary>Ranger preview</summary>
<pre>
vim .config/ranger/rc.conf
	>set preview_images true
	>set preview_images_method ueberzug
	>set draw_borders true
</pre>
</details>
</details>
<details>
<summary>Extras Debian</summary>
error no pkg?<br> 
pkgs.org (for example libjpeg8 - get amd64.deb - sudo dpkg -i [NAME.deb])
<details>
<summary>for example qDslrDashboard</summary>
download Linux x64<br>
pkgs.org= libjpeg8 && libjpeg-turbo8
<pre>
apt install libqt5x11extras5

tar xzvf [NAME]
cd in dir
./qDslrDashboard.sh
</pre>
</details>
</details>
