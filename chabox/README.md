# ChaBox - Offline Secure Vault

[简体中文](./README_zh.md) | **English**

**ChaBox** is a high-performance file security workstation built on the industry-grade **ChaCha20-Poly1305** authenticated encryption standard.

### Why You Still Need ChaBox in the Internet Age?

In today's hyper-connected world, data travels at unprecedented speeds. However, travel means exposure. ChaBox focuses on protecting data in two high-risk states:

1.  **In Transit**: Instant messengers, cloud drives, and email are essentially "insecure highways." ChaBox performs local hardening before data ever leaves your device, ensuring that even if the network is hijacked or the cloud leaks, your privacy remains rock-solid.
2.  **In Offline Storage**: Sensitive assets on local disks, NAS, or mobile media are at risk of physical loss or unauthorized access. ChaBox establishes "cold protection" for these assets, ensuring that data sovereignty stays in your hands.

**The core philosophy of ChaBox is: Before data steps onto the Internet, reinforce it locally with absolute physical isolation.** It is not just an encryption tool; it is your "offline sovereignty fortress" in digital survival.

---

## ✨ Key Advantages

*   **Five Atomic Tools (Batch-Enabled)**:
    1.  **Batch Archive** & **Batch Unarchive**: High-efficiency structured data packaging.
    2.  **Batch Encrypt** & **Batch Decrypt**: Industrial-grade protection based on ChaCha20-Poly1305.
    3.  **Digital Shredder (Wipe)**: Physical-grade secure erasure to completely destroy original sensitive files.

*   **Secure Notes (Core Function: Immersive Writing + Security Enhancements)**:
    *   **Immersive Markdown Writing and Preview**: Supports real-time autosave and preview, balancing writing efficiency with a comfortable reading experience.
    *   **Variable-Based References**: Supports built-in app variables and custom placeholders to centrally manage image paths and web links; during cross-platform migration, content can be adapted quickly by updating variables only.
    *   **Encrypted Embedded Images**: Supports encrypted images from both local files and remote HTTP sources, enabling unified encrypted protection for note text and attached images.

*   **Native File System Sovereignty (Manage Encrypted Assets Like Ordinary Files)**:
    Unlike many vault applications that "swallow" files into an opaque database, ChaBox insists on organizing assets using **native folders**, returning full control to you.
    *   **Transparent File Storage**: Encrypted files maintain a clear directory structure. You can move, back up, or sync them directly using your device's built-in "File Manager" with zero learning curve.
    *   **File Classification Freedom**: Folders are the most natural "classifiers." You can build multi-level directories based on your habits (e.g., `Finance/2024/Invoices`), keeping your assets organized instead of lumping them into a single, unmanageable "data pool."
    *   **File Mobility Freedom**: Completely eliminate the risk of "data hijacking" by software. Since assets aren't locked in a single database, your data remains in a "ready-to-migrate" state across devices or tools, achieving a perfect balance of security and freedom.

*   **Memory-Level Active Defense**:
    *   **Multi-Dimensional Locking**: Integrated App Lock and Idle Auto-Lock.
    *   **Privacy Guard**: Full-platform Anti-Screenshot, **Full-Platform Anti-Recording** (*Note: Refers to blocking internal recording by other software on the same device*), and Screen Masking (blurring app snapshot during task switching).
    *   **Clipboard Security Guard**: Specifically for "Secure Diary" and "Password Text" modules, it provides scheduled automatic clipboard clearing, blocking core secrets from lingering in the system clipboard.
    *   **RAM-Only Preview**: Adheres to the "RAM preview" principle, preventing plaintext data from leaving any physical debris on the disk.

*   **Full-Context Security Empowerment (100% Offline)**:
    *   **Multilingual Matrix**: Deeply adapted for English, Chinese (Simplified/Traditional), Spanish, Japanese, German, French, Portuguese, Korean, and Russian, ensuring users worldwide can master privacy sovereignty without barriers.
    *   **Offline Security Knowledge Base (Daily Briefing)**: A built-in multilingual security encyclopedia that rotates through app tips, physical security advice, cryptographic common sense, and security alerts—all without an internet connection, progressively enhancing user security awareness.

