# ChaPose: High-Performance Offline File Security Guardian (ChaCrypt Core)

When you transfer files via email, cloud storage, or instant messaging, unencrypted data is essentially "running naked" on the internet, vulnerable to interception or leaks at any moment. Even if you keep sensitive files locally, you cannot fully prevent other applications on the same device from snooping on your data.

**With file encryption, everything changes!**

**ChaPose** is the CLI (Command Line Interface) core component of the ChaCrypt ecosystem. It is not a bloated encryption suite, but a professional-grade guardian built for high-performance processing, automated workflows, and robust security hardening.

### Getting Started
Once installed, you can verify the installation and explore features:
*   **Check Version**: `chapose --version` (Outputs the version number upon successful installation)
*   **General Help**: `chapose help` (View global help)
*   **Subcommand Help**: `chapose help <command>` (e.g., `chapose help encrypt`. **Note: Subcommand help documentation includes rich usage examples, which we highly recommend checking first.**)

### Core Commands

1.  **`keyfile` - Key Management**
    Generates a high-entropy random keyfile, serving as the trusted credential for all encryption/decryption operations.
    *   *Usage*: `chapose keyfile -p "YourStrongPassword" -o ~/.secrets/chapose.key`

2.  **`encrypt` - Data Hardening**
    Converts plaintext files into high-strength `.cha` ciphertext.
    *   *Usage*: `chapose encrypt sensitive.db`

3.  **`decrypt` - Secure Restoration**
    Verifies and decrypts `.cha` ciphertext files, restoring them to their original plaintext.
    *   *Usage*: `chapose decrypt sensitive.db.cha`

### Automation Pipeline (Manual Execution Example)

ChaPose focuses on high-strength encryption for single files. For complex "Archive → Encrypt → Physical Wipe" workflows, you can pair it with `ft:filetools` (an open-source cross-platform tool maintained by the same developer, [visit the official repository](https://github.com/huanguan1978/ft)) to achieve automation:

1.  **Archive**: `ft archive --source ./data --target bundle.tgz`
2.  **Encrypt**: `chapose encrypt bundle.tgz -w` (Use `-w` to force overwrite)
3.  **Physical Wipe**: `ft wipe ./data --levels=medium` (Permanently destroy original plaintext)
4.  **Cleanup**: `ft wipe bundle.tgz --levels=low` (Wipe the intermediate archive)

### CLI Best Practices: Seamless Encryption

To enable "Seamless Encryption," configure the global `CHAPOSE_KEYFILE` environment variable to execute commands without manually specifying the key path.

*   **Unix/macOS (Zsh/Bash)**:
    Add to `~/.zshrc` or `~/.bashrc`:
    `export CHAPOSE_KEYFILE="$HOME/.secrets/chapose.key"`
*   **Windows (PowerShell)**:
    Run: `[Environment]::SetEnvironmentVariable("CHAPOSE_KEYFILE", "$HOME\.secrets\chapose.key", "User")`
*   **Windows (CMD)**:
    Run: `setx CHAPOSE_KEYFILE "%USERPROFILE%\.secrets\chapose.key"`

Once configured, simply run `chapose encrypt target.data`, and the system will automatically read the key from the environment variable, significantly boosting your workflow efficiency.

---

**Ready to take control of your data sovereignty?**
Visit our [GitHub repository](https://github.com/huanguan1978/chacrypt/tree/main/chapose) to access the source code, binary installers, and detailed technical documentation.
