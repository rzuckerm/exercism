#!/bin/bash
if [ ! -d build ]
then
    mkdir build
    cd build
    cmake -DEXERCISM_RUN_ALL_TESTS=1 -DEXERCISM_INCLUDE_BENCHMARK=1 -G "Unix Makefiles" ..
    cd -
fi

make -C build
