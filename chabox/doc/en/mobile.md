# ChaBox Mobile (iOS / Android) Best Practices Guide

Welcome to the mobile world of ChaBox! Whether you are an exclusive mobile user or a power user coordinating cross-platform privacy workflows, this guide will help you master the underlying security architecture of mobile operating systems and provide you with a smooth, efficient "secure data flow" routine.

---

## 🛡️ 1. Origins and Positioning: ChaBox in the ChaCrypt Ecosystem

To make the most of your mobile app, let's understand where it fits within the broader ChaCrypt privacy ecosystem:

*   **ChaPose (The Headless Companion - CLI)**: A pure command-line interface (CLI) encryption utility. It has no graphical interface and is designed for automated scripts, cron backups, and server-side processing.
*   **ChaBox (The Secure Workstation - GUI)**: A visual app built on top of the same cryptographic core as `ChaPose`, introducing features like **one-click encryption/decryption, batch archiving, digital shredding (Secure Erase), and Secure Notes**.
*   **Cross-Platform Interoperability**: Regardless of the platform (CLI, desktop, or mobile), ChaBox utilizes the industrial-grade **ChaCha20-Poly1305** standard with a unified `.cha` data container. An archive encrypted on your PC can be seamlessly decrypted on your mobile device (and vice versa) simply by using the same security password.

---

## 📦 2. Core Philosophy: 100% Offline with Absolute Sandbox Sovereignty

ChaBox Mobile is a **local-first app prioritizing user data sovereignty and privacy**:
*   **No Network, No Ads, No Data Harvesting**: It operates with zero cloud servers, requires no registration, and keeps all passwords and files locally on your physical hardware.
*   **Default Sandboxed Storage**: By default, all encrypted assets and Secure Notes are stored inside the highly secure "App Sandbox," completely isolated from other applications and the host OS.

---

## 🔒 3. Why Mobile Needs a "Best Practice"? (Sandbox & Copy-on-Read)

Mobile operating systems (un-jailbroken/non-rooted iOS and Android) enforce strict security barriers. Understanding the following two concepts will help you avoid confusion:

### 3.1 Strict App Sandboxing
The operating system confines each application to its own isolated "sandbox." ChaBox cannot freely access or modify files belonging to other apps or the system.
*   **Impact on "Secure Erase"**: Because of this boundary, ChaBox's Secure Erase tool **can only physically shred files located inside its own App Sandbox**. It cannot overwrite or wipe files residing in your system photos or external Downloads folder.

### 3.2 The Shadow Mechanism: "Copy-on-Read"
When you tap "Add File" and select an image from your system gallery, the OS—to safeguard the original asset—**does not hand over the original file. Instead, it makes a copy of the file on the fly and places this duplicate inside the ChaBox sandbox for the app to read.**
*   **Physical Consequence**: ChaBox operates entirely on this duplicate "shadow file." Any encryption, modification, or erasure you perform inside ChaBox **leaves the original plaintext file in your system gallery or external folders completely untouched**.

---

## 🚀 4. Mobile Home Screen: Convenient One-Click Encryption in Practice

On mobile, our most frequent workflow involves encrypting external files and decrypting secure packages. Because of the "Copy-on-Read" mechanism, we must pull files into the sandbox for one-click operations.

### 4.1 Importing and Encrypting External Files (Non-Destructive)
When you want to secure an ID photo from your gallery or a sensitive document from your downloads:
1.  **Trigger the Selector**: Tap the dropdown menu on the left side of the "Source Path" input on the home screen.
2.  **Choose Import Type**:
    *   Select **`pick file` (Select File)**: Opens the native OS file picker to securely **copy-read** a single file (currently supports single file selection only; multi-select is not supported).
    *   Select **`pick folder` (Select Folder)**: Opens the directory picker to **copy-read** an entire folder.
3.  **One-Click Intelligent Encryption**: ChaBox instantly detects that the imported item is plaintext. The main button automatically changes to **"Encrypt Selected"**. Tap it, enter your password, and ChaBox will transform the item into a secure `.cha` (or `.tar.gz.cha`) container inside the sandbox.
4.  **Critical Security Action**: Because of the "Copy-on-Read" mechanism, **the original plaintext file remains intact in its external location**. To prevent accidental leakage, we highly recommend verifying the encrypted container in ChaBox first, then manually deleting the original plaintext file from your system gallery or Files app.

### 4.2 Restoring and Decrypting Packages
To restore a `.cha` file back to plaintext so it can be opened by external readers or players:
1.  Tap `pick file` in the left dropdown and select your `.cha` package.
2.  The app automatically switches the execution button to **"Decrypt Selected"**.
3.  Enter your password. The decrypted plaintext file will be exported to your designated output directory (defaults to the app sandbox for maximum safety).

---

## 🔄 5. Mobile Data Flow: Best Practices for Sharing and Sandboxing

Given mobile sandbox constraints, the most efficient routine is to treat ChaBox Mobile as a "secure relay station" rather than a full-system disk utility:

*   **Rule 1: Position as a "Sovereign Relay & Companion"**:
    Use your computer (desktop version) for heavy lifting, mass archiving, and long-term organization. Use your mobile app for on-the-go viewing, secure sharing, and instant, private note-taking.
