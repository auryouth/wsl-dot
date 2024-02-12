<!--toc:start-->

- [Before Install](#before-install)
- [Arch Install](#arch-install)
  - [Install wsl2](#install-wsl2)
  - [Prepare the Image](#prepare-the-image)
  - [Import the Image](#import-the-image)
  - [Configuring Arch in WSL2](#configuring-arch-in-wsl2)
    - [1. Launch the installation:](#1-launch-the-installation)
    - [2. Initialize the keyring required to run pacman:](#2-initialize-the-keyring-required-to-run-pacman)
    - [3. Fill the new keyring with Arch's latest set of keys:](#3-fill-the-new-keyring-with-archs-latest-set-of-keys)
    - [4. Pacman's mirrorlist is already installed but entirelly commented out. Add one.](#4-pacmans-mirrorlist-is-already-installed-but-entirelly-commented-out-add-one)
    - [5. Update the repos and install the latest packages:](#5-update-the-repos-and-install-the-latest-packages)
    - [6. There will also be a handful of missing "base" packages that are always useful to have and can be installed with:](#6-there-will-also-be-a-handful-of-missing-base-packages-that-are-always-useful-to-have-and-can-be-installed-with)
    - [7. Set Locale](#7-set-locale)
    - [8. Add non-root User](#8-add-non-root-user)
    - [9. Open multilib](#9-open-multilib)
    - [10. Add archlinuxcn Server](#10-add-archlinuxcn-server)
- [Fast Recovery](#fast-recovery)
  - [Install](#install)
  <!--toc:end-->

# Before Install

> **Warning**  
> This is my own `wsl` dotfile. So make sure you have at least skimmed throuth the files to check.

# Arch Install

## Install wsl2

If you have a Arch system, then you may not want to install

```pwsh
wsl --install --no-distribution
```

## Prepare the Image

In an existing linux install (another WSL distro, VM, or native), download the `archlinux-bootstrap-x86_64.tar.gz` bootstrap image from an [arch mirror](https://archlinux.org/download/) closest to you.

**_AS ROOT_** via sudo or a root user, run the following commands:

1. Extract the downloaded image: `bsdtar -xpvf archlinux-bootstrap-x86_64.tar.gz`
2. Compress the contents of inside the directory: `bsdtar -cpvf archlinux-bootstrap.tar -C root.x86_64 .`

The reason this must be done as root is to preserve file ownership of bootstrap filesystem when it is imported into WSL. If this is not done, you will likely experience permissions issues when interacting with imported the operating system.

Once the new archive is created, move the file to the machine somewhere Arch will be installed on.

## Import the Image

On the machine Arch will be installed on:

1. Create a directory where the Arch virtual disk file will live, for example C:\Users\\{USER}\wsl
2. Import the archive into WSL, replacing the first path with the directory created in the previous, step and the second path with the path to the created archive from the previous section: `wsl --import Arch C:\Users\{USER}\wsl C:\path\to\archlinux-bootstrap.tar`

## Configuring Arch in WSL2

Arch can now be launched on the machine it was installed on. Some additional configuration will be needed to make this a fully functional arch install:

### 1. Launch the installation:

```bash
wsl -d Arch
```

### 2. Initialize the keyring required to run pacman:

```bash
pacman-key --init
```

### 3. Fill the new keyring with Arch's latest set of keys:

```bash
pacman-key --populate archlinux
```

### 4. Pacman's mirrorlist is already installed but entirelly commented out. Add one.

```bash
echo 'Server = https://mirror.osbeck.com/archlinux/$repo/os/$arch' > /etc/pacman.d/mirrorlist
```

### 5. Update the repos and install the latest packages:

```bash
pacman -Syu
```

### 6. There will also be a handful of missing "base" packages that are always useful to have and can be installed with:

```bash
pacman -S base base-devel
```

### 7. Set Locale

```bash
nvim /etc/locale.gen
# uncomment en_US.UTF-8 and zh_CN.UTF-8
locale-gen
echo 'LANG=en_US.UTF-8'  > /etc/locale.conf
```

### 8. Add non-root User

```bash
useradd -m -G wheel -s /bin/bash wx
passwd wx
EDITOR=nvim visudo
# uncomment the line #%wheel ALL=(ALL:ALL) ALL
```

### 9. Open multilib

```bash
# uncomment [multilib] section
```

### 10. Add archlinuxcn Server

```bash
# /etc/pacman.conf
[archlinuxcn]
Server = https://repo.archlinuxcn.org/$arch

sudo pacman -Syu
sudo pacman -S archlinuxcn-keyring
```

If there is an error when installing archlinuxcn-keyring: `error: archlinuxcn-keyring: signature from "Jiachen YANG (Arch Linux Packager Signing Key) <farseerfc@archlinux.org>" is marginal trust`

```bash
sudo pacman-key --lsign farseerfc@archlinux.org
```

Then try again.

# Fast Recovery

There is a script at [pkglist/scripts/install.sh](https://github.com/auryouth/wsl-dot/blob/master/pkglist/scripts/install.sh) which can help you complete almost everything.

> **Note**  
> Before running the script, make sure you have **`Good Network`**.

## Install

At lease download the `pkglist` directory somewhere.

```bash
$ cd pkglist/scripts
$ ./install.sh
```

**Restart to enjoy your arch wsl journey!**
