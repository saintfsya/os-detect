#!/usr/bin/env bash

# -------------------------------------------------------------------------------- #
# Description                                                                      #
# -------------------------------------------------------------------------------- #
# This is a simple script which attempts to detection which operating system your  #
# script is running on. This should allow you to write complex scripts which have  #
# OS detection and OS specific syntax.                                             #
# -------------------------------------------------------------------------------- #

# -------------------------------------------------------------------------------- #
# Clean String                                                                     #
# -------------------------------------------------------------------------------- #
# Clean the presented string and remove unwanted characters. [Order IS important!] #
# -------------------------------------------------------------------------------- #

clean_string()
{
    clean="$1"

    clean="${clean##*( )}"                          # Remove leading spaces
    clean="${clean%%*( )}"                          # Remove trailing spaces
    clean="${clean#\"*}"                            # Remove leading string quotes
    clean="${clean%\"*}"                            # Remove trailing string quotes
    clean="${clean##*( )}"                          # Remove leading spaces
    clean="${clean%%*( )}"                          # Remove trailing spaces

    echo "${clean}"
}

# -------------------------------------------------------------------------------- #
# Operating System                                                                 #
# -------------------------------------------------------------------------------- #
# Attempt to detect the operating system.                                          #
# -------------------------------------------------------------------------------- #

detect_os()
{
    OSD_OS=$(uname)
    OSD_OS=$(clean_string "${OSD_OS}")

    if [[ "${OSD_OS}" == "Darwin" ]]; then
        OSD_OS='Mac OS'
    fi
    readonly OSD_OS
}

# -------------------------------------------------------------------------------- #
# Kernal Version                                                                   #
# -------------------------------------------------------------------------------- #
# Attempt to detect to kernel release version.                                     #
# -------------------------------------------------------------------------------- #

detect_kernel()
{
    OSD_KERNEL=$(uname -r)
    OSD_KERNEL=$(clean_string "${OSD_KERNEL}")
    readonly OSD_KERNEL
}

# -------------------------------------------------------------------------------- #
# Architecture                                                                     #
# -------------------------------------------------------------------------------- #
# Attempt to detect the machine architecture.                                      #
# -------------------------------------------------------------------------------- #

detect_architecture()
{
    OSD_ARCH=$(uname -m)
    OSD_ARCH=$(clean_string "${OSD_ARCH}")
    readonly OSD_ARCH
}

# -------------------------------------------------------------------------------- #
# Distribution                                                                     #
# -------------------------------------------------------------------------------- #
#  Attempt to detect the distribution name.                                        #
# -------------------------------------------------------------------------------- #

