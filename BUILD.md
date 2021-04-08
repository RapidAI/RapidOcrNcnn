# 编译说明

### 依赖库ncnn cpu 下载

使用[NcnnBuilder](https://github.com/RapidOCR/NcnnBuilder/releases/tag/20210322)

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
| windows vs2017 gpu | [ncnn-20210322-windows-vs2017-vulkan.7z](https://github.com/RapidOCR/NcnnBuilder/releases/download/20210322/ncnn-20210322-windows-vs2017-vulkan.7z) |
| windows vs2019 gpu | [ncnn-20210322-windows-vs2019-vulkan.7z](https://github.com/RapidOCR/NcnnBuilder/releases/download/20210322/ncnn-20210322-windows-vs2019-vulkan.7z) |

gpu版解压放入RapidOCRNcnnCpp/ncnn-vulkan-static

```
RapidOCRNcnnCpp/ncnn-vulkan-static
├── NcnnWrapperConfig.cmake
├── linux
├── macos
├── windows-x64(文件夹名x64修改)
└── windows-x86(文件夹名x86修改)
```

### 依赖库vulkan SDK下载

Vulkan SDK[下载地址](https://vulkan.lunarg.com/sdk/home)

* 如果想编译ncnn gpu，则必须先安装Vulkan SDK。
* 一般下载最新版即可，当前最新版1.2.162.0
* Windows：直接双击安装。
* macOS：加载dmg后，终端执行```./install_vulkan.py```
* Linux: 解压tar.gz文件后，把scripts文件夹里的install-vulkan-linux.sh复制到解压后的文件夹，并打开终端执行

```
chmod a+x install-vulkan-linux.sh
./install-vulkan-linux.sh
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

### Linux编译

1. Ubuntu16.04 LTS 或其它发行版
2. ```sudo apt-get install build-essential```
3. cmake>=3.17[下载地址](https://cmake.org/download/)
4. 终端打开项目根目录，```./build.sh```并按照提示输入选项，最后选择'BIN可执行文件'
5. 测试：```./run-test.sh```(注意修改脚本内的目标图片路径)
6. 编译JNI动态运行库(可选，可用于java调用)

* 下载jdk-8u221并安装配置
* 运行```build.sh```并按照提示输入选项，最后选择'JNI动态库'
* **注意：编译JNI时，g++版本要求>=6**

#### Linux部署说明

有依赖的库是动态库时，参考下列方法：

* 把动态库所在路径加入LD_LIBRARY_PATH搜索路径
* 把动态库复制或链接到到/usr/lib

### macOS编译说明

1. macOS Catalina 10.15.x，安装Xcode>=12，并安装Xcode Command Line Tools, 终端运行```xcode-select –install```
2. 自行下载安装HomeBrew，cmake >=3.19[下载地址](https://cmake.org/download/)
3. libomp: ```brew install libomp```
4. 终端打开项目根目录，```./build.sh```并按照提示输入选项，最后选择'BIN可执行文件'
5. 测试：```./run-test.sh```(注意修改脚本内的目标图片路径)
6. 编译JNI动态运行库(可选，可用于java调用)

* 下载jdk-8u221-macosx-x64.dmg，安装。
* 编辑用户目录下的隐藏文件```.zshrc``` ，添加```export JAVA_HOME=$(/usr/libexec/java_home)```
* 运行```build.sh```并按照提示输入选项，最后选择'JNI动态库'

#### macOS部署说明

如果有依赖的库是动态库时，参考下列方法：

* 把动态库所在路径加入DYLD_LIBRARY_PATH搜索路径
* 把动态库复制或链接到到/usr/lib

### Windows编译说明

1. 安装VS2017或VS2019，安装时，至少选中'使用C++的桌面开发'
2. cmake请自行下载&配置，[下载地址](https://cmake.org/download/)
3. 开始菜单打开"x64 Native Tools Command Prompt for VS 2019"或"适用于 VS2017 的 x64 本机工具"，并转到本项目根目录
4. 运行```build.bat```并按照提示输入选项，最后选择'BIN可执行文件'
5. 编译完成后运行```run-test.bat```进行测试(注意修改脚本内的目标图片路径)
6. 编译JNI动态运行库(可选，可用于java调用)

* 下载jdk-8u221-windows-x64.exe，安装选项默认(确保“源代码”项选中)，安装完成后，打开“系统”属性->高级->环境变量
* 新建“系统变量”，变量名```JAVA_HOME``` ，变量值```C:\Program Files\Java\jdk1.8.0_221``
* 新建“系统变量”，变量名```CLASSPATH``` ，变量值```.;%JAVA_HOME%\lib\dt.jar;%JAVA_HOME%\lib\tools.jar;``
* 编辑“系统变量”Path，Win7在变量值头部添加```%JAVA_HOME%\bin;``` ，win10直接添加一行```%JAVA_HOME%\bin```
* 开始菜单打开"x64 Native Tools Command Prompt for VS 2019"或"适用于 VS2017 的 x64 本机工具"，并转到本项目根目录
* 运行```build.bat```并按照提示输入选项，最后选择'JNI动态库'

#### Windows部署说明

1. 如果有依赖的库是动态库时，部署的时候记得把dll复制到可执行文件目录。
2. 部署时如果提示缺少"VCRUNTIME140_1.dll"，下载安装适用于 Visual Studio 2015、2017 和 2019 的 Microsoft Visual C++ 可再发行软件包，
   [下载地址](https://support.microsoft.com/zh-cn/help/2977003/the-latest-supported-visual-c-downloads)