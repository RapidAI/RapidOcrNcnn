chcp 65001
:: Set Param
@ECHO OFF
@SETLOCAL
echo "Setting the Number of Threads=%NUMBER_OF_PROCESSORS% Using an OpenMP Environment Variable"
set OMP_NUM_THREADS=%NUMBER_OF_PROCESSORS%

:MainExec
echo "Gpu版本测试前请先安装Vulkan SDK v1.2.162.0，https://vulkan.lunarg.com/sdk/home"
echo "请输入测试选项并回车: 1)CPU-x64, 2)CPU-x86, 3)GPU-x64, 4)GPU-x86"
set GPU_INDEX=-1
set /p flag=
if %flag% == 1 (
    set EXE_PATH=win-bin-x64-cpu
    set GPU_INDEX=-1
)^
else if %flag% == 2 (
    set EXE_PATH=win-bin-x86-cpu
    set GPU_INDEX=-1
)^
else if %flag% == 3 (
    set EXE_PATH=win-bin-x64-gpu
    set GPU_INDEX=0
)^
else if %flag% == 4 (
    set EXE_PATH=win-bin-x86-gpu
    set GPU_INDEX=0
)^
else (echo 输入错误！Input Error!)

echo "请选择det模型: 1)server, 2)mobile"
set /p flag=
if %flag% == 1 (set DET_MODEL=ch_ppocr_server_v2.0_det_infer)^
else if %flag% == 2 (set DET_MODEL=ch_ppocr_mobile_v2.0_det_infer)^
else (echo 输入错误！Input Error!)

set REC_MODEL=ch_ppocr_server_v2.0_rec_infer
:: echo "请选择rec模型: 1)server, 2)mobile"
:: set /p flag=
:: if %flag% == 1 (set REC_MODEL=ch_ppocr_server_v2.0_rec_infer)^
:: else if %flag% == 2 (set REC_MODEL=ch_ppocr_mobile_v2.0_rec_infer)^
:: else (echo 输入错误！Input Error!)

echo "请输入循环次数:"
set /p LOOP_COUNT=

SET TARGET_IMG=images/1.jpg
if not exist %TARGET_IMG% (
    echo "找不到待识别的目标图片：%TARGET_IMG%，请打开本文件并编辑TARGET_IMG"
    PAUSE
    exit
)

%EXE_PATH%\benchmark.exe --version
%EXE_PATH%\benchmark.exe --models models ^
--det %DET_MODEL% ^
--cls ch_ppocr_mobile_v2.0_cls_infer ^
--rec %REC_MODEL% ^
--keys ppocr_keys_v1.txt ^
--image %TARGET_IMG% ^
--numThread %NUMBER_OF_PROCESSORS% ^
--padding 50 ^
--maxSideLen 0 ^
--boxScoreThresh 0.5 ^
--boxThresh 0.3 ^
--unClipRatio 1.5 ^
--doAngle 0 ^
--mostAngle 0 ^
--GPU %GPU_INDEX% ^
--loopCount %LOOP_COUNT%

popd
echo.
GOTO:MainExec

@ENDLOCAL
