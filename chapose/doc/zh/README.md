# Chapose: 现代高性能文件安全工具

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

**Chapose** 是一款基于工业级 **ChaCha20-Poly1305** 算法的文件加密工具，专为数据机密性与完整性保护而设计。它能够以极低的内存开销安全保护任意大小的敏感数据，是隐私保护、生产环境密钥分发及敏感信息安全流转的理想选择。

---

## 安装说明

### 二进制安装

**通用的远程脚本安装**（适用于 Linux、macOS 以及 Windows 下的 Git Bash / MSYS2）：
```sh
curl -fsSL https://raw.githubusercontent.com/huanguan1978/chacrypt/main/chapose/install.sh | sh -s -- --version 1.0.0
```
默认安装路径：
*   macOS / Linux: `~/.local/bin/chapose`
*   Windows (Git Bash / MSYS2): `~/AppData/Local/bin/chapose.exe`
安装完成后请验证：
```sh
chapose --version
```
如果安装目录尚未加入 `PATH`，脚本会输出对应的添加命令。

**macOS 平台（Homebrew 包管理器）**：
可通过自定义 Tap 仓库安装（详见 [Homebrew Tap](https://github.com/huanguan1978/homebrew-tap) 仓库说明）：
```sh
brew tap huanguan1978/tap
brew install chapose
```

**Windows 平台（winget 包管理器）**：
在 Windows 终端中运行以下命令直接安装：
```cmd
winget install gai.chapose
```

### 二进制兼容性说明
*   发布的二进制文件由 CI 针对特定操作系统与 CPU 目标构建。
*   即使操作系统名称和架构名称匹配，下载后的二进制仍可能因系统版本过旧而无法运行。
*   例如，某些 macOS 二进制可能要求比当前设备更高版本的 macOS 运行时。

### 从源码编译并安装
如果发布的二进制包无法在您的设备上运行，可以改为从源码构建并自行安装 `chapose`。

以下示例适用于 macOS/Linux：

```sh
git clone https://github.com/huanguan1978/chacrypt.git
cd chacrypt/chapose
dart pub get
dart compile exe bin/chapose.dart -o chapose
mkdir -p "$HOME/.local/bin"
cp ./chapose "$HOME/.local/bin/chapose"
chmod 755 "$HOME/.local/bin/chapose"
```
随后执行：
```sh
chapose --version
```

---

## ✨ 核心特性

*   **工业级加密标准**：基于 AEAD（带关联数据的认证加密）模式，在提供卓越加密性能的同时，确保数据在传输与存储中的绝对机密性。
*   **强力完整性保护**：集成 Poly1305 认证机制。一旦密文遭遇位翻转或恶意篡改，解密操作将立即失效并报错，彻底防御篡改攻击。
*   **零泄露流式架构**：采用纯流式（Streaming）处理技术，支持 GB 级甚至 TB 级超大文件。处理过程中**无需载入全量数据**，亦**不产生临时明文交换文件**，确保物理磁盘层面的数据纯净。
*   **极致跨平台性能**：ChaCha20 算法在非 AES-NI 指令集的硬件（如 ARM、移动设备、老旧服务器及容器环境）中表现尤为出色，提供极高的吞吐量与稳定性。

---

## 🛠 核心功能指南

Chapose 的核心功能由三个子命令构成。**这三个子命令都与密钥/密码息息相关，均支持在命令行中通过参数 `-p` (密码) 或 `-k` (密钥文件) 进行配置。**

### 1. `keyfile` - 密钥管理
生成高熵随机密钥文件，作为后续加解密操作的唯一信任凭证。您可以通过 `-p` 参数为其设置保护密码，或使用 `-o` 指定输出位置。

*   **默认快速生成**：在当前目录生成默认的未加密密钥文件 `chapose.key`。
    ```bash
    chapose keyfile
    ```
*   **高安全性自定义生成**：为密钥文件设置保护密码，指定保存到受保护的秘密目录，并强制覆盖同名文件。
    ```bash
    chapose keyfile -p "YourStrongPassword#1" -o "~/.secrets/chapose.key" -w
    ```

### 2. `encrypt` - 敏感数据加固
将明文文件转换为高强度 `.cha` 密文。加密时必须提供密钥，您可以通过 `-p` 指定密码、`-k` 指定密钥文件，或者使用环境变量。

*   **无感极简模式（环境变量驱动）**：
    如果在命令行中**不指定** `-p` 或 `-k` 参数，Chapose 将默认从环境变量 `CHAPOSE_KEYFILE` 指向的路径（例如 `~/.secrets/chapose.key`）自动读取密钥进行加密。
    ```bash
    chapose encrypt sensitive.db
    ```
*   **使用密钥文件加密**：手动指定密钥文件路径。加密成功后自动物理销毁明文文件，并强制覆盖同名输出。
    ```bash
    chapose encrypt raw_data.log -k ~/.secrets/chapose.key -D -w
    ```
*   **使用密码直接加密**：直接使用密码文本（系统会自动将其转换为加密密钥），并将生成的密文保存至指定的安全保险箱目录中。
    ```bash
    chapose encrypt client_info.csv -p "YourStrongPassword#1" -d ./vault/
    ```

### 3. `decrypt` - 安全数据还原
验证并解密 `.cha` 密文文件，将其还原为原始明文。解密时同样可以通过 `-p`、`-k` 参数或环境变量来提供解密钥匙。

*   **无感极简解密（环境变量驱动）**：
    如果在命令行中**不指定** `-p` 或 `-k` 参数，将自动读取并使用环境变量 `CHAPOSE_KEYFILE` 指定的密钥文件进行解密。
    ```bash
    chapose decrypt sensitive.db.cha
    ```
*   **使用密钥文件解密**：使用先前生成并存放于受保护目录的密钥文件进行解密，并还原密文到当前工作目录下。
    ```bash
    chapose decrypt database.tgz.cha -k ~/.secrets/chapose.key
    ```
*   **使用密码直接解密**：提供与加密时相匹配的密码，在还原出明文文件后，自动物理删除原 `.cha` 密文。
    ```bash
    chapose decrypt config.ini.cha -p "YourStrongPassword#1" -D
    ```

---

## 🌟 最佳实践：实现“无感加密”

对于需要高频处理敏感数据的场景，通过配置全局环境变量 `CHAPOSE_KEYFILE`，可以实现无参数的极简调用：

1.  **安全存储**：将密钥文件存放于受保护目录并限制访问权限。
    *   **Unix/macOS**: `chmod 400 ~/.secrets/chapose.key`
    *   **Windows**: 建议存放在用户目录下的隐藏文件夹（如 `%USERPROFILE%\.secrets\`）。

2.  **配置变量**：
    *   **Unix/macOS (Zsh/Bash)**: 在 `~/.zshrc` 或 `~/.bashrc` 中添加：
      `export CHAPOSE_KEYFILE="$HOME/.secrets/chapose.key"`
    *   **Windows (PowerShell)**: 执行以下命令进行持久化设置：
      `[Environment]::SetEnvironmentVariable("CHAPOSE_KEYFILE", "$HOME\.secrets\chapose.key", "User")`
    *   **Windows (CMD)**: 执行命令：
      `setx CHAPOSE_KEYFILE "%USERPROFILE%\.secrets\chapose.key"`

3.  **无感操作**：完成配置并重启终端后，执行命令无需再手动指定密钥或密码参数：
    *   加密：`chapose encrypt target.data`
    *   解密：`chapose decrypt target.data.cha`

---

## 🛠 开发者生态：与 `ft:filetools` 协同增强

**Chapose** 专注于极致的单文件安全。为了满足复杂生产环境下的目录打包、物理级销毁及跨平台任务自动化需求，推荐配合使用开发者另一款力作：

#### **[ft:filetools (ft)](https://github.com/huanguan1978/ft)**
> **特点**：基于流式架构，集成归档、工业级擦除、智能过滤等功能。支持通过 **YAML 配置文件** 对复杂的 CLI 操作进行任务编排（Orchestration）。

#### 场景模拟与实操：数据安全导出流水线

我们可以通过在本机创建测试数据，真实地模拟一次“数据归档打包 -> 密文加密 -> 物理级原始明文数据擦除”的自动化安全导出流程。

##### 步骤 1：准备测试环境与模拟敏感数据
在终端中执行以下命令，快速构建模拟工作区：
```bash
# 1. 创建测试目录与敏感明文数据文件夹
mkdir -p ./scratch_test/export_data

# 2. 生成模拟的 SQL 敏感数据文件
echo "CREATE TABLE users (id INT, name VARCHAR(50));" > ./scratch_test/export_data/user_db.sql
echo "CREATE TABLE orders (id INT, amount DECIMAL);" > ./scratch_test/export_data/order_db.sql

# 3. 生成安全密钥并设置环境变量（使用前文的无感加密最佳实践路径）
mkdir -p ~/.secrets
chapose keyfile -p "YourStrongPassword#1" -o ~/.secrets/chapose.key -w
export CHAPOSE_KEYFILE="$HOME/.secrets/chapose.key"
```

##### 步骤 2：创建流水线任务配置 `export_task.yaml`
在 `./scratch_test/` 目录下创建任务配置文件 `export_task.yaml`，内容如下。该配置定义了具体的作业流程：
*   **注意**：`os` 字段应根据您的系统平台设置为 `macos`、`linux` 或 `windows`。

```yaml
# ./scratch_test/export_task.yaml
name: "数据安全导出与物理销毁流水线"
os: macos       # 目标平台 (支持 macos, linux, windows)
ver: 1.0.7      # ft 版本要求
errexit: true   # 遇错立即中断退出

define:
  sql_dir: "./export_data"
  intermediate_tar: "export_bundle.tgz"

scripts:
  # 1. 归档打包所有 SQL 文件 (使用 **.sql 确保覆盖所有层级后缀文件)
  - ft archive --source $sql_dir --target $intermediate_tar --pattern="**.sql"
  
  # 2. 调用 chapose 加密归档包，并使用 -w 参数强制覆写同名密文包
  - chapose encrypt $intermediate_tar -w
  
  # 3. 物理级擦除并销毁原始 SQL 文件
  - ft wipe --source $sql_dir --pattern="**.sql" --levels=medium

  # 4. 物理级擦除并销毁中间步骤的明文归档包
  - ft wipe $intermediate_tar --levels=low
```

##### 步骤 3：一键运行流水线
在终端中进入 `./scratch_test/` 目录并运行 `ft shell` 命令执行该流水线：
```bash
cd ./scratch_test
ft shell . --config=export_task.yaml
```

##### 步骤 4：验证物理级无痕处理结果
流水线执行完毕后，检查工作区文件状态以验证安全擦除效果：
```bash
# 检查原始数据目录：此时 sql 明文文件已被物理级抹除并彻底删除（目录已空）
ls -la ./export_data

# 检查明文中间归档包：此时 export_bundle.tgz 已被彻底擦除并不复存在
ls -la export_bundle.tgz

# 检查加密结果：此时仅保留高强度加密后的密文包
ls -la export_bundle.tgz.cha
```
如果您需要还原解密，只需在当前目录下运行 `chapose decrypt export_bundle.tgz.cha` 即可使用环境变量指定的密钥进行还原。

---

## 💖 支持本项目
如果您觉得这个工具对您有所帮助，并希望它能持续改进、优化，请给予我一份支持。

*   ⭐ **点亮星标**：这是对我的莫大鼓励。您的星标能让更多人发现这个工具，也让项目在社区中获得更多认可。
*   ☕ **支持开发者 (全球)**：任何数额的支持都是对我持续投入工作的肯定。您可以通过 [GitHub Sponsors](https://github.com/sponsors/huanguan1978) 或 [Buy Me a Coffee](https://buymeacoffee.com/huanguan1978) 为我助力。
*   🐼 **国内的朋友**：也可以通过 [爱发电](https://ifdian.net/a/huangaun1978) 进行支持。

*感谢您的支持，这是让我保持专注、持续迭代项目的巨大助力；因为有你，更多人得以更快地获得这份工具带来的便利。*

---

## 💡 安全建议与性能说明

*   **安全准则**：密钥文件是解开数据的**唯一**凭证。请务必将其与密文分开存储，并建议离线备份密钥。
*   **命名策略**：Chapose 采用堆叠扩展名策略（如 `.tar.gz.cha`），旨在提供清晰的二进制格式审计链。
*   **审计友好**：所有加密行为均为显式调用，解密时的完整性校验失败将抛出明确的异常，方便集成至监控系统。

---

## 📄 .cha 文件格式定义

`.cha` 格式是由 **ChaBox** 生态系统定义的透明、高性能加密容器。它旨在提供一种基于现代 AEAD（关联数据的认证加密）原语的标准化方式。

### 🏗️ 逻辑结构
每个 `.cha` 文件都遵循严格的二进制布局：

| 偏移量 | 字段 | 大小 | 说明 |
| :--- | :--- | :--- | :--- |
| `0x00` | **Schema** | 4 字节 | 魔数 `CHA1` (版本 1)。 |
| `0x04` | **Nonce** | 12 字节 | 每个文件唯一的随机初始化向量。 |
| `0x10` | **AAD 长度** | 4 字节 | 附加认证数据的大小 ($L$)，小端序 uint32。 |
| `0x14` | **AAD 数据** | $L$ 字节 | 可选元数据（已认证但未加密）。 |
| `0x14+L` | **密文** | 可变 | 使用 ChaCha20 加密的实际数据。 |
| `EOF-16` | **认证标签** | 16 字节 | 用于完整性和真实性校验的 Poly1305 MAC 标签。 |

---

## 🛠️ SDK 调用指南 (Dart)

`chapose` 提供了简洁的 API 接口。对于开发者而言，**学习和使用 Dart 版 SDK 的最佳方式是直接查阅 `chapose` 的源代码实现**。

### 1. 核心加密/解密方法
核心逻辑封装在 `fileEncrypt` 和 `fileDecrypt` 中。

```dart
import 'dart:io';
import 'package:chapose/chapose.dart';

// key 必须是 32 字节的密钥 (建议通过 deriveKey 生成)
await fileEncrypt(key, File('plain.txt'), File('encrypted.cha'));

// 解密回原始文件
await fileDecrypt(key, File('encrypted.cha'), File('decrypted.txt'));
```

### 2. 密钥与辅助方法
*   **`deriveKey(String password)`**: 使用 SHA-256 将用户密码转换为标准 32 字节密钥。
*   **`generatePassword([int length])`**: 生成高强度安全密码。
*   **`isPasswordSecure(String password)`**: 校验密码强度。
*   **`isChaFile(File file)`**：判断文件是否为 Chapose `.cha` 加密文件。先检查扩展名，如果不匹配再读取前 4 字节魔术数，确认前三个字节为 `CHA`，第四个字符是数字。

---

*如需查看完整命令行参数，请运行 `chapose help` 或 `chapose help <command>`。*
