#!/bin/bash

NAME=$(cat /tmp/user_name)

APPS_PATH="/tmp/apps.csv"
curl https://raw.githubusercontent.com/rahnoff/arch_config/main/installer/apps.csv > $APPS_PATH

dialog --title "Welcome" \
  --msgbox "Welcome to the installation script for apps and dotfiles" \
  10 60

APPS=("essential" "Essentials" on
     "network" "Network" on
     "tools" "Nice tools to have" on
     "git" "Git & git tools" on
     "i3" "i3 wm" on
     "neovim" "Neovim" on
     "urxvt" "URxvt" on
     "firefox" "Firefox" on)

dialog --checklist \
  "You can now choose what group of application you want to install \n\n
  You can select an option with SPACE and confirm your choices with ENTER" \
  0 0 0 \
  "${APPS[@]}" 2> app_choices

CHOICES=$(cat app_choices) && rm app_choices

SELECTION="^$(echo $CHOICES | sed -e 's/ /,|^/g'),"
LINES=$(grep -E "$SELECTION" "$APPS_PATH")
COUNT=$(echo "$LINES" | wc -l)
PACKAGES=$(echo "$LINES" | awk -F, {'print $2'})

echo "$SELECTION" "$LINES" "$COUNT" >> "/tmp/packages"

pacman -Syu --noconfirm

rm -f /tmp/aur_queue

dialog --title "Let's go" --msgbox \
  "The system will now install everything you need\n\n
  It will take some time\n\n" \
  13 60

C=0
echo "$PACKAGES" | while read -r LINE; do
    C=$(( "$C" + 1 ))

    dialog --title "Arch Linux installation" --infobox \
      "Downloading and installing program $C out of $COUNT: $LINE..." \
      8 70

    ((pacman --noconfirm --needed -S "$LINE" > /tmp/arch_install 2>&1) \
    || echo "$LINE" >> /tmp/aur_queue) \
    || echo "$LINE" >> /tmp/arch_install_failed

    if [ "$LINE" = "networkmanager" ]; then
      systemctl enable NetworkManager.service
    fi
done

echo "%wheel ALL=(ALL) ALL" >> /etc/sudoers

curl https://raw.githubusercontent.com/rahnoff/arch_config/main/installer/install_user.sh > /tmp/install_user.sh

# Switch user and run this script
sudo -u "$NAME" sh /tmp/install_user.sh
