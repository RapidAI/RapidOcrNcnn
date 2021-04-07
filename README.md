# RapidOCRNcnnCpp

### Project下载

* 有整合好源码和依赖库的完整工程项目，文件比较大，可到Q群共享内下载，找以Project开头的压缩包文件
* 如果想自己折腾，则请继续阅读本说明

### 介绍

RapidOCR ncnn 推理

模型转换路线: paddle-> onnx -> onnx-simplifier -> ncnn

onnx2ncnn转换工具未完全支持，部分模型转换出错，目前关闭cls模型来使用

转换成功的模型：mobile_det,server_det,server_rec

转换失败的模型：mobile_cls,mobile_rec

### [模型转换说明](./models/README.md)

### 模型下载

未完成

### 依赖库ncnn cpu 下载

Linux和Windows系统使用官方发布包[ncnn20210322](https://github.com/Tencent/ncnn/releases/tag/20210322)

macOS使用[NcnnBuilder](https://github.com/RapidOCR/NcnnBuilder/releases/tag/20210322)

如果因系统太新或太旧而不支持，请尝试自己折腾编译。

cpu版解压放入RapidOCRNcnnCpp/ncnn-static

| 操作系统 | 软件包 |
| ------- | ------- |
| macos10.15 cpu | [ncnn-20210322-macos.7z](https://github.com/RapidOCR/NcnnBuilder/releases/download/20210322/ncnn-20210322-macos1015.7z) |
| ubuntu16.04 cpu| [ncnn-20210322-ubuntu1604.7z](https://github.com/RapidOCR/NcnnBuilder/releases/download/20210322/ncnn-20210322-ubuntu1604.7z) |
| windows vs2017 cpu | [ncnn-20210322-windows-vs2017.7z](https://github.com/RapidOCR/NcnnBuilder/releases/download/20210322/ncnn-20210322-windows-vs2017.7z) |
| windows vs2019 cpu | [ncnn-20210322-windows-vs2019.7z](https://github.com/RapidOCR/NcnnBuilder/releases/download/20210322/ncnn-20210322-windows-vs2019.7z) |

解压后文件目录结构如下

```
RapidOCRNcnnCpp/ncnn-static
├── NcnnWrapperConfig.cmake
├── linux
├── macos
├── windows-x64
└── windows-x86
```

### 依赖库ncnn gpu 下载

| 操作系统 | 软件包 |
| ------- | ------- |
| macos10.15 gpu| [ncnn-20210322-macos1015-vulkan.7z](https://github.com/RapidOCR/NcnnBuilder/releases/download/20210322/ncnn-20210322-macos1015-vulkan.7z) |
| ubuntu16.04 gpu| [ncnn-20210322-ubuntu1604-vulkan.7z](https://github.com/RapidOCR/NcnnBuilder/releases/download/20210322/ncnn-20210322-ubuntu1604-vulkan.7z) |
| windows vs2017 gpu | [ncnn-20210322-windows-vs2017.zip](https://github.com/Tencent/ncnn/releases/download/20210322/ncnn-20210322-windows-vs2017.zip) |
| windows vs2019 gpu | [ncnn-20210322-windows-vs2019.zip](https://github.com/Tencent/ncnn/releases/download/20210322/ncnn-20210322-windows-vs2019.zip) |

gpu版解压放入RapidOCRNcnnCpp/ncnn-vulkan-static

```
RapidOCRNcnnCpp/ncnn-vulkan-static
├── NcnnWrapperConfig.cmake
├── linux
├── macos
├── windows-x64(文件夹名x64修改)
└── windows-x86(文件夹名x86修改)
```

### 依赖库opencv下载

[定制精简版OpenCV](https://github.com/RapidOCR/OpenCVBuilder)

| 操作系统 | 软件包 |
| ------- | ------- |
| macos10.15 | [opencv-4.5.1-macos1015.7z](https://github.com/RapidOCR/OpenCVBuilder/releases/download/4.5.1/opencv-4.5.1-macos1015.7z) |
| ubuntu16.04 | [opencv-4.5.1-ubuntu1604.7z](https://github.com/RapidOCR/OpenCVBuilder/releases/download/4.5.1/opencv-4.5.1-ubuntu1604.7z) |
| windows vs2017 | [opencv-4.5.1-windows-vs2017.7z](https://github.com/RapidOCR/OpenCVBuilder/releases/download/4.5.1/opencv-4.5.1-windows-vs2017.7z) |
| windows vs2019 | [opencv-4.5.1-windows-vs2019.7z](https://github.com/RapidOCR/OpenCVBuilder/releases/download/4.5.1/opencv-4.5.1-windows-vs2019.7z) |

解压后文件目录结构如下

```
RapidOCRNcnnCpp/opencv-static
├── OpenCVWrapperConfig.cmake
├── linux
├── macos
├── windows-x64
└── windows-x86
```

### macOS编译
