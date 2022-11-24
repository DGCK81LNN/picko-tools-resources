# picko-tools-resources

此仓库存档了 [Five-Character Code (FCC)](https://github.com/1stchrc) 曾尝试制作的平台跳跃游戏“PICKO”的几乎所有开发版本，以及我 ([DGCK81LNN](https://github.com/DGCK81LNN)) 为之编写的更改日志和一些测试工具。

2021 年 10 月起 FCC 开始使用 C++ 编写 PICKO（目标 Windows 平台）；另有用 C# 编写、可在 Unity 编辑器中运行的地图编辑器（此仓库中未包含）。2022 年 10 月宣布弃坑。

本仓库目录：

* [resources/game versions.zip](./resources/game%20versions.zip) 包含了 PICKO 的一系列开发版本（可在 Win32 系统上运行），不含源代码。

* [resources/](./resources/) 中的其他文件为可替换的地图、回放等资源文件。回放文件按适用的游戏版本分为几类，除最新版本的一类外，其余的存储在 [resources/legacy/](./resources/legacy/)。

* [changelogs/](./changelogs/) 包含了这些开发版本的更新日志和一些关于最早期版本的文件。

* [tools/](./tools/) 包含我编写的测试工具，其中核心的 picko-tools.sh 脚本需要一个在 Windows 上运行的 GNU 工具集（最常用的是 Git for Windows 附带的 MinGW〔Minimalist GNU for Windows〕）。
