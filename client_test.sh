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
mkdir -p ./c/c149; tftp -4 -v -m binary -R 151:151 127.0.0.1 149 -c get aaaaaaaa.a ./c/c149/aaaaaaaa.a &
mkdir -p ./c/c159; tftp -4 -v -m binary -R 161:161 127.0.0.1 159 -c get aaaaaaaa.a ./c/c159/aaaaaaaa.a &
mkdir -p ./c/c169; tftp -4 -v -m binary -R 171:171 127.0.0.1 169 -c get aaaaaaaa.a ./c/c169/aaaaaaaa.a &
mkdir -p ./c/c179; tftp -4 -v -m binary -R 181:181 127.0.0.1 179 -c get aaaaaaaa.a ./c/c179/aaaaaaaa.a &
mkdir -p ./c/c189; tftp -4 -v -m binary -R 191:191 127.0.0.1 189 -c get aaaaaaaa.a ./c/c189/aaaaaaaa.a &
mkdir -p ./c/c199; tftp -4 -v -m binary -R 201:201 127.0.0.1 199 -c get aaaaaaaa.a ./c/c199/aaaaaaaa.a &
mkdir -p ./c/c209; tftp -4 -v -m binary -R 211:211 127.0.0.1 209 -c get aaaaaaaa.a ./c/c209/aaaaaaaa.a &
mkdir -p ./c/c219; tftp -4 -v -m binary -R 221:221 127.0.0.1 219 -c get aaaaaaaa.a ./c/c219/aaaaaaaa.a &


set -x


