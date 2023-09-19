# RapidOcrNcnn

### 联系方式

- QQ群号：1群：~887298230~ 已满，2群：~755960114~ 已满，3群：450338158

### Project下载

* 整合好源码和依赖库的完整工程项目，可以在Release中下载(github)
* 可到Q群共享内下载，以Project开头的压缩包文件为源码工程，例：Project_RapidOcrNcnn-版本号.7z
* 如果想自己折腾，则请继续阅读本说明

### Demo下载(win、mac、linux)

* 编译好的demo，可以在release中下载，或者Q群共享内下载
* 各平台可执行文件：linux-bin.7z、macos-bin.7z、windows-bin.7z
* 用于java的jni库：linux-jni.7z、macos-jni.7z、windows-jni.7z
* 用于C的动态库：linux-clib.7z、macos-clib.7z、windows-clib.7z
* C动态库调用范例:[RapidOcrNcnnLibTest](https://github.com/RapidAI/RapidOcrNcnnLibTest)
* 注意：linux编译平台为ubuntu18.04，如果你的linux版本无法运行demo，请自行从源码编译依赖库和完整项目。

### 介绍

请查看项目主仓库：https://github.com/RapidAI/RapidOCR

这个项目使用ncnn框架进行推理

采用ncnn框架[https://github.com/Tencent/ncnn](https://github.com/Tencent/ncnn)

### 更新说明

#### 2022-10-18 update v1.1.0

* opencv 4.6.0
* ncnn 20220729
* windows支持mt版引用库
* rec模型输入图片高度改为48
* 修复：scoreToTextLine方法索引越界问题
* Windows控制台编码修改为UTF8

#### 2022-10-20 update v1.1.1

* rec阶段启用gpu
* 修复空格问题
* 改进benchmark输出格式

#### 2023-02-14 update v1.2.0

* ncnn: 20221128
* vulkan: 1.3.236.0

### 模型下载

整合好的范例工程自带了模型，在models文件夹中

```
RapidOcrNcnn/models
    ├── ch_PP-OCRv3_det_infer.bin
    ├── ch_PP-OCRv3_det_infer.param
    ├── ch_PP-OCRv3_rec_infer.bin
    ├── ch_PP-OCRv3_rec_infer.param
    ├── ch_ppocr_mobile_v2.0_cls_infer.bin
    ├── ch_ppocr_mobile_v2.0_cls_infer.param
    └── ppocr_keys_v1.txt
```

### [编译说明](./BUILD.md)

### 测试说明

1. 根据系统下载对应的程序包linux-bin.7z、macos-bin.7z、windows-bin.7z，并解压.
2. 把上面的模型下载，解压到第一步解压的文件夹里.
3. 终端运行run-test.sh或命令行运行run-test.bat，查看识别结果.
4. 终端运行run-benchmark.sh或命令行运行run-benchmark.bat，查看识别过程平均耗时.

### FAQ

#### gpu版程序运行出错，缺少vulkan sdk

参考[编译说明](./BUILD.md) 安装vulkan sdk

#### windows静态链接msvc

- 作用:静态链接CRT(mt)可以让编译出来的包，部署时不需要安装c++运行时，但会增大包体积；
- 需要mt版的引用库，参考编译说明，下载mt版的库；

#### windows提示缺少"VCRUNTIME140_1.dll"

下载安装适用于 Visual Studio 2015、2017 和 2019 的 Microsoft Visual C++ 可再发行软件包
[下载地址](https://support.microsoft.com/zh-cn/help/2977003/the-latest-supported-visual-c-downloads)

#### Windows7执行错误|中文乱码

1. cmd窗口左上角-属性
2. 字体选项卡-选择除了“点阵字体”以外的TrueType字体,例如:Lucida Console、宋体
3. 重新执行bat

### Windows调试运行

* 下载范例项目工程自带的引用库是Release版，不能用于调试运行
* debug版的引用库未压缩时容量超过1GB，极限压缩后也超过了100MB，请自行编译或到群共享里寻找
* debug版的引用库必须是md版
* 把debug版的引用库替换到范例工程的对应文件夹
* 双击generate-vs-project.bat，选择2)Debug，生成对应的build-win-vsxxx-xx文件夹
* 进入生成的文件夹，打开RapidOcrOnnx.sln
* 右边解决方案管理器，选中RapidOcrOnnx，右键->设为启动项目，并生成(查看输出log，确保生成成功)
* 如果引用库是dll，需要把对应的dll文件，例onnxruntime.dll复制到build-win-vsxxx-xx文件夹\Debug，跟上一步生成的RapidOcrOnnx.exe放在一起
* 右边解决方案管理器，选中RapidOcrOnnx，右键->属性->调试->
  命令参数->```--models ../models --det ch_PP-OCRv3_det_infer --cls ch_ppocr_mobile_v2.0_cls_infer --rec ch_PP-OCRv3_rec_infer --keys ppocr_keys_v1.txt --image ../images/1.jpg```
* 工具栏，点击绿色三角号启动"本地Windows调试器"
* 第一次运行的话，查看左下角，等待加载各dll符号，网络不好的话，要等挺久的

### 输入参数说明

* 请参考main.h中的命令行参数说明。
* 每个参数有一个短参数名和一个长参数名，用短的或长的均可。

1. ```-d或--models```: 模型所在文件夹路径，可以相对路径也可以绝对路径。
2. ```-1或--det```: det模型文件名(不含扩展名)
3. ```-2或--cls```: cls模型文件名(不含扩展名)
4. ```-3或--rec```: rec模型文件名(不含扩展名)
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
