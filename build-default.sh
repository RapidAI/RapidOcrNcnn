#!/usr/bin/env bash

sysOS=$(uname -s)
NUM_THREADS=1
if [ $sysOS == "Darwin" ]; then
  #echo "I'm MacOS"
  NUM_THREADS=$(sysctl -n hw.ncpu)
elif [ $sysOS == "Linux" ]; then
  #echo "I'm Linux"
  NUM_THREADS=$(grep ^processor /proc/cpuinfo | wc -l)
else
  echo "Other OS: $sysOS"
fi

mkdir -p ${sysOS}-exe-cpu
pushd ${sysOS}-exe-cpu
cmake -DCMAKE_INSTALL_PREFIX=install -DCMAKE_BUILD_TYPE=Release -DOCR_OUTPUT="EXE" -DOCR_VULKAN=OFF ..
cmake --build . --config Release -j $NUM_THREADS
cmake --build . --config Release --target install
popd

mkdir -p ${sysOS}-exe-gpu
pushd ${sysOS}-exe-gpu
cmake -DCMAKE_INSTALL_PREFIX=install -DCMAKE_BUILD_TYPE=Release -DOCR_OUTPUT="EXE" -DOCR_VULKAN=ON ..
cmake --build . --config Release -j $NUM_THREADS
cmake --build . --config Release --target install
popd

mkdir -p ${sysOS}-jni-cpu
pushd ${sysOS}-jni-cpu
cmake -DCMAKE_INSTALL_PREFIX=install -DCMAKE_BUILD_TYPE=Release -DOCR_OUTPUT="JNI" -DOCR_VULKAN=OFF ..
cmake --build . --config Release -j $NUM_THREADS
cmake --build . --config Release --target install
popd

mkdir -p ${sysOS}-jni-gpu
pushd ${sysOS}-jni-gpu
cmake -DCMAKE_INSTALL_PREFIX=install -DCMAKE_BUILD_TYPE=Release -DOCR_OUTPUT="JNI" -DOCR_VULKAN=ON ..
cmake --build . --config Release -j $NUM_THREADS
cmake --build . --config Release --target install
popd