#sudo apt-get install libncurses-dev flex bison openssl libssl-dev dkms libelf-dev libudev-dev libpci-dev libiberty-dev autoconf gcc make -y
#make menuconfig
make -j8
make bzImage && make modules
sudo make INSTALL_MOD_STRIP=1 modules_install && sudo make install
sudo update-grub "Ubuntu, with Linux 5.10.0-rc3+"
#sudo reboot
