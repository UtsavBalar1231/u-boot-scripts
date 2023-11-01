# shellcheck shell=bash
# SPDX-License-Identifier: MIT
# Copyright (C) 2023 Vicharak Computers LLP

# Makefile for rk3399-vaaman-mainline
# This file contains variables used for building rk3399-vaaman u-boot
# To disable build options, comment the line or set it to false

# Device specific
DEVICE_NAME="rk3399-vaaman-mainline"
DEVICE_DTB_FILE="rk3399-vaaman"
DEVICE_DEFCONFIG="rk3399-vaaman_defconfig"
DEVICE_ARCH="arm64"

# Build options

# Build debian package
DEB_BUILD=false
# Build Mainline U-boot
MAINLINE_BUILD=true
