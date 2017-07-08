#!/bin/bash
set -x

# E.G. with csum calc: server_run.sh eth0 +c
# E.G. without csum calc: server_run.sh eth0 -c

dev=$1
csum_offload=$2

if [[ $1 =
ethtool --offload "${dev}" rx off tx off
cd ..
tftp_cs/src/server "${csum_offload}"  69  70 &
tftp_cs/src/server "${csum_offload}"  79  80 &
tftp_cs/src/server "${csum_offload}"  89  90 &
tftp_cs/src/server "${csum_offload}"  99 100 &
tftp_cs/src/server "${csum_offload}" 109 110 &
tftp_cs/src/server "${csum_offload}" 119 120 &
tftp_cs/src/server "${csum_offload}" 129 130 &

set +x

