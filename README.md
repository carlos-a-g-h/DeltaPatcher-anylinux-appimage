# DeltaPatcher Anylinux AppImage 🐧

## Build status

[![GitHub Downloads](https://img.shields.io/github/downloads/carlos-a-g-h/DeltaPatcher-anylinux-appimage/total?logo=github&label=GitHub%20Downloads)](https://github.com/carlos-a-g-h/DeltaPatcher-anylinux-appimage/releases/latest)

[![CI Build Status](https://github.com//carlos-a-g-h/DeltaPatcher-anylinux-appimage/actions/workflows/appimage.yml/badge.svg)](https://github.com/carlos-a-g-h/DeltaPatcher-anylinux-appimage/releases/latest)

* [Latest Stable Release](https://github.com/carlos-a-g-h/DeltaPatcher-anylinux-appimage/releases/latest)

## About this AppImage

This is an unofficial AppImage for [Delta Patcher](https://github.com/marco-calautti/DeltaPatcher)

The developer behind the Delta Patcher provides a Linux release as a zipped binary, Delta Patcher is also available as a Flatpak, but the developer does not provide any appimages, so I made one myself

<details>
  <summary><b><i>IT RUNS FINE</i></b></summary>
    <img width="1920" height="1080" alt="DeltaPatcher_tests" src="https://github.com/carlos-a-g-h/DeltaPatcher-anylinux-appimage/blob/main/DeltaPatcher_running_on_Debian11-libc6-2.31.png?raw=true" />
    <strong><i>System: Debian 11, libc6 2.31</i></strong>
</details>

The AppImage built and distributed by this repo is made using the zipped binary that is provided by the official repository

This is not a traditional AppImage, this AppImage is built to run on any distro, including older distros, more details about this at the end of this README file

### Internal scripts and programs

This AppImage has internal scripts that can be launched by calling them as commandline arguments

```
./DeltaPatcher.AppImage [program]
```

This AppImage has internal scripts and programs that can be launched by calling them as commandline arguments

|Program or script|Description|
| setup | An "installation" script for the appimage. It provides a nice config, a DESKTOP file in /usr/share/applications and an icon |
| details | Extracts the "details" directory from the AppImage |

### About the setup script

This script can help you integrate the appimage to your system

```
./DeltaPatcher.AppImage setup [FLAGS]
```

| Flag | Description |
|-|-|
| --install | Performs the installation, integrating the appimage to your system |
| --no-links | Will not create symlinks that go from /usr/bin/ to the AppImage |
| --no-desktop | Will not create the application desktop file and its icon |
| --force | Overwrites in case that there are files or paths that already exist |

Use the command without any arguments for more details

## What is AnyLinux ?

These AppImages are made using [sharun](https://github.com/VHSgunzo/sharun), which makes it extremely easy to turn any binary into a portable package without using containers or similar tricks.

**These AppImages bundle everything and should work on any linux distro, even on musl based ones.**

These AppImages can work **without FUSE** at all thanks to the [uruntime](https://github.com/VHSgunzo/uruntime)

More at: [AnyLinux-AppImages](https://pkgforge-dev.github.io/Anylinux-AppImages/)

<details>
  <summary><b><i>raison d'être</i></b></summary>
    <img src="https://github.com/user-attachments/assets/d40067a6-37d2-4784-927c-2c7f7cc6104b" alt="Inspiration Image">
</details>
