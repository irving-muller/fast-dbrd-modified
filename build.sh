#!/usr/bin/env bash

rm -rf build
mkdir build
cd build
#cmake -DCMAKE_BUILD_TYPE:STRING=Debug .. 
cmake -DCMAKE_BUILD_TYPE:STRING=Release .. 

make VERBOSE=1 -j 4
