Couple personal notes:

To get hardware encoding working, pass through the gpu to the vm.
Inside the vm (in my case debian), install the correct nvidia drivers.

You might need to update all packages or version. (now 535)
sudo apt install linux-headers-$(uname -r) build-essential dksm
sudo apt install nvidia-driver firmware-misc-nonfree
`nvidia-smi` and `vainfo` should work and show what is possible, but you might need to `modprobe nvidia`. but it should already be handled in the initramfs using the `/etc/modprobe.d/nvidia.conf`
Not sure if the above is needed.

For the compose file:
for nvidia:
add the environmental variable in the docker compose file
`NVIDIA_VISIBLE_DEVICES=all`
and add:
`runtime: nvidia`
for other situations, consult https://docs.linuxserver.io/images/docker-jellyfin/#intel

for the above to work, the nvidia-container-toolkit is required: https://github.com/NVIDIA/nvidia-container-toolkit?tab=readme-ov-file
install guide here: https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html
add repo, set up nvidia-ctk for docker and restart the service
reboot just to be sure.

Start the container and in settings - administration - dashboard - playback - transcoding, pick nvidia and choose your preferences
