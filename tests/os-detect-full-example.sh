#!/usr/bin/env bash

# -------------------------------------------------------------------------------- #
# Description                                                                      #
# -------------------------------------------------------------------------------- #
# This is a very simple (almost trivial) example of how to make use of the         #
# os-detect script and embed os detection into your scripts.                       #
# -------------------------------------------------------------------------------- #

# -------------------------------------------------------------------------------- #
# Use the source                                                                   #
# -------------------------------------------------------------------------------- #
# Source the os-detect script to make the variables available.                     #
# -------------------------------------------------------------------------------- #

# shellcheck disable=SC1091
source ../src/os-detect.sh

# -------------------------------------------------------------------------------- #
# Example usage                                                                    #
# -------------------------------------------------------------------------------- #
# This is an example showing how to use the variables in your own script.          #
# -------------------------------------------------------------------------------- #

# -------------------------------------------------------------------------------- #
# Full detection                                                                   #
# -------------------------------------------------------------------------------- #
# Call the full_os_detect function to do a full detection, you can also call the   #
# individual detection functions directly.                                         #
#                                                                                  #
# detect_os                                                                        #
# detect_kernel                                                                    #
# detect_architecture                                                              #
# detect_distribution                                                              #
# detect_name                                                                      #
# detect_version                                                                   #
# detect_release                                                                   #
# detect_codename                                                                  #
# detect_basedon                                                                   #
# -------------------------------------------------------------------------------- #

full_os_detect

# -------------------------------------------------------------------------------- #
# Display Results                                                                  #
# -------------------------------------------------------------------------------- #
# Display the resultant variables. If you call specific detection functions        #
# directly instead of the full detection then not all variables will exist.        #
# -------------------------------------------------------------------------------- #

echo "OS: $OSD_OS"
echo "DISTRIBUTION: $OSD_DISTRIBUTION"
echo "NAME: $OSD_NAME"
echo "CODENAME: $OSD_CODENAME"
echo "RELEASE: $OSD_RELEASE"
echo "VERSION: $OSD_VERSION"
echo "BASEDON: $OSD_BASEDON"
echo "KERNEL: $OSD_KERNEL"
echo "ARCH: $OSD_ARCH"

# -------------------------------------------------------------------------------- #
# End of Script                                                                    #
# -------------------------------------------------------------------------------- #
# This is the end - nothing more to see here.                                      #
# -------------------------------------------------------------------------------- #

