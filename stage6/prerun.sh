#!/bin/bash -e

PREV_ROOTFS_DIR="${WORK_DIR}"/stage2/rootfs

if [ ! -d "${ROOTFS_DIR}" ]; then
	copy_previous
fi
