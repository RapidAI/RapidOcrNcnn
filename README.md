# RapidOCRNcnnCpp

### Project下载

* 有整合好源码和依赖库的完整工程项目，文件比较大，可到Q群共享内下载，找以Project开头的压缩包文件
* 如果想自己折腾，则请继续阅读本说明

### 介绍

本项目已停止更新。

RapidOCR ncnn 推理

~~模型转换路线: paddle-> onnx -> onnx-simplifier -> ncnn~~

~~onnx2ncnn转换工具未完全支持，部分模型转换出错，目前关闭cls模型来使用~~

~~转换成功的模型：mobile_det,server_det,server_rec~~

~~转换失败的模型：mobile_cls,mobile_rec~~

### [模型转换说明](./models/README.md)

### [模型下载](https://github.com/RapidOCR/RapidOCRNcnnCpp/releases/tag/init)

### [编译说明](./BUILD.md)

### 测试说明

1. 根据系统下载对应的程序包linux-bin.7z、macos-bin.7z、windows-bin.7z，并解压.
2. 把上面的模型下载，解压到第一步解压的文件夹里.
3. 终端运行run-test-cn.sh或命令行运行run-test-cn.bat，选择模型，查看识别结果.
4. 终端运行run-benchmark-cn.sh或命令行运行run-benchmark-cn.bat，选择模型，查看识别过程平均耗时.

### FAQ

#### macOS缺少openmp

```brew install libomp```

#### gpu版程序运行出错，缺少vulkan sdk

参考[编译说明](./BUILD.md) 安装vulkan sdk

#### windows提示缺少"VCRUNTIME140_1.dll"

下载安装适用于 Visual Studio 2015、2017 和 2019 的 Microsoft Visual C++ 可再发行软件包
[下载地址](https://support.microsoft.com/zh-cn/help/2977003/the-latest-supported-visual-c-downloads)

#### Windows7执行错误|中文乱码

1. cmd窗口左上角-属性
2. 字体选项卡-选择除了“点阵字体”以外的TrueType字体,例如:Lucida Console、宋体
3. 重新执行bat

### 参数说明

1. ```-d或--models```: 模型所在文件夹路径，可以相对路径也可以绝对路径。
2. ```-1或--det```: dbNet模型文件名(不含扩展名)
3. ```-2或--cls```: angleNet模型文件名(不含扩展名)
4. ```-3或--rec```: crnnNet模型文件名(不含扩展名)
5. ```-4或--keys```: keys.txt文件名(含扩展名)
6. ```-i或--image```: 目标图片路径，可以相对路径也可以绝对路径。
7. ```-t或--numThread```: 线程数量。
8. ```-p或--padding```: 图像预处理，在图片外周添加白边，用于提升识别率，文字框没有正确框住所有文字时，增加此值。
9. ```-s或--maxSideLen```
   : 按图片最长边的长度，此值为0代表不缩放，例：1024，如果图片长边大于1024则把图像整体缩小到1024再进行图像分割计算，如果图片长边小于1024则不缩放，如果图片长边小于32，则缩放到32。
10. ```-b或--boxScoreThresh```: 文字框置信度门限，文字框没有正确框住所有文字时，减小此值。
11. ```-u或--unClipRatio```：单个文字框大小倍率，越大时单个文字框越大。此项与图片的大小相关，越大的图片此值应该越大。
12. ```-a或--doAngle```：启用(1)/禁用(0) 文字方向检测，只有图片倒置的情况下(旋转90~270度的图片)，才需要启用文字方向检测。
13. ```-A或--mostAngle```：启用(1)/禁用(0) 角度投票(整张图片以最大可能文字方向来识别)，当禁用文字方向检测时，此项也不起作用。
14. ```-h或--help```：打印命令行帮助。
15. ```-G或--GPU```：尝试使用gpu进行计算，-1(使用CPU)/0(使用GPU0)/1(使用GPU1)/...，GPU选择失败时，则使用CPU进行计算。