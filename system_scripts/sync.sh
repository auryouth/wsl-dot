# curl -s "https://archlinux.org/mirrorlist/?country=SE&country=DE&protocol=https&use_mirror_status=on" | sed -e 's/^#Server/Server/' -e '/^#/d' | rankmirrors -n 3 - > /etc/pacman.d/mirrorlist
curl -s "https://archlinux.org/mirrorlist/?country=SE&protocol=https&use_mirror_status=on" | sed -e 's/^#Server/Server/' -e '/^#/d' | rankmirrors -n 3 - > /etc/pacman.d/mirrorlist
