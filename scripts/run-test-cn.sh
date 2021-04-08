#!/usr/bin/env bash

function PrepareVar() {
  echo "Gpu版本测试前请先安装Vulkan SDK v1.2.162.0，https://vulkan.lunarg.com/sdk/home"
  echo "请输入测试选项并回车: 1)CPU, 2)GPU"
  read -p "" RUN_ARCH
  if [ $RUN_ARCH == 1 ]; then
    EXE_PATH=${sysOS}-bin-cpu
    GPU_INDEX=-1
  elif [ $RUN_ARCH == 2 ]; then
    EXE_PATH=${sysOS}-bin-gpu
    GPU_INDEX=0
  else
    echo -e "输入错误！Input Error!"
  fi
}

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

echo "Setting the Number of Threads=$NUM_THREADS Using an OpenMP Environment Variable"
set OMP_NUM_THREADS=$NUM_THREADS

PrepareVar

echo "请选择det模型: 1)server, 2)mobile"
read -p "" DET_MODEL
if [ $DET_MODEL == 1 ]; then
  DET_MODEL="ch_ppocr_server_v2.0_det_infer"
elif [ $DET_MODEL == 2 ]; then
  DET_MODEL="ch_ppocr_mobile_v2.0_det_infer"
else
  echo -e "Input Error!"
fi

REC_MODEL="ch_ppocr_server_v2.0_rec_infer"
#echo "请选择rec模型: 1)server, 2)mobile"
#read -p "" REC_MODEL
#if [ $REC_MODEL == 1 ]; then
#    REC_MODEL="ch_ppocr_server_v2.0_rec_infer"
#elif [ $REC_MODEL == 2 ]; then
#    REC_MODEL="ch_ppocr_mobile_v2.0_rec_infer"
#else
#  echo -e "Input Error!"
#fi

TARGET_IMG=images/1.jpg
if [ ! -f "$TARGET_IMG" ]; then
  echo "找不到待识别的目标图片：${TARGET_IMG}，请打开本文件并编辑TARGET_IMG"
  exit
fi

##### run test on MacOS or Linux
./${EXE_PATH}/RapidOCRNcnn --version
./${EXE_PATH}/RapidOCRNcnn --models models \
  --det $DET_MODEL \
  --cls ch_ppocr_mobile_v2.0_cls_infer \
  --rec $REC_MODEL \
  --keys ppocr_keys_v1.txt \
  --image $TARGET_IMG \
  --numThread $NUM_THREADS \
  --padding 50 \
  --maxSideLen 0 \
  --boxScoreThresh 0.5 \
  --boxThresh 0.3 \
  --unClipRatio 1.5 \
  --doAngle 0 \
  --mostAngle 0 \
  --GPU $GPU_INDEX
