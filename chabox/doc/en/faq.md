# 4. Frequently Asked Questions FAQ

### Q: I forgot my password. Can I recover it?
**A: Absolutely not.**
ChaBox adheres strictly to a zero-knowledge, offline-first privacy model. We never store your password on any server, nor do we build password recovery gates. If you lose your password and have no password backup file, no one can decrypt your files. Please use the password management panel to "Export to File" and keep your backups secure.

### Q: After changing my password, can old encrypted files be decrypted with the new password?
**A: No.**
Passwords are only bound to the encryption event itself. If you update and save a new password, it **cannot** decrypt files that were previously encrypted under the old password.
*   **Correct Password Rotation Flow**: If you want to change your password, first decrypt all your encrypted `.cha` files back to plaintext using your old password. Then, generate and save the new password in the app. Finally, re-encrypt your plaintext files under the new password.

### Q: Why are file extensions longer after encryption? (e.g. `.tgz.cha`)
**A: It acts as an audit trail.**
ChaBox utilizes stacked file extensions to clearly tell you what operations the file has undergone, allowing you to trace back the restoration steps:
*   `.tgz`: Indicates a packaged and compressed folder.
*   `.cha`: Indicates a file locked/encrypted by ChaBox.
*   `.tgz.cha`: Means the folder was first archived, then encrypted. To restore it, you need to "Decrypt" first, and then "Unarchive".

### Q: Why is there no "One-Click Decrypt" button in the File Vault list?
**A: This is an intentional security design choice.**
ChaBox is engineered as a secure, professional privacy vault rather than a standard file manager:
1.  **In-App Temporary Preview**: If you only want to view the contents of an encrypted file temporarily, currently the app supports quick previewing for **text and image file formats only**. Simply open the quick action menu on the right side of the list item and select preview. ChaBox decrypts the file directly in secure memory and renders it, **never creating plaintext cache files on disk**.
2.  **Deliberate Plaintext Extraction**: If you must extract a file for use in other external apps, copy its path via the quick menu and decrypt it using the homepage or the atomic Decrypt tool. This multi-step process acts as a deliberate speed bump to remind you that you are turning a secure asset into exposed plaintext.

### Q: What is "In-Memory Processing"?
**A: Leaving no traces behind.**
When you preview encrypted notes or photos within ChaBox, the software performs all decryption and rendering strictly within secure RAM. Even if your device is lost or stolen, attackers cannot extract remnants of your previewed data from your hard drive or system caches.

### Q: Why is screenshot and screen recording blocked while the app is running?
**A: Active anti-snooping protection.**
To prevent background malware (such as trojans, remote monitoring tools, or spy apps) from silently capturing your sensitive diary pages or private documents, ChaBox disables OS-level screenshotting and screen recording.

### Q: Does ChaBox connect to the network? How is my data kept safe?
**A: 100% offline-first and standalone.**
ChaBox contains no cloud sync modules, no network trackers, and no remote server connections. Your keys, notes, and documents remain stored strictly on your local hardware. As long as your device is physically secure, your data remains completely safe.

### Q: How do I sync my encrypted diaries or files between my phone and computer?
**A: ChaBox is designed to be fully offline and does not provide automatic cloud sync. However, you can easily move files between devices using the built-in "File Vault" and "Filter" features:**

1.  **Share/Export (Sender)**: Open the "File Vault" and use the "Filter" button to locate the directory containing your encrypted files. Tap the "Share" button in the top-right corner (or use the share option in the individual file's menu) to send the files to cloud storage, email, or any other external app.
2.  **Import (Receiver)**: On your other device, open the "File Vault" and use the "Filter" button to switch to your desired target directory. Tap the "Add File" button to select the files you received (e.g., from your cloud storage download folder) and import them into the current device's management system.
3.  **Decrypt & View**: Ensure both devices are configured with the same password, and you can seamlessly decrypt and view your files.

*Note: As long as your files are encrypted and your password is kept private, these `.cha` packages are mathematically secure during transfer.*

### Q: Can I encrypt files on external storage devices (like USB drives, external hard disks)?
**A: Yes, absolutely.**
The local file manager is highly versatile and is not locked to app private directories. Using the File Filter, you can switch the target directory to any mounted USB drive, external hard disk, or SD card, and perform encryption, decryption, archiving, or secure erasing directly on the external media.

### Q: Can ChaBox securely delete files outside the app sandbox?
**A:** On desktop, if the app has the real file path and the current user has write/delete permission, ChaBox can directly overwrite and delete the file. On Android / iOS, the app is sandboxed, so ChaBox can only securely erase files inside its own sandbox and cannot directly delete external original files.

### Q: What is the relationship between the ChaBox GUI application and the `chapose` CLI tool?
**A: They share the same underlying cryptographic design.**
*   **Format Interoperability**: `chapose` is the command-line interface (CLI) counterpart of the ChaBox ecosystem. It uses the exact same encryption engine and `.cha` container format.
*   **Seamless Workflow**: Any file encrypted via the graphical interface on your phone or desktop can be decrypted via `chapose` on a headless server or Unix terminal, and vice-versa.

### Q: How do the ChaBox tools work in tandem with `ft:filetools`?
**A: They complement each other to build automated, secure pipelines.**
*   **Functional Division**: ChaBox and `chapose` focus on high-strength, single-file authenticated encryption. `ft:filetools` is a high-performance file stream utility that excels at batch directory packing (Archive), file filtering, and physical-grade wiping (Erase).
*   **Synergy**: For automated backup pipelines, you can write a YAML config file for `ft` to orchestrate operations: schedule a task to bundle directories (`ft archive`), encrypt the bundle (`chapose encrypt`), and securely wipe the original directory and intermediate archives (`ft wipe`), creating a fully automated, trace-free backup pipeline.
