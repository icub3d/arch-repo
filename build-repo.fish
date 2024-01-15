#!/usr/bin/env fish

# install paru
git clone https://aur.archlinux.org/paru.git
pushd paru
makepkg -sri --noconfirm
popd

# Get PKGBUILDs
for package in (cat package-list)
  git clone https://aur.archlinux.org/$package.git
  pushd $package
  paru -yB --noconfirm .
  popd
end

# Create the repo or clean it up.
sudo mkdir -p /files/archlinux/marshians
sudo rm -rf /files/archlinux/marshians/*

# Copy packages to repo including those from paru cache
sudo cp (find .  -name "*.zst") /files/archlinux/marshians
sudo cp (find /home/jmarsh.cache/paru/clone -name "*.zst") /files/archlinux/marshians

# Create the repo
pushd /files/archlinux/marshians
sudo repo-add marshians.db.tar.gz *.zst
