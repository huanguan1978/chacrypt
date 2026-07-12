# New in the ChaBox Ecosystem: Chapose, an Open-Source Cross-Platform CLI File Encryption Tool, is Now Released!

Hello everyone! We are thrilled to announce that the ChaBox security toolkit has a powerful new member: **Chapose**.

## What is Chapose?
Chapose is an open-source command-line interface (CLI) tool based on the industrial-grade **ChaCha20-Poly1305** algorithm, designed for high-performance file security hardening. It provides confidentiality and integrity protection for sensitive data of any size with minimal memory overhead.

## Why is it useful?
In daily development and operations, we often face risks when storing and transmitting sensitive data (such as configuration files, database backups, private keys, etc.). Traditional encryption software is often bloated and difficult to integrate into automated scripts.
Chapose's core value lies in:
*   **Seamless Integration**: As a CLI tool, it can be easily embedded into any shell script or CI/CD pipeline.
*   **Extreme Performance**: Using a streaming architecture, it processes GB or even TB-sized files without loading the entire dataset into memory, ensuring blazing-fast speeds.
*   **Security Compliance**: Integrated with the Poly1305 authentication mechanism, it ensures that data remains untampered with during transmission and storage.

## Automation: Chapose + ft:filetools
Chapose focuses on high-strength encryption for single files. If you need to handle more complex scenarios (e.g., archiving -> encryption -> physical destruction of original plaintext), we recommend using it in conjunction with **ft:filetools**.
With `ft`'s task orchestration capabilities, you can easily build a "secure data export pipeline." Please refer to the GitHub repository documentation for specific configuration methods and scenario simulations.

## How to Get and Install
You can visit our GitHub repository for detailed documentation and usage guides:
👉 [Chapose GitHub Repository](https://github.com/huanguan1978/chacrypt/tree/main/chapose)

### Installation
*   **General Installation (macOS / Linux / Windows Git Bash)**:
    Use the following command to install quickly:
    `curl -fsSL https://raw.githubusercontent.com/huanguan1978/chacrypt/main/chapose/install.sh | sh`

*   **macOS Exclusive (Homebrew / MacPorts)**:
    We provide a dedicated Homebrew/MacPorts tap to help you manage Chapose and `ft:filetools`:
    👉 [Homebrew/MacPorts Tap](https://github.com/huanguan1978/homebrew-tap)

Welcome to download and try it out, and start your data security journey!
