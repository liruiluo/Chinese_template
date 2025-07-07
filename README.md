# 中文文档模板 v1.0.0：通用中文LaTeX文档模板

## 简介
本项目提供一个通用的中文LaTeX文档模板，基于优秀的开源项目修改而成，去除了特定学校和机构的信息，保留了优秀的中文排版功能。

本模板经过重新设计，支持多种平台，解决了在不同系统上显示中文字体的问题，同时提供了灵活的配置选项和完整的文档结构，是一个为中文文档写作优化的LaTeX模板。

## 主要特性
- ✅ 基于XeLaTeX，完美支持中文排版
- ✅ 支持多种字体配置方式（自动检测和手动路径）
- ✅ 规范的文档结构（封面、摘要、目录、正文、参考文献、附录）
- ✅ 优美的版式设计和合理的间距
- ✅ 支持表格索引、插图索引、符号对照表
- ✅ 兼容多种引用格式（GB7714-2015标准）
- ✅ 详细的使用说明和示例

## 快速开始

### 环境要求
- 安装 TeX Live 或 MiKTeX
- 支持 XeLaTeX 编译器
- 文件编码必须为 UTF-8

### 基本使用
1. 下载模板文件
2. 打开 `document.tex` 文件
3. 修改文档基本信息：
   ```latex
   \ctitle{您的文档标题}
   \cauthor{作者姓名}
   \date{二〇二四年十二月}
   \ckeywords{关键词1，关键词2，关键词3}
   ```
4. 使用 XeLaTeX 编译

### 字体配置
本模板提供两种字体配置方式：

#### 自动字体配置（推荐Windows用户）
```latex
\documentclass[fontset=chinesefontauto]{chinesedoc}
```

#### 手动字体配置（推荐其他平台用户）
```latex
\documentclass[fontset=chinesefontpath]{chinesedoc}
```
使用此选项时，需要在项目根目录创建 `chinesefont` 文件夹，并放置相应的字体文件：
- SimSun.ttc (宋体)
- SimHei.ttf (黑体)
- KaiTi.ttf (楷体)
- FangSong.ttf (仿宋)

## 文档结构
```
├── document.tex          # 主文档文件
├── chinesedoc.cls        # 文档类定义
├── references.bib        # 参考文献数据库
├── chap/                 # 章节文件目录
│   ├── Abstract.tex      # 中英文摘要
│   ├── 1-Intro.tex       # 第一章
│   ├── 2-Feature.tex     # 第二章
│   ├── 3-Advanced.tex    # 第三章
│   ├── 4-Supplement.tex  # 第四章
│   ├── Denotation.tex    # 符号对照表
│   ├── Acknowledgment.tex # 致谢
│   └── Appendix.tex      # 附录
├── chinesefont/          # 字体文件目录（可选）
└── ctex-fontset-*.def    # 字体配置文件
```

## 文档类选项
主要选项说明：
- `fontset=chinesefontauto/chinesefontpath`: 字体配置方式
- `zihao=-4/5`: 正文字号（小四号/五号）
- `ugly`: 启用严格格式
- `openany`: 允许章节从任意页开始
- `spacing`: 优化间距设置

## 版本历史
- v1.0.0 (2024/12/19): 初始版本，基于原北大模板修改，去除特定信息

## 许可证
本项目遵循 LaTeX Project Public License v1.3 或更高版本。

## 贡献
欢迎提交 Issue 和 Pull Request 来改进本模板。

## 致谢
感谢原始模板的开发者们，为中文LaTeX排版做出的贡献。
