## 模型转换简易说明

### 准备环境和工具

1. Ubuntu 20.04 x64

2. python3/pip3 >= 3.7

3. onnx-simplifier

```shell
git clone https://github.com/daquexian/onnx-simplifier
cd onnx-simplifier
sudo python3 setup.py install
```

4. [onnx模型下载](https://github.com/RapidOCR/Paddle2OnnxConvertor/releases)

5. 编译ncnn，取得onnx2ncnn工具
```shell
sudo apt-get install build-essential
git clone https://github.com/Tencent/ncnn.git
cd ncnn
git submodule init
git submodule update
mkdir -p "build-linux-Release"
pushd "build-linux-Release"
cmake -DCMAKE_BUILD_TYPE=Release \
      -DNCNN_OPENMP=ON \
      -DNCNN_BUILD_BENCHMARK=OFF \
      -DNCNN_BUILD_EXAMPLES=OFF \
      -DNCNN_BUILD_TOOLS=ON \
      -DNCNN_PYTHON=OFF \
      -DNCNN_VULKAN=OFF \
      ..
make -j 4
make install
# 最后找到工具build-linux-Release/tools/onnx/onnx2ncnn
```

### 开始转换

1. 执行onnx-simplifier

```shell
## cls 模型
python3 -m onnxsim ch_ppocr_mobile_v2.0_cls_infer.onnx ch_ppocr_mobile_v2.0_cls_simp.onnx --input-shape "1,3,48,192"
## mobile模型
python3 -m onnxsim ch_ppocr_mobile_v2.0_det_infer.onnx ch_ppocr_mobile_v2.0_det_simp.onnx --input-shape "1,3,32,32"
python3 -m onnxsim ch_ppocr_mobile_v2.0_rec_infer.onnx ch_ppocr_mobile_v2.0_rec_simp.onnx --input-shape "1,3,32,32"
## server模型
python3 -m onnxsim ch_ppocr_server_v2.0_det_infer.onnx ch_ppocr_server_v2.0_det_simp.onnx --input-shape "1,3,32,32"
python3 -m onnxsim ch_ppocr_server_v2.0_rec_infer.onnx ch_ppocr_server_v2.0_rec_simp.onnx --input-shape "1,3,32,32"
```

2. 执行onnx2ncnn

```shell
## cls 模型
./onnx2ncnn ch_ppocr_mobile_v2.0_cls_simp.onnx ch_ppocr_mobile_v2.0_cls_infer.param ch_ppocr_mobile_v2.0_cls_infer.bin
#cls 模型转换有错误提示：Unsupported squeeze axes !
## mobile模型
./onnx2ncnn ch_ppocr_mobile_v2.0_det_simp.onnx ch_ppocr_mobile_v2.0_det_infer.param ch_ppocr_mobile_v2.0_det_infer.bin
./onnx2ncnn ch_ppocr_mobile_v2.0_rec_simp.onnx ch_ppocr_mobile_v2.0_rec_infer.param ch_ppocr_mobile_v2.0_rec_infer.bin
# mobile rec模型转换由错误提示：Unsupported squeeze axes !
## server模型
./onnx2ncnn ch_ppocr_server_v2.0_det_simp.onnx ch_ppocr_server_v2.0_det_infer.param ch_ppocr_server_v2.0_det_infer.bin
./onnx2ncnn ch_ppocr_server_v2.0_rec_simp.onnx ch_ppocr_server_v2.0_rec_infer.param ch_ppocr_server_v2.0_rec_infer.bin
```