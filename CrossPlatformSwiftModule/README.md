# 创建跨苹果平台的 Swift 框架

![IMG_2952-w400](https://wenslowzhu.github.io/media/15847997558803/IMG_2952.jpg)


为了使代码更容易维护和部署，以及在 App 之间共享，可以将底层可复用的代码存放在独立的 Framework 中而不是 App 项目中。在这篇博客中，我们来学习如何通过 Xcode 来创建 Swift Framework，并使它可在 iOS，watchOS，tvOS 和 macOS App 中使用。

<!-- more -->

>Xcode 版本 11.1
Swift 版本 5.0

## 1. 创建项目

创建一个名为 **CrossPlatformSwiftModule** 的 Xcode 项目，并选择 **Cross-platform -> Empty**

![截屏2020-03-2123.30.18](https://wenslowzhu.github.io/media/15847997558803/%E6%88%AA%E5%B1%8F2020-03-2123.30.18.png)

完成后的项目一览

![截屏2020-03-2123.33.56](https://wenslowzhu.github.io/media/15847997558803/%E6%88%AA%E5%B1%8F2020-03-2123.33.56.png)
接着我们可以为不同平台创建 Target 了。以 iOS Target 为例。点击 ➕ 按钮，选择  **iOS -> Framework & Library -> Framework**。Target 命名为 **CrossPlatformSwiftModule_iOS**。

![截屏2020-03-2123.45.51](https://wenslowzhu.github.io/media/15847997558803/%E6%88%AA%E5%B1%8F2020-03-2123.45.51.png)


![截屏2020-03-2123.49.39](https://wenslowzhu.github.io/media/15847997558803/%E6%88%AA%E5%B1%8F2020-03-2123.49.39.png)

如法炮制，我们接着创建 watchOS，tvOS 和 macOS 的 Framework。

![截屏2020-03-2123.56.48](https://wenslowzhu.github.io/media/15847997558803/%E6%88%AA%E5%B1%8F2020-03-2123.56.48.png)

下一步，我们在项目中创建一个名为的 Sources 的空文件夹，它也是我们存放源代码的地方。

![截屏2020-03-2200.04.05](https://wenslowzhu.github.io/media/15847997558803/%E6%88%AA%E5%B1%8F2020-03-2200.04.05.png)

## 2. Info.plist 文件

我们将 iOS framework 文件夹下的 Info.plist 文件复制到 **Sources/SupportingFiles** 文件夹下。这个 Info.plist 会被所有平台共享。

![截屏2020-03-2200.10.11](https://wenslowzhu.github.io/media/15847997558803/%E6%88%AA%E5%B1%8F2020-03-2200.10.11.png)

在 **Sources/SupportingFiles** 文件夹上右键，并选择 **Add Files**

![截屏2020-03-2200.10.20](https://wenslowzhu.github.io/media/15847997558803/%E6%88%AA%E5%B1%8F2020-03-2200.10.20.png)

选择添加刚刚复制过去的 Info.plist 文件。注意⚠️**不要选中 Copy items if needed**。

![截屏2020-03-2200.11.01](https://wenslowzhu.github.io/media/15847997558803/%E6%88%AA%E5%B1%8F2020-03-2200.11.01.png)

将各个 Framework 文件夹下的 Info.plist 文件删除。只保留 **Sources/SupportingFiles** 文件夹下的 Info.plist 文件。

![截屏2020-03-2200.19.57](https://wenslowzhu.github.io/media/15847997558803/%E6%88%AA%E5%B1%8F2020-03-2200.19.57.png)

接着在 Targets 中选中 CrossPlatformSwiftModule_iOS -> Build Settings -> Packaging -> Info.plist File。将值更改为 Sources/SupportingFiles/Info.plist。

![截屏2020-03-2200.23.33](https://wenslowzhu.github.io/media/15847997558803/%E6%88%AA%E5%B1%8F2020-03-2200.23.33.png)

同样的，我们为另外的三个 Framework 也做同样的配置。完成设置后再确认一下，是否所有 Target 都能成功加载 Info 选项标签。

## 3. Header Files

为了使 OC 项目可以成功桥接我们的 Swift Framework，我们还需要对 .h 文件做额外的设置。

将 **CrossPlatformSwiftModule_iOS** 文件夹下的 **CrossPlatformSwiftModule_iOS.h** 文件拷贝到 Sources/SupportingFiles 中。并将拖入到 Xcode 的 Sources/SupportingFiles 文件夹中

![截屏2020-03-2210.50.18](https://wenslowzhu.github.io/media/15847997558803/%E6%88%AA%E5%B1%8F2020-03-2210.50.18.png)

删除 **CrossPlatformSwiftModule_iOS.h** 文件里的所有 "_iOS"，并将该文件重命名为 **CrossPlatformSwiftModule.h**。选中 **CrossPlatformSwiftModule.h** 文件，将其勾选到所以 Target 中，并设置为 Public。

![截屏2020-03-2210.52.54](https://wenslowzhu.github.io/media/15847997558803/%E6%88%AA%E5%B1%8F2020-03-2210.52.54.png)
此时可以将项目中除 Sources 文件夹之外的其他文件夹全部删掉。

![截屏2020-03-2210.56.52](https://wenslowzhu.github.io/media/15847997558803/%E6%88%AA%E5%B1%8F2020-03-2210.56.52.png)

## 4. 添加代码

完善上述的所有设置之后，我们终于可以开始添加代码了。尝试着新建一个代码文件吧。记得添加代码时，要勾选上所有 Target。

![截屏2020-03-2210.58.47](https://wenslowzhu.github.io/media/15847997558803/%E6%88%AA%E5%B1%8F2020-03-2210.58.47.png)

## 5. 在代码层面适配多平台

不同的平台使用不同的系统框架，所以我们要为不同的平台 import 不同的系统框架。

![截屏2020-03-2211.09.17](https://wenslowzhu.github.io/media/15847997558803/%E6%88%AA%E5%B1%8F2020-03-2211.09.17.png)

除了可以 import 不同的系统框架，我们可能还需要自定义跨平台的数据类型。

![截屏2020-03-2211.12.40](https://wenslowzhu.github.io/media/15847997558803/%E6%88%AA%E5%B1%8F2020-03-2211.12.40.png)

这样设置后，我们自定义的 **ImageType** 类型就可以跨平台使用了。

## 小结

相信现在你已经掌握了如何创建跨平台的 Swift Framework。通过上述的方法，可以将一套代码部署到多个平台，方便省事😉。

[Demo 的 Github 地址](https://github.com/WenslowZhu/CrossPlatformSwiftModule)
