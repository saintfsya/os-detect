[![Build Status](https://img.shields.io/travis/AntiPhotonltd/os-detect/master.svg)](https://travis-ci.org/AntiPhotonltd/os-detect)
[![Software License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE.md)
[![Release](https://img.shields.io/github/release/AntiPhotonltd/os-detect.svg)](https://github.com/AntiPhotonltd/os-detect/releases/latest)
[![Github commits (since latest release)](https://img.shields.io/github/commits-since/AntiPhotonltd/os-detect/latest.svg)](https://github.com/AntiPhotonltd/os-detect/commits)
[![GitHub repo size in bytes](https://img.shields.io/github/repo-size/AntiPhotonltd/os-detect.svg)](https://github.com/AntiPhotonltd/os-detect)
[![GitHub contributors](https://img.shields.io/github/contributors/AntiPhotonltd/os-detect.svg)](https://github.com/AntiPhotonltd/os-detect)

OS Detect
=========

This is a simple-ish script for working out what OS you are running on as some scripts need to be OS aware.

# Table of Contents
1. [Functions](#functions)
2. [Environment Variables](#environment-variables)
3. [Usage](#usage)
4. [Example Output](#example-output)
5. [Todo List](#todo-list)
6. [Caveats](#caveats)

<a name="functions"></a>
## Functions

The following functions exist:
	
* detect_os
* detect_kernel
* detect_architecture
* detect_distribution
* detect_name
* detect_version
* detect_release
* detect_codename
* detect_basedon
* full_os_detect

<a name="environment-variables"></a>
## Environment Variables

The following environment variables are set:

* OSD_OS
* OSD_DISTRIBUTION
* OSD_NAME
* OSD_CODENAME
* OSD_RELEASE
* OSD_VERSION
* OSD_BASEDON
* OSD_KERNEL
* OSD_ARCH

<a name="usage"></a>
## Usage

### Simple Usage

```
source os-detect.sh

full_os_detect

echo "OS: $OSD_OS"
echo "DISTRIBUTION: $OSD_DISTRIBUTION"
echo "NAME: $OSD_NAME"
echo "CODENAME: $OSD_CODENAME"
echo "RELEASE: $OSD_RELEASE"
echo "VERSION: $OSD_VERSION"
echo "BASEDON: $OSD_BASEDON"
echo "KERNEL: $OSD_KERNEL"
echo "ARCH: $OSD_ARCH"
```

### Custom usage

```
source os-detect.sh

detect_distribution
detect_version

echo "DISTRIBUTION: $OSD_DISTRIBUTION"
echo "VERSION: $OSD_VERSION"
```

<a name="example-output"></a>
## Examples of usage by OS

### Debian
```
OS: Linux
DISTRIBUTION: debian
NAME: Debian GNU/Linux
CODENAME: stretch
RELEASE: 9.2
VERSION: 9
BASEDON: debian
KERNEL: 4.9.49-moby
ARCH: x86_64
```

### Ubuntu
```
OS: Linux
DISTRIBUTION: ubuntu
NAME: Ubuntu
CODENAME: Xenial Xerus
RELEASE: 16.04
VERSION: 16.04
BASEDON: debian
KERNEL: 4.9.49-moby
ARCH: x86_64
```

### Mac OS X
```
OS: Mac OS
DISTRIBUTION: unknown
NAME: Mac OS X
CODENAME: unknown
RELEASE: 10.13.1
VERSION: unknown
BASEDON: unknown
KERNEL: 17.2.0
ARCH: x86_64
```

### Centos
```
OS: Linux
DISTRIBUTION: centos
NAME: CentOS Linux
CODENAME: Core
RELEASE: 7.4.1708
VERSION: 7
BASEDON: rhel fedora
KERNEL: 4.9.49-moby
ARCH: x86_64
```

### Suse
```
OS: Linux
DISTRIBUTION: opensuse
NAME: openSUSE Leap
CODENAME: Malachite
RELEASE: 42.3
VERSION: 42.3
BASEDON: suse
KERNEL: 4.9.49-moby
ARCH: x86_64
```

### Amazon Linux
```
OS: Linux
DISTRIBUTION: amzn
NAME: Amazon Linux AMI
CODENAME: unknown
RELEASE: 2017.09
VERSION: 2017.09
BASEDON: rhel fedora
KERNEL: 4.9.49-moby
ARCH: x86_64
```

<a name="todo-list"></a>
## ToDo List

1. Test it on more variants

<a name="caveats"></a>
## Caveats

Each variable that is created is set to read only just before the subroutine exits, this means that each detection function can only be called once, otherwise it will throw an error. The full_os_detect wrapper calls **all** of the detection subroutines.