*   **Rule 2: Focus on "Sandbox Management", Skip External Paths**:
    Keep your output directories set to their defaults inside the App Sandbox (configured under App Settings). Organize your files directly inside the File Vault's sandbox folder tree rather than trying to route them to external SD cards or shared storage.
*   **Rule 3: Encrypted Packets are Cloud-Proof — Leverage "Share"**:
    *   **Exporting/Saving Out**: Inside the "File Vault", use the top `Filter` to sort or search (supporting Glob syntax) for your target file. Tap the three-dot menu on the right and select **`Share File` (Share)**. You can confidently send these encrypted `.cha` packages through "insecure highways" like messaging apps, emails, or public clouds.
    *   **The Peace of Mind**: As long as your master password remains secure, a `.cha` package on public cloud drives is mathematically identical to a locked vault. It is completely uncrackable on the Internet.
    *   **Importing**: When receiving a `.cha` package from email or cloud drives, use your device's "Open In" menu and select ChaBox, or use the `+ Add File` button inside the File Vault to pull the file into the sandbox, enter your password, and decrypt.

---

## ✍️ 6. The Killer Mobile Feature: "Secure Notes"

If you need to store account credentials, private journals, financial ledgers, or sensitive business ideas, the mobile "Secure Notes" feature is your ultimate private notepad.

### 6.1 Instant Encryption, Zero Residue
Every note you save is compiled directly into an individual, highly encrypted `.cha` file. This architecture ensures you can back up, share, or delete notes individually via the File Vault, giving you complete data sovereignty.

### 6.2 Immersive Markdown with Three High-Tier Security Technologies

Secure Notes provides a clean, distraction-free **Markdown environment** with three powerful features tailored for mobile:

#### ① Variable Substitution: Solving Cross-Platform Image Relocation
In standard Markdown, referencing a local image (e.g., `![Photo](/User/my_images/photo.png)`) breaks immediately when you move the file to another device because the absolute path changes (resulting in broken images).
ChaBox solves this! It introduces **app-defined read-only variables** (such as `{{noteDir}}` pointing to the active device's notes folder) and up to 15 **custom variables** (e.g., `{{myImgPath}}`):
*   **Example Syntax**: Embed images like this:
    `![ID Card]({{noteDir}}/images/id_card.png.cha)`
*   **Seamless Relocation**: When you transfer the note and its images to your PC or another phone, `{{noteDir}}` dynamically resolves to the new host device's active path. Your images render perfectly across all platforms without manual link fixing!

#### ② Encrypted Inline Images: Double Physical Safeguards
In typical notes apps, while the text might be encrypted, inserted photos are often stored in cleartext inside the system gallery, vulnerable to scanning by other apps.
ChaBox lets you embed **pre-encrypted images** (with `.png.cha` or `.jpg.cha` extensions) directly into your Markdown:
*   **Example Syntax**: `![Confidential]({{noteDir}}/images/secret.png.cha)`
*   **Security Model**: When you preview the note, as long as the encrypted image and the note share the **same password**, ChaBox decrypts the image **directly in RAM** for real-time rendering. No temporary plaintext files are ever written to disk, cache, or galleries. The moment you exit the preview, the RAM is cleared, leaving no forensic footprint.

#### ③ Multi-Dimensional Active Defense: Shutting Out Sniffers
To keep your data safe in public spaces or from background system processes, ChaBox Mobile deploys active defensive shields:

*   **Anti-Screenshot & Anti-Recording**: The app locks OS-level screen capture. Any background malware or spyware attempting to record your screen will only capture a blank page, securing your notes against visual exploits.
*   **Background App Switcher Masking**: When you swipe up to switch apps, the OS-level thumbnail of ChaBox is immediately covered with an opaque secure mask. Passersby cannot catch a glimpse of your private notes or keys in your recent apps drawer.
*   **App Lock & Idle Lock (With Biometrics)**:
    *   **Double Barriers**: Enable **App Lock** (forces validation on startup) and **Idle Auto-Lock** (automatically locks the app if inactive for, say, 1 minute) under App Settings.
    *   **Biometric Integration**: On mobile, the App Lock integrates seamlessly with your device's native **Fingerprint or FaceID**. It provides a robust physical barrier combined with a frictionless, one-touch access experience.
*   **Targeted Clipboard Auto-Clear**:
    *   **Preventing Scrapers**: System clipboards are highly vulnerable to scraping by third-party apps. To close this loophole, ChaBox monitors sensitive areas. When you copy text inside "Secure Notes" or copy a passcode from the "Password Text" module, it **triggers a background timer to selectively wipe the clipboard**, preventing passwords or secret fragments from lingering.

---

## 💡 7. Quick Start Checklist for Mobile Newcomers

If you have just installed ChaBox Mobile, follow these quick steps to secure your digital footprint:

1.  [ ] **Secure the Lifeline**: Slide out the Left Menu -> select "Password Management" -> tap "Export to File" to back up your random master password. Keep it on a physical offline USB drive.
2.  [ ] **Enable Biometrics**: Open App Settings in the left menu -> enable "App Lock" -> pair it with your fingerprint/FaceID.
3.  [ ] **Write Your First Secure Note**: Tap the diary icon in the top-right -> tap the "+" button -> experience a secure, tracker-free Markdown editor.
