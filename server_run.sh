#!/bin/bash
set -x

# E.G. with csum calc: server_run.sh eth0 +c
# E.G. without csum calc: server_run.sh eth0 -c

dev=$1
csum_offload=$2

if [ "${csum_offload}" == "+c" ]
then
    ethtool --offload "${dev}" rx off tx off
else
    ethtool --offload "${dev}" rx on tx on
fi

cd ..
tftp_cs/src/server "${csum_offload}"  69  70 &
tftp_cs/src/server "${csum_offload}"  79  80 &
tftp_cs/src/server "${csum_offload}"  89  90 &
tftp_cs/src/server "${csum_offload}"  99 100 &
tftp_cs/src/server "${csum_offload}" 109 110 &
tftp_cs/src/server "${csum_offload}" 119 120 &
tftp_cs/src/server "${csum_offload}" 129 130 &

set +x

