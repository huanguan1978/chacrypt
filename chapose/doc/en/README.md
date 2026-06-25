# Chapose: Modern High-Performance File Security Tool

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

**Chapose** is a high-performance file encryption utility powered by the industrial-grade **ChaCha20-Poly1305** algorithm, engineered for both data confidentiality and integrity. It handles files of any size with minimal memory overhead, making it the ideal choice for privacy protection, secure key distribution in production environments, and sensitive data workflows.

---

## ✨ Core Features

*   **Industrial-Grade AEAD Encryption**: Built on Authenticated Encryption with Associated Data (AEAD) mode, delivering exceptional performance while guaranteeing absolute confidentiality for data in transit and at rest.
*   **Robust Integrity Protection**: Integrated Poly1305 authentication. Any bit-flipping or malicious tampering with the ciphertext triggers an immediate decryption failure, effectively neutralizing tampering attacks.
*   **Zero-Leakage Streaming Architecture**: Employs pure streaming processing that supports GB or even TB-scale files. It operates **without loading the full dataset into memory** and **never generates plaintext swap files**, ensuring data purity at the physical disk level.
*   **Optimized Cross-Platform Performance**: The ChaCha20 algorithm excels on hardware without AES-NI instruction sets (e.g., ARM, mobile devices, legacy servers, and containerized environments), delivering consistently high throughput and stability.

---

## 🛠 Core Functional Guide

Chapose's core functionality is built around three subcommands. **All three subcommands are key- or password-dependent, and each supports configuration via the `-p` (password) or `-k` (keyfile) flags on the command line.**

### 1. `keyfile` - Key Management
Generates a high-entropy random keyfile as the sole trusted credential for all subsequent encryption and decryption operations. You can protect it with a master password via `-p` or specify a custom output path with `-o`.

*   **Quick Start**: Generate the default unencrypted keyfile `chapose.key` in the current directory.
    ```bash
    chapose keyfile
    ```
*   **High-Security Custom Generation**: Protect the keyfile with a password, save it to a secure secret directory, and force-overwrite any existing file at that path.
    ```bash
    chapose keyfile -p "YourStrongPassword#1" -o "~/.secrets/chapose.key" -w
    ```

### 2. `encrypt` - Hardening Sensitive Data
Converts plaintext files into high-strength `.cha` ciphertext. A key must be provided at encryption time — via `-p` for a password, `-k` for a keyfile, or via an environment variable.

*   **Seamless Mode (Environment Variable-Driven)**:
    When neither `-p` nor `-k` is specified on the command line, Chapose automatically reads the key from the path pointed to by the `CHAPOSE_KEYFILE` environment variable (e.g., `~/.secrets/chapose.key`) and proceeds with encryption.
    ```bash
    chapose encrypt sensitive.db
    ```
*   **Encrypt with a Keyfile**: Manually specify the keyfile path. After a successful encryption, the original plaintext is automatically and securely wiped, and any existing output file at the destination is force-overwritten.
    ```bash
    chapose encrypt raw_data.log -k ~/.secrets/chapose.key -D -w
    ```
*   **Encrypt with a Password**: Encrypt using a password directly (the system derives the encryption key automatically) and save the resulting ciphertext to a designated secure vault directory.
    ```bash
    chapose encrypt client_info.csv -p "YourStrongPassword#1" -d ./vault/
    ```

### 3. `decrypt` - Secure Data Restoration
Verifies and decrypts `.cha` ciphertext files, restoring them to their original plaintext. Decryption likewise accepts a key via `-p`, `-k`, or an environment variable.

*   **Seamless Mode (Environment Variable-Driven)**:
    When neither `-p` nor `-k` is specified on the command line, the key is automatically read from the path specified by `CHAPOSE_KEYFILE` and used for decryption.
    ```bash
    chapose decrypt sensitive.db.cha
    ```
*   **Decrypt with a Keyfile**: Use the keyfile previously generated and stored in a protected directory to decrypt and restore the ciphertext to the current working directory.
    ```bash
    chapose decrypt database.tgz.cha -k ~/.secrets/chapose.key
    ```
*   **Decrypt with a Password**: Provide the password used during encryption. After the plaintext has been successfully restored, the original `.cha` ciphertext is automatically and securely deleted.
    ```bash
    chapose decrypt config.ini.cha -p "YourStrongPassword#1" -D
    ```

