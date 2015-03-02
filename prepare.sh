#!/bin/bash 

path=$(cd "$(dirname "$0")"; pwd)

cd openssl
./config
sed -i.bak s+^CC=.*+"CC= $(pwd)/mygcc"+g Makefile
make
cd ..

exit