detect_distribution()
{
    if type "lsb_release" > /dev/null 2>&1; then
        OSD_DISTRIBUTION=$(lsb_release -a | grep 'Distributor ID' | awk -F:  '{ print $2 }')
    else
        if [[ -f /etc/redhat-release ]]; then
            OSD_DISTRIBUTION=$(sed s/\ release.*// < /etc/redhat-release)
        fi

        if [[ -f /etc/os-release ]]; then
            OSD_DISTRIBUTION=$(grep '^ID' /etc/os-release | grep -v '^ID_LIKE' | awk -F=  '{ print $2 }')
        fi
    fi
    if [[ -z "${OSD_DISTRIBUTION}" ]]; then
        OSD_DISTRIBUTION="unknown"
    fi
    OSD_DISTRIBUTION=$(clean_string "${OSD_DISTRIBUTION}")
    readonly OSD_DISTRIBUTION
}

# -------------------------------------------------------------------------------- #
# OS Name                                                                          #
# -------------------------------------------------------------------------------- #
# Attempt to detect the OS name.                                                   #
# -------------------------------------------------------------------------------- #

detect_name()
{
    if [[ "${OSD_OS}" == "Mac OS" ]]; then
        OSD_NAME=$(sw_vers -productName)
    elif [[ -f /etc/os-release ]]; then
        OSD_NAME=$(grep '^NAME' /etc/os-release | awk -F=  '{ print $2 }')
    fi

    if [[ -z "${OSD_NAME}" ]]; then
        OSD_NAME="unknown"
    fi
    OSD_NAME=$(clean_string "${OSD_NAME}")
    readonly OSD_NAME
}

# -------------------------------------------------------------------------------- #
# Version                                                                          #
# -------------------------------------------------------------------------------- #
# Attempt to detect the operating system version.                                  #
# -------------------------------------------------------------------------------- #

detect_version()
{
    if [[ -f /etc/os-release ]]; then
        OSD_VERSION=$(grep '^VERSION_ID' /etc/os-release | awk -F=  '{ print $2 }')
    fi

    if [[ -z "${OSD_VERSION}" ]]; then
        OSD_VERSION="unknown"
    fi
    OSD_VERSION=$(clean_string "${OSD_VERSION}")
    readonly OSD_VERSION
}

# -------------------------------------------------------------------------------- #
# Release                                                                          #
# -------------------------------------------------------------------------------- #
# Attempt to detect the release version.                                           #
# -------------------------------------------------------------------------------- #

detect_release()
{
    if [[ "${OSD_OS}" == "Mac OS" ]]; then
        OSD_RELEASE=$(sw_vers -productVersion)
    else
        if type "lsb_release" > /dev/null 2>&1; then
            OSD_RELEASE=$(lsb_release -a | grep 'Release' | awk -F:  '{ print $2 }')
        else
            if [[ -f /etc/debian_version ]]; then
                OSD_RELEASE=$(cat /etc/debian_version)
                if [[ -f /etc/os-release ]]; then
                    TMP_DISTRIBUTION=$(grep '^ID' /etc/os-release | grep -v '^ID_LIKE' | awk -F=  '{ print $2 }')
                    if [[ "${TMP_DISTRIBUTION}" = "ubuntu" ]]; then
                        OSD_RELEASE=$(grep '^VERSION_ID' /etc/os-release | awk -F=  '{ print $2 }')
                    fi
                fi
            elif [[ -f /etc/redhat-release ]]; then
                OSD_RELEASE=$(sed s/.*release\ // /etc/redhat-release | sed s/\ .*//)
            elif [[ -f /etc/SuSE-release ]]; then
                OSD_RELEASE=$(grep '^VERSION' /etc/SuSE-release | awk -F=  '{ print $2 }')
            elif [[ -f /etc/os-release ]]; then
                OSD_RELEASE=$(grep '^VERSION' /etc/os-release | grep -v 'VERSION_ID' | awk -F=  '{ print $2 }')
            fi
        fi
    fi
    if [[ -z "${OSD_RELEASE}" ]]; then
        OSD_RELEASE="unknown"
    fi
    OSD_RELEASE=$(clean_string "${OSD_RELEASE}")
    readonly OSD_RELEASE
}

# -------------------------------------------------------------------------------- #
# Codename                                                                         #
# -------------------------------------------------------------------------------- #
# Attempt to detect to operating system codename                                   #
# -------------------------------------------------------------------------------- #

detect_codename()
{
    if type "lsb_release" > /dev/null 2>&1; then
        OSD_CODENAME=$(lsb_release -a | grep 'Codename' | awk -F:  '{ print $2 }')
    else
        if [[ -f /etc/debian_version ]]; then
            if [[ -f /etc/os-release ]]; then
                OSD_CODENAME=$(awk -F"[)(]+" '/VERSION=/ {print $2}' /etc/os-release)
            fi
        elif [[ -f /etc/redhat-release ]]; then
            OSD_CODENAME=$(sed s/.*\(// /etc/redhat-release | sed s/\)//)
        elif [[ -f /etc/SuSE-release ]]; then
            OSD_CODENAME=$(grep '^CODENAME' /etc/SuSE-release | awk -F=  '{ print $2 }')
        fi
    fi

    if [[ -z "${OSD_CODENAME}" ]]; then
        OSD_CODENAME="unknown"
    fi
    OSD_CODENAME=$(clean_string "${OSD_CODENAME}")
    readonly OSD_CODENAME
}

# -------------------------------------------------------------------------------- #
# Based On                                                                         #
# -------------------------------------------------------------------------------- #
# Attempt to detect which operating system this operating system is based on.      #
# -------------------------------------------------------------------------------- #

detect_basedon()
{
    if [[ -f /etc/os-release ]]; then
        OSD_BASEDON=$(grep '^ID_LIKE' /etc/os-release | awk -F=  '{ print $2 }')
    fi

    if [[ -f /etc/debian_version ]] && [[ -z "${OSD_BASEDON}" ]]; then
        OSD_BASEDON="debian"
    elif [[ -f /etc/redhat-release ]] &&  [[ -z "${OSD_BASEDON}" ]]; then
        OSD_BASEDON="redhat"
    elif [[ -f /etc/SuSE-release ]] && [[ -z "${OSD_BASEDON}" ]]; then
        OSD_BASEDON="suse"
    fi

    if [[ -z "${OSD_BASEDON}" ]]; then
        OSD_BASEDON="unknown"
    fi
    OSD_BASEDON=$(clean_string "${OSD_BASEDON}")
    readonly OSD_BASEDON
}

# -------------------------------------------------------------------------------- #
# Full Detection                                                                   #
# -------------------------------------------------------------------------------- #
# A simple wrapper to run ALL of the detection funtions.                           #
# -------------------------------------------------------------------------------- #

full_os_detect()
{
    detect_os
    detect_kernel
    detect_architecture
    detect_distribution
    detect_name
    detect_version
    detect_release
    detect_codename
    detect_basedon
}

# -------------------------------------------------------------------------------- #
# End of Script                                                                    #
# -------------------------------------------------------------------------------- #
# This is the end - nothing more to see here.                                      #
# -------------------------------------------------------------------------------- #