---

## 🌟 Best Practices: Seamless Encryption

For scenarios requiring frequent handling of sensitive data, configure the global `CHAPOSE_KEYFILE` environment variable to enable fully parameter-free command execution:

1.  **Secure Storage**: Store the keyfile in a protected directory and restrict its access permissions.
    *   **Unix/macOS**: `chmod 400 ~/.secrets/chapose.key`
    *   **Windows**: Recommended to store in a hidden folder within the user directory (e.g., `%USERPROFILE%\.secrets\`).

2.  **Configure the Variable**:
    *   **Unix/macOS (Zsh/Bash)**: Add the following to `~/.zshrc` or `~/.bashrc`:
      `export CHAPOSE_KEYFILE="$HOME/.secrets/chapose.key"`
    *   **Windows (PowerShell)**: Run the following for persistent configuration:
      `[Environment]::SetEnvironmentVariable("CHAPOSE_KEYFILE", "$HOME\.secrets\chapose.key", "User")`
    *   **Windows (CMD)**: Run the command:
      `setx CHAPOSE_KEYFILE "%USERPROFILE%\.secrets\chapose.key"`

3.  **Seamless Operation**: Once configured and the terminal is restarted, commands require no manual key or password flags:
    *   Encrypt: `chapose encrypt target.data`
    *   Decrypt: `chapose decrypt target.data.cha`

---

## 🛠 Developer Ecosystem: Enhanced Synergy with `ft:filetools`

**Chapose** focuses on extreme single-file security. For complex production requirements — directory archiving, physical-grade wiping, and cross-platform task automation — we recommend pairing it with another tool from the same developer:

#### **[ft:filetools (ft)](https://github.com/huanguan1978/ft)**
> **Features**: A streaming-first architecture with integrated archiving, industrial-grade secure wiping, and smart filtering. Supports complex CLI task orchestration via **YAML configuration files**.

#### Scenario Walkthrough: Secure Data Export Pipeline

The following is a real, runnable simulation of a fully automated **"Archive → Encrypt → Physical Wipe"** secure export workflow using local test data.

##### Step 1: Prepare the Test Environment and Mock Sensitive Data
Run the following commands in your terminal to quickly set up the mock workspace:
```bash
# 1. Create the test directory and sensitive plaintext data folder
mkdir -p ./scratch_test/export_data

# 2. Generate mock SQL sensitive data files
echo "CREATE TABLE users (id INT, name VARCHAR(50));" > ./scratch_test/export_data/user_db.sql
echo "CREATE TABLE orders (id INT, amount DECIMAL);" > ./scratch_test/export_data/order_db.sql

# 3. Generate a secure keyfile and configure the environment variable
#    (uses the recommended seamless-encryption path from best practices above)
mkdir -p ~/.secrets
chapose keyfile -p "YourStrongPassword#1" -o ~/.secrets/chapose.key -w
export CHAPOSE_KEYFILE="$HOME/.secrets/chapose.key"
```

##### Step 2: Create the Pipeline Task Config `export_task.yaml`
Create the following task configuration file at `./scratch_test/export_task.yaml`. This config defines the full job workflow:
*   **Note**: Set the `os` field to match your system platform: `macos`, `linux`, or `windows`.

```yaml
# ./scratch_test/export_task.yaml
name: "Secure Data Export & Physical Destruction Pipeline"
os: macos       # Target platform (supports macos, linux, windows)
ver: 1.0.7      # Minimum ft version requirement
errexit: true   # Abort immediately on any error

define:
  sql_dir: "./export_data"
  intermediate_tar: "export_bundle.tgz"

scripts:
  # 1. Archive all SQL files (**.sql matches files at all directory levels)
  - ft archive --source $sql_dir --target $intermediate_tar --pattern="**.sql"

  # 2. Encrypt the archive with Chapose; -w flag force-overwrites any existing output
  - chapose encrypt $intermediate_tar -w

  # 3. Physically wipe and destroy the original SQL source files
  - ft wipe --source $sql_dir --pattern="**.sql" --levels=medium

  # 4. Physically wipe and destroy the intermediate plaintext archive
  - ft wipe $intermediate_tar --levels=low
```

##### Step 3: Run the Pipeline with a Single Command
Navigate to the `./scratch_test/` directory in your terminal and execute the pipeline via `ft shell`:
```bash
cd ./scratch_test
ft shell . --config=export_task.yaml
```

##### Step 4: Verify the Results
Once the pipeline completes, inspect the workspace to confirm the secure wipe:
```bash
# Check the source data directory: the SQL plaintext files are physically wiped and gone (directory is empty)
ls -la ./export_data

# Check for the intermediate archive: export_bundle.tgz has been wiped and no longer exists
ls -la export_bundle.tgz

# Check the encrypted output: only the high-strength ciphertext bundle remains
ls -la export_bundle.tgz.cha
```
To restore and decrypt, simply run `chapose decrypt export_bundle.tgz.cha` in the same directory — the key specified by your environment variable will be used automatically.

---

## 💖 Support the Project
If this tool has been helpful and you'd like to see it continue to improve, please consider showing your support.

*   ⭐ **Star the Repo**: This is a great encouragement. Your stars help more people discover this tool and give the project greater visibility in the community.
*   ☕ **Support the Developer (Global)**: Any amount of support is a meaningful affirmation of my continued work. You can contribute via [GitHub Sponsors](https://github.com/sponsors/huanguan1978) or [Buy Me a Coffee](https://buymeacoffee.com/huanguan1978).
*   🐼 **Support via Ifdian (Mainland China)**: Users in China can also show support via [Ifdian (爱发电)](https://ifdian.net/a/huangaun1978).

*Thank you for your support — it is a tremendous motivator to stay focused and keep iterating on this project. Because of your backing, more people can benefit from these tools sooner.*

---

## 💡 Security & Performance Notes

*   **Security Rule**: The keyfile is the **only** credential that can unlock your data. Always store it separately from the ciphertext and maintain an offline backup.
*   **Naming Strategy**: Chapose uses a stacked extension strategy (e.g., `.tar.gz.cha`) to provide a clear, human-readable audit trail of the binary format chain.
*   **Audit Friendly**: All encryption actions are explicit. Integrity check failures during decryption throw clear exceptions, making integration with monitoring systems straightforward.

---

## 📄 .cha File Format Definition

The `.cha` format is a transparent, high-performance encryption container defined by the **ChaBox** ecosystem. It is designed to provide a standardized method for storing and transmitting sensitive data using modern AEAD primitives.

### 🏗️ Logical Structure
Every `.cha` file follows a strict binary layout:

| Offset | Field | Size | Description |
| :--- | :--- | :--- | :--- |
| `0x00` | **Schema** | 4 Bytes | Magic bytes `CHA1` (Version 1). |
| `0x04` | **Nonce** | 12 Bytes | Unique per-file random initialization vector. |
| `0x10` | **AAD Length** | 4 Bytes | Size of Additional Authenticated Data ($L$), little-endian uint32. |
| `0x14` | **AAD Data** | $L$ Bytes | Optional metadata (authenticated but not encrypted). |
| `0x14+L` | **Ciphertext** | Variable | The actual data encrypted with ChaCha20. |
| `EOF-16` | **Auth Tag** | 16 Bytes | Poly1305 MAC tag for integrity and authenticity verification. |

---

## 🛠️ SDK Usage Guide (Dart)

`chapose` exposes a clean API for developers. **The best way to learn and use the Dart SDK is to read the `chapose` source code directly**, which serves as the authoritative reference implementation.

### 1. Core Encryption / Decryption
The core logic is encapsulated in `fileEncrypt` and `fileDecrypt`.

```dart
import 'dart:io';
import 'package:chapose/chapose.dart';

// key must be a 32-byte secret (recommended: use deriveKey to generate it)
await fileEncrypt(key, File('plain.txt'), File('encrypted.cha'));

// Decrypt back to the original file
await fileDecrypt(key, File('encrypted.cha'), File('decrypted.txt'));
```

### 2. Key & Utility Methods
*   **`deriveKey(String password)`**: Converts a user password into a standard 32-byte key using SHA-256.
*   **`generatePassword([int length])`**: Generates a high-entropy secure password.
*   **`isPasswordSecure(String password)`**: Validates password strength and complexity.
*   **`isChaFile(File file)`**: Returns `true` when the file is a Chapose `.cha` encrypted file. It first checks the extension, then verifies the header magic bytes `CHA` followed by a digit if needed.

---

*For full command-line argument reference, run `chapose help` or `chapose help <command>`.*
