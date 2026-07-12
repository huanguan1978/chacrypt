# ChaPose: 高性能离线文件安全守护者 (ChaCrypt 生态核心)

当您通过邮件、网盘或即时通讯工具传输文件时，如果文件未经加密，这些数据几乎相当于在互联网上“裸奔”，随时可能被拦截或泄露。即便您坚持将隐私文件保存在本地，也无法阻止同一设备上其他应用的数据窥视。

**有了文件加密，这一切就完全不一样了！**

**ChaPose** 是 ChaCrypt 生态中的 CLI（命令行）核心组件。它不是一个臃肿的加密软件，而是一个专为高性能处理、自动化流转及强力安全加固而生的专业级守护者。

### 快速上手
安装完成后，您可以通过以下命令验证：
*   **查看版本**：`chapose --version` (成功安装会输出版本号)
*   **获取帮助**：`chapose help` (查看全局帮助)
*   **子命令帮助**：`chapose help <command>` (例如 `chapose help encrypt`，**特别提示：子命令帮助文档中附带了丰富的常用示例，建议优先查阅**)

### 核心功能命令

1.  **`keyfile` - 密钥管理**
    生成高熵随机密钥文件，作为后续加解密操作的唯一信任凭证。
    *   *用法*：`chapose keyfile -p "您的强密码" -o ~/.secrets/chapose.key`

2.  **`encrypt` - 敏感数据加固**
    将明文文件转换为高强度 `.cha` 密文。
    *   *用法*：`chapose encrypt sensitive.db`

3.  **`decrypt` - 安全数据还原**
    验证并解密 `.cha` 密文文件，将其还原为原始明文。
    *   *用法*：`chapose decrypt sensitive.db.cha`

### 自动化流水线 (非 YAML 编排下的手工执行示例)

ChaPose 专注于单文件的高强度加密。如果您需要处理复杂的“归档 -> 加密 -> 物理销毁”流程，可以配合 `ft:filetools`（由同一开发者维护的开源跨平台工具，[点击访问官方仓库](https://github.com/huanguan1978/ft)）实现自动化：

1.  **归档**：`ft archive --source ./data --target bundle.tgz`
2.  **加密**：`chapose encrypt bundle.tgz -w` (使用 `-w` 强制覆盖)
3.  **物理销毁**：`ft wipe ./data --levels=medium` (彻底擦除原始明文)
4.  **清理中间件**：`ft wipe bundle.tgz --levels=low` (擦除中间归档包)

### CLI 最佳实践：无感加密

为了实现“无感加密”，您可以配置全局环境变量 `CHAPOSE_KEYFILE`，从而在执行命令时无需手动指定密钥路径。

*   **Unix/macOS (Zsh/Bash)**:
    在 `~/.zshrc` 或 `~/.bashrc` 中添加：
    `export CHAPOSE_KEYFILE="$HOME/.secrets/chapose.key"`
*   **Windows (PowerShell)**:
    执行：`[Environment]::SetEnvironmentVariable("CHAPOSE_KEYFILE", "$HOME\.secrets\chapose.key", "User")`
*   **Windows (CMD)**:
    执行：`setx CHAPOSE_KEYFILE "%USERPROFILE%\.secrets\chapose.key"`

配置完成后，您只需执行 `chapose encrypt target.data`，系统将自动读取环境变量中的密钥，极大提升操作效率。

---

**准备好掌控您的数据主权了吗？**
访问我们的 [GitHub 仓库](https://github.com/huanguan1978/chacrypt/tree/main/chapose) 获取源码、二进制安装包及详细的技术文档。
