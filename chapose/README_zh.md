# Chapose: 高性能文件安全守护者 (CLI)

**Chapose** 是一款基于 **ChaCha20-Poly1305** AEAD 算法的专业级命令行工具。作为 **ChaCrypt** 生态系统的核心组件，它专为高性能处理、自动化流转及强力安全加固而生。

## 快速安装

使用发布的二进制包并安装到本地默认路径：

```sh
curl -fsSL https://raw.githubusercontent.com/huanguan1978/chacrypt/main/chapose/install.sh | sh -s -- --version 1.0.0
```

安装完成后，请执行：

```sh
chapose --version
```

如需查看包管理器安装方式（macOS Homebrew / Windows winget）、二进制兼容性说明、源码编译及排错指引，请阅读完整文档 [./doc/zh/README.md](./doc/zh/README.md)。

---

## 📖 文档与指南

详细的技术文档和参考指南已按类别整理如下：

### 🎮 面向用户 (CLI 参考)
- [**命令行使用指南**](./doc/zh/README.md#-核心功能指南) - `keyfile`, `encrypt`, `decrypt` 命令详解。
- [**最佳实践**](./doc/zh/README.md#🌟-最佳实践实现无感加密) - 实现“无感加密”的自动化配置。

### 💻 面向开发者 (SDK 与 格式)
- [**SDK 调用指南 (Dart)**](./doc/zh/README.md#️-sdk-调用指南-dart) - 在您的应用中集成 `.cha` 加密。
- [**.cha 文件格式规范**](./doc/zh/README.md#-cha-文件格式定义) - 二进制结构与算法细节。

---

## 🌍 多语言版本

- [**简体中文文档 (完整版)**](./doc/zh/README.md)
- [**English Documentation (Full)**](./doc/en/README.md)

---

## 💖 支持本项目
如果您觉得这个工具对您有所帮助，并希望它能持续改进、优化，请给予我一份支持。

*   ⭐ **点亮星标**：这是对我的莫大鼓励。您的星标能让更多人发现这个工具，也让项目在社区中获得更多认可。
*   ☕ **支持开发者 (全球)**：任何数额的支持都是对我持续投入工作的肯定。您可以通过 [GitHub Sponsors](https://github.com/sponsors/huanguan1978) 或 [Buy Me a Coffee](https://buymeacoffee.com/huanguan1978) 为我助力。
*   🐼 **国内的朋友**：也可以通过 [爱发电](https://ifdian.net/a/huangaun1978) 进行支持。

*感谢您的支持，这是让我保持专注、持续迭代项目的巨大助力；因为有你，更多人得以更快地获得这份工具带来的便利。*
