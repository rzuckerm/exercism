#!/bin/bash
if [ ! -d build ]
then
    mkdir build
    cd build
    cmake -D EXERCISM_TEST_SUITE=1 -G "Unix Makefiles" "$@" ..
    cd -
fi

if [ -d test ]
then
    rm -rf test
fi

make -C build