*   **Industrial-Grade Algorithmic Foundation**: Utilizes ChaCha20-Poly1305 (AEAD), balancing extreme performance with robust integrity verification. If data suffers tampering, decryption fails immediately.

*   **Visual Audit Chain**: Intuitive stacked extensions (e.g., `.tar.gz.cha`) clearly display the data processing chain, ensuring the process is transparent and professional.

---

## 📖 Documentation

The manuals are categorized by language and scenario. Click the links below to navigate:

| Scenario | Chinese Docs (中文) | English Docs |
| :--- | :--- | :--- |
| **Quick Start** | [Two Minutes to Privacy](./doc/zh/start.md) | [Quick Start](./doc/en/start.md) |
| **Deep Dive** | [Atomic Tools & Path Management](./doc/zh/guide.md) | [Advanced Tools](./doc/en/guide.md) |
| **Security Settings** | [Configuring Your Private Workstation](./doc/zh/settings.md) | [Configuration](./doc/en/settings.md) |
| **FAQ** | [FAQ & Security Principles](./doc/zh/faq.md) | [FAQ](./doc/en/faq.md) |

---

## 🛠 Developer Guide

This project is developed using the Flutter framework and follows standard Dart/Flutter programming practices.

### Architectural Philosophy (Scope-Driven)
We follow a **"Scope-Driven"** design. Every module (like `home` or `action`) is self-contained under `page/<scope>/`, embodying the MVC pattern (C: Root controller, V: layout/widget, M: helper/utils).

*   **Architecture Guide**: 
    * [English](./DESIGN.md) | [中文版](./DESIGN_zh.md)

### AI-Assisted Coding
We welcome AI assistance, provided it adheres to our architectural contract:
1. **Architectural Consistency**: Generated code must strictly follow our "Scope-Driven" architecture.
2. **Documentation**: Business methods (`helper/`) and `Public APIs` must contain English comments explaining the *design intent*.
3. **Accountability**: Developers are responsible for reviewing AI-generated code, verifying it through testing, and tagging it (`[AI Generated]` or `[AI Assisted]`) in PRs.

### Contribution Rules
1. **Free Customization**: Fork and adapt to your workflow.
2. **Pull Requests**: Welcomed if the work benefits the security community.
3. **Quality Standard**: `flutter analyze` must pass.
4. **Dependency Policy**: Strictly minimal dependencies.

### Build Commands
```bash
flutter pub get   # Get dependencies
flutter run       # Run development version
```

---

## 💖 Support the Project
If you find this tool helpful and would like to see it continue to improve and evolve, please consider showing your support.

*   ⭐ **Star the Repo**: This is a great encouragement. Your stars help more people discover this tool and gain more recognition in the community.
*   ☕ **Support the Developer (Global)**: Any contribution, however small, is a huge affirmation of my work. You can support via [GitHub Sponsors](https://github.com/sponsors/huanguan1978) or [Buy Me a Coffee](https://buymeacoffee.com/huanguan1978).
*   🐼 **Support via Ifdian (Mainland China)**: Users in China can also show support via [Ifdian](https://ifdian.net/a/huangaun1978).

*Thank you for your support, which is a vital boost that keeps me focused on the project's continuous iteration; because of you, more people can benefit from this tool much sooner.*

---

## ⚖️ License & Compliance

*   **Source Code License**: The source code is released under the [PolyForm Noncommercial 1.0.0](./LICENSE) license. Users are encouraged to build and adapt the software for personal use.
*   **Binary Distribution Policy**: To ensure the integrity and security of our software, official pre-compiled binaries are distributed exclusively through authorized channels. This centralized approach mitigates the risk of malicious code injection and ensures the authenticity of the software source. Please note that commercial use of the software must strictly adhere to the license terms.
*   **End-User License Agreement (EULA)**: Official pre-compiled binaries are subject to our [End-User License Agreement (EULA)](EULA.md), which outlines privacy commitments (including our zero-data-collection policy) and prohibitions against reverse engineering. Please review this agreement before installation.
*   **Third-Party Notices**: This software incorporates various open-source dependencies. For a detailed list and their respective license disclosures, please refer to the [Third-Party Notices (THIRD-PARTY-NOTICES_zh.md)](THIRD-PARTY-NOTICES.md).
