# ChaPose Installation Guide

Welcome to ChaPose! You can install it using one of the following methods based on your operating system.

### 1. Shell Script Installation (Recommended)
Suitable for macOS, Linux, and Windows (Git Bash / MSYS2). Please ensure that `curl` is installed on your system.

```bash
curl -fsSL https://raw.githubusercontent.com/huanguan1978/chacrypt/main/chapose/install.sh | sh
```

### 2. macOS Installation (Homebrew / MacPorts)
We maintain a custom tap repository that includes `chapose`, `ft:filetools`, and other tools I have developed.

👉 **Visit the custom tap repository for detailed instructions**: [huanguan1978/homebrew-tap](https://github.com/huanguan1978/homebrew-tap)

*   **Homebrew**:
    ```bash
    brew tap huanguan1978/tap
    brew install chapose
    ```
*   **MacPorts**:
    Please refer to the instructions provided in the custom tap repository linked above.

### 3. Manual Download & Installation
If you need binaries for specific architectures or prefer manual management, please visit our GitHub Release page:

👉 [GitHub Release Page (chapose-v1.0.0)](https://github.com/huanguan1978/chacrypt/releases/tag/chapose-v1.0.0)

On this page, you can find compressed archives and checksum files for various platforms (macOS, Linux, Windows) and CPU architectures (x64, arm64, etc.).

### Verify Installation
After installation, run the following command in your terminal to verify:

```bash
chapose --version
```
If the version number is displayed, the installation was successful.
