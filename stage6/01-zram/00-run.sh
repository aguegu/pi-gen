#!/bin/bash -e

install -m 755 files/systemd-swap_4.0.1_any.deb "${ROOTFS_DIR}/tmp/"

on_chroot << EOF
apt-get purge -y dc dphys-swapfile
dpkg -i /tmp/systemd-swap_4.0.1_any.deb
systemctl enable systemd-swap
rm /tmp/systemd-swap_4.0.1_any.deb
EOF
