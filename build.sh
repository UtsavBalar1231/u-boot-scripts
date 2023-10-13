#!/usr/bin/env bash
# shellcheck disable=SC1090,SC1091
#
# SPDX-License-Identifier: MIT
# Copyright (C) 2023 Vicharak Computers LLP
# Version: 1.0

# Set bash shell options
set -eE

# Set locale to C to avoid issues with some build scripts
export LC_ALL=C

# Command used for this script
CMD=$(realpath "${0}")
# uboot directory path
SCRIPT_DIR=$(dirname "${CMD}")
export SCRIPT_DIR

echo "script called from ${SCRIPT_DIR}"

if [ ! -d "${SCRIPT_DIR}" ]; then
	echo "${SCRIPT_DIR} does not exist"
	exit 1
fi

source "${SCRIPT_DIR}"/variables
source "${SCRIPT_DIR}"/utils
source "${SCRIPT_DIR}"/functions
if [ -f "${SCRIPT_DIR}"/.device.mk ]; then
	source "${SCRIPT_DIR}"/.device.mk
fi

# Usage function to provide help on script options
function usage() {
	print "─────────────────────────────────────────────────────────────────────"
	print "          Vicharak U-Boot Build Script - Usage Guide"
	print "─────────────────────────────────────────────────────────────────────"
	print " Usage: ${0} [OPTIONS]"
	print ""
	print " Available Options:"
	print "  lunch            | -l    : Prepare the environment for the chosen device"
	print "  info             | -i    : Display current u-boot setup details"
	print "  clean            | -c    : Remove u-boot build artifacts"
	print "  build            | -b    : Compile the u-boot for the chosen device"
	print "  ubootdeb         | -B    : Generate a Debian package for the u-boot"
	print "  update_defconfig | -u    : Update the u-boot configuration with the latest changes"
	print "  help             | -h    : Display this usage guide"
	print "─────────────────────────────────────────────────────────────────────"
}

if [ "$1" == "-h" ] || [ "$1" == "help" ]; then
	if [ -n "${2}" ] && [ "$(type -t usage"${2}")" == function ]; then
		print "----------------------------------------------------------------"
		print "--- ${2} Build Command ---"
		print "----------------------------------------------------------------"
		eval usage "${2}"
	else
		usage
	fi
	exit 0
fi

OPTIONS=("${@:-build}")
for option in "${OPTIONS[@]}"; do
	print "Processing option: $option"
	case ${option} in
	*.mk)
		if [ -f "${option}" ]; then
			selected_config_file=${option}
		else
			selected_config_file=$(find "${CFG_DIR}" -name "${option}")
			print "Switching to board: ${selected_config_file}"
			if [ ! -f "${selected_config_file}" ]; then
				exit_with_error "Invalid board: ${option}"
			fi
		fi
		DEVICE_MAKEFILE="${selected_config_file}"
		export DEVICE_MAKEFILE

		ln -f "${DEVICE_MAKEFILE}" "${SCRIPT_DIR}"/.device.mk
		source "${SCRIPT_DIR}"/.device.mk

		print_info
		;;
	lunch | -l) lunch_device ;;
	info | -i) print_info ;;
	clean | -c) cleanup ;;
	build | -b)
		check_lunch_device
		build_uboot
		;;
	ubootdeb | -B) build_ubootdeb ;;
	update_defconfig | -u) update_defconfig ;;
	*)
		usage
		exit_with_error "Invalid option: ${option}"
		;;
	esac
done
