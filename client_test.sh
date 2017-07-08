#!/bin/bash
set +x


rm -rf ./c/
mkdir -p  ./c/c69; tftp -4 -v -m binary -R  71:71  127.0.0.1  69 -c get aaaaaaaa.a  ./c/c69/aaaaaaaa.a &
mkdir -p  ./c/c79; tftp -4 -v -m binary -R  81:81  127.0.0.1  79 -c get aaaaaaaa.a  ./c/c79/aaaaaaaa.a &
mkdir -p  ./c/c89; tftp -4 -v -m binary -R  91:91  127.0.0.1  89 -c get aaaaaaaa.a  ./c/c89/aaaaaaaa.a &
mkdir -p  ./c/c99; tftp -4 -v -m binary -R 101:101 127.0.0.1  99 -c get aaaaaaaa.a  ./c/c99/aaaaaaaa.a &
mkdir -p ./c/c109; tftp -4 -v -m binary -R 111:111 127.0.0.1 109 -c get aaaaaaaa.a ./c/c109/aaaaaaaa.a &
mkdir -p ./c/c119; tftp -4 -v -m binary -R 121:121 127.0.0.1 119 -c get aaaaaaaa.a ./c/c119/aaaaaaaa.a &
mkdir -p ./c/c129; tftp -4 -v -m binary -R 131:131 127.0.0.1 129 -c get aaaaaaaa.a ./c/c129/aaaaaaaa.a &
mkdir -p ./c/c139; tftp -4 -v -m binary -R 141:141 127.0.0.1 139 -c get aaaaaaaa.a ./c/c139/aaaaaaaa.a &


set -x


