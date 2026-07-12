# ChaBox 生态上新：开源跨平台CLI文件加密工具 Chapose 正式发布！

大家好！很高兴向大家宣布，ChaBox 安全工具箱迎来了一位重量级新成员——**Chapose**。

## 什么是 Chapose？
Chapose 是一款基于工业级 **ChaCha20-Poly1305** 算法的开源命令行工具（CLI），专为高性能文件安全加固而设计。它能够以极低的内存开销，为任意大小的敏感数据提供机密性与完整性保护。

## 为什么它有实用价值？
在日常开发与运维中，我们经常面临敏感数据（如配置文件、数据库备份、私钥等）的存储与传输风险。传统的加密软件往往臃肿且难以集成到自动化脚本中。
Chapose 的核心价值在于：
*   **无感集成**：作为 CLI 工具，它可以轻松嵌入到任何 Shell 脚本或 CI/CD 流水线中。
*   **极致性能**：采用流式处理架构，处理 GB 级甚至 TB 级文件无需载入全量数据，速度极快。
*   **安全合规**：集成 Poly1305 认证机制，确保数据在传输与存储中未被篡改。

## 自动化处理：Chapose + ft:filetools
Chapose 专注于单文件的高强度加密。如果您需要处理更复杂的场景（例如：归档 -> 加密 -> 物理销毁原始明文），我们推荐配合 **ft:filetools** 使用。
通过 `ft` 的任务编排能力，您可以轻松构建一套“数据安全导出流水线”。具体配置方法与场景模拟，请参考 GitHub 仓库中的文档说明。

## 如何获取与安装
您可以访问我们的 GitHub 仓库获取详细的文档与使用指南：
👉 [Chapose GitHub 仓库](https://github.com/huanguan1978/chacrypt/tree/main/chapose)

### 安装方式
*   **通用安装 (macOS / Linux / Windows Git Bash)**：
    使用以下命令快速安装：
    `curl -fsSL https://raw.githubusercontent.com/huanguan1978/chacrypt/main/chapose/install.sh | sh`

*   **macOS 用户专属 (Homebrew / MacPorts)**：
    我们提供了专属的 Homebrew/MacPorts 自建仓库，方便您管理 Chapose 及 `ft:filetools`：
    👉 [Homebrew/MacPorts 自建仓库](https://github.com/huanguan1978/homebrew-tap)

欢迎大家下载试用，开启您的数据安全之旅！
