#!/bin/bash
set -x

ethtool --offload eth0 rx off tx off
cd ..
tftp_cs/src/server +c 69 70

set +x

