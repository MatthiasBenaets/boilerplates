# Debian - DWM - Setup
### Installation Debian
<details>
<summary>Initial Install</summary>
lang=en <br>
loc=belgium <br>
key=belgian <br>
hostname=debian <br>
install with ethernet enp0s25 <br>
usb with correct iwlwifi .deb package: <br>
- HP: [iwlwifi-7260-17.ucode](www.packages.debian.org/search?keywords=firmware-iwlwifi) <br>

software=ONLY standard system utilities (+web/print/ssh server) <br>
</details>
<details>
<summary>Install Needed Packages</summary>
<pre>
su
apt update
apt upgrade
apt install sudo xorg make git

nano /etc/sodoers
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
</pre>
</details>

---

### Installation Window Manager, Terminal, Menu
<details>
<summary>Install Window Manager, Terminal, Menu</summary>
<pre>
mkdir .suckless
cd into folder
git clone https://www.github.com/[github.username]/dwm
git clone https://www.github.com/[github.username]/st
git clone https://git.suckless.org/dmenu

make clean install x3
</pre>
</details>
<details>
<summary>Dependencies suckless</summary>
<pre>
apt install gcc libx11-dev libxft-dev libxinerama-dev
</pre>
</details>
<details>
<summary>Startup Edits</summary>
<pre>
if using clean suckless download:
	nano /home/matthias/dwm/config.h:
      { .v = (onst char$[]{ "/usr/local/bin/st", "-e", cmd, NULL} }
nano /etc/profile:
	>startx
nano /home/matthias/.xinitrc:
	>xrandr --output Virtual1 --mode 1280x960
	>exec dwm
</pre>
</details>

---

### Enable Computer Features
<details>
<summary>Audio</summary>
<pre>
apt install alsa-utils pulseaudio pavucontrol
pulseaudio --check
pulseaudio -D
alsamixer -> press M for unmute
pavucontrol
</pre>
</details>
<details>
<summary>Bluetooth</summary>
<pre>
apt install bluez blueman
</pre>
<details>
<summary>auto switch</summary>
<pre>
nano /etc/pulse/default.pa
	>.ifexists module-bluetooth-discover.so
	>load-module module-bluetooth-discover
	>load-module module-switch-on-connect
	>.endif
nano /etc/bluetooth/audio.conf
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
cd /etc/X11/xorg.conf.d
nano -w 70-synaptics.conf
	>Section "InputClass"
	>Identifier "touchpad"
	>Driver "synaptics"
	>MatchIsTouchpad "on"
	>Option "Tapping" "on"
	>Option "NaturalScrolling" "on"
	>EndSection
</pre>
</details>
<details>
<summary>Error managing</summary>
AMD:
<pre>
nano /etc/apt/sources.list:
	>add "non-free" to all sources
apt-get update
apt install firmware-amd-graphics
nano /etc/modprobe.d/radeon.conf
	>blacklist radeon
nano /etc/modprobe.d/amdgpu.conf
	>options amdgpu si_support=1
	>options amdgpu cik_support=1
</pre>
Wifi:
<pre>
nano /etc/modprobe.d/iwlwifi.conf
	>options iwlwifi enbale_ini=N
</pre>
</details>
<details>
<summary>Wallpaper</summary>
<pre>
apt install xwallpaper compton
nano .xinitrc (always before >exec dwm)
	>xwallpaper --center /home/matthias/[PATHTOIMG]
	>compton -f &
</pre>
</details>
<details>
<summary>Extras</summary>
error no pkg?<br> 
pkgs.org (for example libjpeg8 - get amd64.deb - sudo dpkg -i [NAME.deb])
<details>
<summary>qDslrDashboard</summary>
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
