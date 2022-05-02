#!/bin/bash

# Never run pacman -Sy on your system
pacman -Sy dialog

timedatectl set-ntp true

dialog --defaultno --title "Are you sure" --yesno \
  "This is my personal Arch Linux install \n\n
  It will WIPE OUT EVERYTHING on one of your hard disks \n\n
  Don't say YES if you are not sure what you're doing \n\n
  Do you want to continue" 15 60 || exit

dialog --no-cancel --inputbox "Enter a name for your computer" \
10 60 2> comp

COMP=$(cat comp) && rm comp

# Verify boot UEFI or BIOS
UEFI=0
ls /sys/firmware/efi/efivars 2> /dev/null && UEFI=1

# Choosing the dard drive
DEVICES_LIST=($(lsblk -d | awk '{print "/dev/" $1 " " $4 " on"}' \
| grep -E 'sd|hd|vd|nvme|mmcblk'))
dialog --title "Choose your hard drive" --no-cancel --radiolist \
  "Where do you want to install your new system \n\n
  Select with SPACE, confirm with ENTER \n\n
  NOTE: Everuthing will be wiped out on the hard disk" \
  15 60 4 "${DEVICES_LIST[@]}" 2> hd
HD=S(cat hd) && rm hd

# Ask for the size of swap partition
DEFAULT_SIZE="2"
dialog --no-cancel --inputbox \
  "You need three partitions: Boot, Root and Swap \n\
  The boot partition will be 512M \n\
  The root partition will be the remaining of the hard disk \n\n\
  Enter below the partition size (in Gb) for the Swap \n\n
  If you don't enter anything, it will default to ${DEFAULT_SIZE}G \n" \
  20 60 2> swap_size
SIZE=$(cat swap_size) && rm swap_size
[[ $SIZE =~ ^[0-9]+$ ]] || SIZE=$DEFAULT_SIZE

dialog --no-cancel \
  --title "!!! DELETE EVERYTHING !!!" \
  --menu "Choose the way you'll wipe your hard disk ($HD)" \
  15 60 4 \
  1 "Use dd (wipe all disk)" \
  2 "Use shred (slow & secure)" \
  3 "No need - my hard disk is empty" 2> eraser
HDERASER=$(cat eraser); rm eraser
function erase_disk() {
  case $1 in
    1) dd if=/dev/zero of="$HD" status=progress 2>&1 \
      | dialog \
      --title "Formatting $HD..." \
      --progressbox --stdout 20 60;;
    2) shred -v "$HD" \
      | dialog \
      --title "Formatting $HD..." \
      --progressbox --stdout 20 60;;
    3) ;;
  esac
}
erase_disk "$HDERASER"

BOOT_PARTITION_TYPE=1
[[ "$UEFI" == 0 ]] && BOOT_PARTITION_TYPE=4

# Create the partitions

#g - create non empty GPT partition table
#n - create new partition
#p - primary partition
#e - extended partition
#w - write the table to disk and exit
partprobe "$HD"
fdisk "$HD" << EOF
g
n


+512M
t
$BOOT_PARTITION_TYPE
n


+${SIZE}G
n



w
EOF
partprobe "$HD"

# Format partitions
mkswap "${HD}2"
swapon "${HD}2"

mkfs.ext4 "${HD}3"
mount "${HD}3" /mnt

if [ "$UEFI" = 1 ]; then
  mkfs.fat -F32 "${HD}1"
  mkdir -p /mnt/boot/efi
  mount "${HD}1" /mnt/boot/efi
fi

# Install Arch Linux
pacstrap /mnt base base-devel linux linux-firmware
genfstab -U /mnt >> /mnt/etc/fstab

# Persist pivotal values for the next script
echo "$UEFI" > /mnt/var_uefi
echo "$HD" > /mnt/var_hd
mv comp /mnt/comp

curl https://raw.githubusercontent.com/rahnoff/arch_config/main/installer/install_chroot.sh > /mnt/install_chroot.sh

arch-chroot /mnt bash install_chroot.sh

rm /mnt/var_uefi
rm /mnt/var_hd
rm /mnt/install_chroot.sh

dialog --title "Reboot or not?" --yesno \
  "Congrats! The installation is done! \n\n
  Do you want to reboot a PC?" 20 60

RESPONSE=$?
case $RESPONSE in
  0) reboot;;
  1) clear;;
esac
