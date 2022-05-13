#!/bin/bash

mkdir -p "/home/$(whoami)/Documents"
mkdir -p "/home/$(whoami)/Downloads"

aur_install() {
  curl -O "https://aur.archlinux.org/cgit/aur.git/snapshot/$1.tar.gz" \
    && tar -xvf "$1.tar.gz" \
    && cd "$1" \
    && makepkg --noconfirm -si \
    && cd - \
    && rm -rf "$1" "$1.tar.gz" ;
}

aur_check() {
  QM=$(pacman -Qm | awk '{print $1}')

  for ARG in "$@"
  do
    if [[ "$QM" != *"$ARG"* ]]; then
      yay --noconfirm -S "$ARG" &>> /tmp/aur_install \
        || aur_install "$ARG" &>> /tmp/aur_install
    fi
  done
}

cd /tmp
dialog --infobox "Installing 'Yay', an AUR helper..." 10 60
aur_check yay
COUNT=$(wc -l < /tmp/aur_queue)
C=0

cat /tmp/aur_queue | while read -r LINE
do
  C=$(( "$C" + 1 ))
  dialog --infobox \
    "AUR install - Downloading and installing program $C out of $COUNT:
      $LINE..." \
  10 60
  aur_check "$LINE"
done
