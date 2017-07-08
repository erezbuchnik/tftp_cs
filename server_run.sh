#!/bin/bash
set -x

# E.G. with csum calc: server_run.sh eth0 +c
# E.G. without csum calc: server_run.sh eth0 -c

dev=$1
csum_offload=$2    

server_name="tftp_srvr"
cd ./src
make
cd ../

if [ "${csum_offload}" == "+c" ]
then
    ethtool -K "${dev}" rx off tx off
    ethtool -K "${dev}" gso off
else
    ethtool -K "${dev}" rx on tx on
    ethtool -K "${dev}" gso on
fi

killall ${server_name}
sleep 1
./src/${server_name} ${csum_offload}  69  70 &
./src/${server_name} ${csum_offload}  79  80 &
./src/${server_name} ${csum_offload}  89  90 &
./src/${server_name} ${csum_offload}  99 100 &
./src/${server_name} ${csum_offload} 109 110 &
./src/${server_name} ${csum_offload} 119 120 &
./src/${server_name} ${csum_offload} 129 130 &
./src/${server_name} ${csum_offload} 139 140 &
./src/${server_name} ${csum_offload} 149 150 &
./src/${server_name} ${csum_offload} 159 160 &
./src/${server_name} ${csum_offload} 169 170 &
./src/${server_name} ${csum_offload} 179 180 &
./src/${server_name} ${csum_offload} 189 190 &
./src/${server_name} ${csum_offload} 199 200 &
./src/${server_name} ${csum_offload} 209 210 &
./src/${server_name} ${csum_offload} 219 220 &


set +x

