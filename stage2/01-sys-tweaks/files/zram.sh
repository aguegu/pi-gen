#!/bin/bash

# swapsize = totalmem * factor
factor=50

cores=$(nproc --all)
modprobe zram num_devices=$cores

totalmem=`free | grep -e "^Mem:" | awk '{print $2}'`
mem=$(( ($totalmem / $cores * $factor) * 1024 / 100 ))

core=0
while [ $core -lt $cores ]; do
	echo lz4 >/sys/devices/virtual/block/zram$core/comp_algorithm
	echo $mem > /sys/block/zram$core/disksize
	mkswap /dev/zram$core
	swapon -p 5 /dev/zram$core
	let core=core+1
done
