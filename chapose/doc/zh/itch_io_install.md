# ChaPose 安装指南

欢迎使用 ChaPose！您可以根据您的操作系统选择以下任一方式进行安装：

### 1. Shell 一键安装 (推荐)
适用于 macOS、Linux 及 Windows (Git Bash / MSYS2)。请确保您的系统中已安装 `curl`。

```bash
curl -fsSL https://raw.githubusercontent.com/huanguan1978/chacrypt/main/chapose/install.sh | sh
```

### 2. macOS 专用安装 (Homebrew / MacPorts)
我们维护了一个自建仓库 (Tap)，其中包含了 `chapose`、`ft:filetools` 以及其他由我开发的工具的安装支持。

👉 **访问自建仓库获取详细说明**: [huanguan1978/homebrew-tap](https://github.com/huanguan1978/homebrew-tap)

*   **Homebrew 安装**:
    ```bash
    brew tap huanguan1978/tap
    brew install chapose
    ```
*   **MacPorts 安装**:
    请参考上述自建仓库中的说明进行配置。

### 3. 手动下载安装
如果您需要特定架构的二进制文件，或希望手动管理安装，请访问我们的 GitHub Release 页面：

👉 [GitHub Release 页面 (chapose-v1.0.0)](https://github.com/huanguan1978/chacrypt/releases/tag/chapose-v1.0.0)

在该页面中，您可以找到针对不同平台（macOS, Linux, Windows）及 CPU 架构（x64, arm64 等）的压缩包及校验文件。

### 验证安装
安装完成后，请在终端执行以下命令验证是否成功：
```bash
chapose --version
```
如果输出版本号，说明安装成功。
