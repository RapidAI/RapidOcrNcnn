@ECHO OFF
chcp 65001
cls
@SETLOCAL

mkdir win-exe-x64-cpu
pushd win-exe-x64-cpu
cmake -T "v141,host=x64" -A "x64" ^
  -DCMAKE_INSTALL_PREFIX=install ^
  -DCMAKE_BUILD_TYPE=Release -DOCR_OUTPUT="EXE" -DOCR_VULKAN=OFF ..
cmake --build . --config Release -j %NUMBER_OF_PROCESSORS%
cmake --build . --config Release --target install
popd

mkdir win-exe-x86-cpu
pushd win-exe-x86-cpu
cmake -T "v141,host=x64" -A "Win32" ^
  -DCMAKE_INSTALL_PREFIX=install ^
  -DCMAKE_BUILD_TYPE=Release -DOCR_OUTPUT="EXE" -DOCR_VULKAN=OFF ..
cmake --build . --config Release -j %NUMBER_OF_PROCESSORS%
cmake --build . --config Release --target install
popd

mkdir win-exe-x64-gpu
pushd win-exe-x64-gpu
cmake -T "v141,host=x64" -A "x64" ^
  -DCMAKE_INSTALL_PREFIX=install ^
  -DCMAKE_BUILD_TYPE=Release -DOCR_OUTPUT="EXE" -DOCR_VULKAN=ON ..
cmake --build . --config Release -j %NUMBER_OF_PROCESSORS%
cmake --build . --config Release --target install
popd

mkdir win-exe-x86-gpu
pushd win-exe-x86-gpu
cmake -T "v141,host=x64" -A "Win32" ^
  -DCMAKE_INSTALL_PREFIX=install ^
  -DCMAKE_BUILD_TYPE=Release -DOCR_OUTPUT="EXE" -DOCR_VULKAN=ON ..
cmake --build . --config Release -j %NUMBER_OF_PROCESSORS%
cmake --build . --config Release --target install
popd

@ENDLOCAL
