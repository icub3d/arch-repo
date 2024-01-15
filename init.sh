#!/usr/bin/env bash

echo -e "[multilib]\nInclude = /etc/pacman.d/mirrorlist" >> /etc/pacman.conf
pacman --noconfirm -Syu base base-devel git fish 
echo "%wheel ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/wheel
chmod 0600 /etc/sudoers.d/wheel
useradd -m -G wheel -s /usr/bin/fish jmarsh
git clone https://github.com/icub3d/arch-repo
chown -R jmarsh:jmarsh /arch-repo
cd /arch-repo
su -P -c build-repo.fish jmarsh
