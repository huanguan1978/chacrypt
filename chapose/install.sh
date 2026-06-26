#!/bin/sh

################################################################################
# chapose - Installation Script
#
# Usage:
#   sh install.sh --version <version>
#
# Example:
#   sh install.sh --version 1.0.0
#
# Notes:
# - The release tag is built as: ${TAG_PREFIX}<version>
# - Default TAG_PREFIX is "chapose-v", matching tags like "chapose-v1.0.0"
# - You can customize REPO and TAG_PREFIX below for your own workflow.
################################################################################

set -e

# Configuration
APP_NAME="chapose"
REPO="huanguan1978/chacrypt"
TAG_PREFIX="chapose-v"
VERSION=""
INSTALL_DIR_OVERRIDE=""

usage() {
    echo "Usage: sh install.sh --version <version>"
    echo "Example: sh install.sh --version 1.0.0"
}

while [ "$#" -gt 0 ]; do
    case "$1" in
        --version)
            shift
            if [ -z "$1" ]; then
                echo "Error: --version requires a value."
                usage
                exit 1
            fi
            VERSION="$1"
            ;;
        --install-dir)
            shift
            if [ -z "$1" ]; then
                echo "Error: --install-dir requires a value."
                usage
                exit 1
            fi
            INSTALL_DIR_OVERRIDE="$1"
            ;;
        -h|--help)
            usage
            exit 0
            ;;
        *)
            echo "Error: Unknown argument: $1"
            usage
            exit 1
            ;;
    esac
    shift
done

if [ -z "$VERSION" ]; then
    echo "Error: Missing required argument --version"
    usage
    exit 1
fi

TAG="${TAG_PREFIX}${VERSION}"
RELEASE_PAGE="https://github.com/${REPO}/releases"

for cmd in curl unzip find; do
    if ! command -v "$cmd" >/dev/null 2>&1; then
        echo "Error: Required command not found: $cmd"
        exit 1
    fi
done

# Detect OS and architecture
UNAME_OS=$(uname -s)
ARCH=$(uname -m)

# Convert OS name
case "$UNAME_OS" in
    Darwin)                        OS_NAME="macos" ;;
    Linux)                         OS_NAME="linux" ;;
    MINGW64_NT* | MSYS_NT* | CYGWIN*) OS_NAME="windows" ;;
    *)                             echo "Error: Unsupported OS: $UNAME_OS"; exit 1 ;;
esac

# Set install directory based on OS
if [ -n "$INSTALL_DIR_OVERRIDE" ]; then
    INSTALL_DIR="$INSTALL_DIR_OVERRIDE"
elif [ "$OS_NAME" = "windows" ]; then
    INSTALL_DIR="$HOME/AppData/Local/bin"
else
    INSTALL_DIR="$HOME/.local/bin"
fi

# Convert architecture name
case "$ARCH" in
    x86_64)  ARCH_NAME="x64" ;;
    arm64)   ARCH_NAME="arm64" ;;
    aarch64) ARCH_NAME="arm64" ;;
    armv7l)  ARCH_NAME="arm" ;;
    riscv64) ARCH_NAME="riscv64" ;;
    *)       echo "Error: Unsupported architecture: $ARCH"; exit 1 ;;
esac

# Build filename and download URL
FILE_NAME="${APP_NAME}-${OS_NAME}-${ARCH_NAME}-${VERSION}.zip"
URL="https://github.com/${REPO}/releases/download/${TAG}/${FILE_NAME}"

if [ "$OS_NAME" = "windows" ]; then
    TARGET_BIN="$INSTALL_DIR/${APP_NAME}.exe"
else
    TARGET_BIN="$INSTALL_DIR/${APP_NAME}"
fi

echo "========================================"
echo "${APP_NAME} Installation Script v${VERSION}"
echo "========================================"
echo "Detected: OS=$OS_NAME, Architecture=$ARCH_NAME"
echo "Install directory: $INSTALL_DIR"
echo ""
echo "Downloading: $URL"
echo ""

# Create install directory and download
mkdir -p "$INSTALL_DIR" || { echo "Error: Failed to create directory $INSTALL_DIR"; exit 1; }

TMP_DIR=$(mktemp -d) || { echo "Error: Failed to create temporary directory"; exit 1; }
cleanup() {
    rm -rf "$TMP_DIR"
}
trap cleanup EXIT INT TERM

cd "$TMP_DIR"

if ! curl -fL --retry 3 --connect-timeout 15 -o "$FILE_NAME" "$URL"; then
    echo "Error: Download failed. This may be due to:"
    echo "  - Network connectivity issues"
    echo "  - Release asset not found at: $URL"
    echo "  - Incorrect platform/architecture detection"
    echo ""
    echo "Please download the binary manually from:"
    echo "$RELEASE_PAGE"
    echo ""
    echo "Then follow the manual installation steps in the script comments."
    exit 1
fi

# Extract and install
if ! unzip -q -o "$FILE_NAME"; then
    echo "Error: Failed to extract the archive. Ensure unzip is installed."
    exit 1
fi

# Find the executable file inside any extracted build/ directory.
EXECUTABLE=""

# Try exact filename based on OS (Windows has .exe extension)
if [ "$OS_NAME" = "windows" ]; then
    EXECUTABLE=$(find . \( -path "./build/${APP_NAME}-${VERSION}-${OS_NAME}-${ARCH_NAME}.exe" -o -path "./*/build/${APP_NAME}-${VERSION}-${OS_NAME}-${ARCH_NAME}.exe" -o -path "./build/${APP_NAME}.exe" -o -path "./*/build/${APP_NAME}.exe" \) -type f 2>/dev/null | head -1)
    if [ -z "$EXECUTABLE" ]; then
        EXECUTABLE=$(find . -path "*/build/${APP_NAME}*.exe" -type f 2>/dev/null | head -1)
    fi
else
    EXECUTABLE=$(find . \( -path "./build/${APP_NAME}-${VERSION}-${OS_NAME}-${ARCH_NAME}" -o -path "./*/build/${APP_NAME}-${VERSION}-${OS_NAME}-${ARCH_NAME}" -o -path "./build/${APP_NAME}" -o -path "./*/build/${APP_NAME}" \) -type f 2>/dev/null | head -1)
    if [ -z "$EXECUTABLE" ]; then
        EXECUTABLE=$(find . -path "*/build/${APP_NAME}*" -type f 2>/dev/null | head -1)
    fi
fi

if [ -z "$EXECUTABLE" ] || [ ! -f "$EXECUTABLE" ]; then
    echo "Error: Could not find '${APP_NAME}' executable in the archive."
    echo "The archive structure may have changed. Please download manually:"
    echo "$RELEASE_PAGE"
    echo ""
    echo "Manual Installation Steps:"
    echo "1. Download the zip file from: $RELEASE_PAGE"
    echo "2. Extract the archive"
    echo "3. Find the '${APP_NAME}' executable (in build/ subdirectory)"
    echo "4. Copy it to: $TARGET_BIN"
    echo "5. Make it executable: chmod +x $TARGET_BIN"
    exit 1
fi

if ! mv "$EXECUTABLE" "$TARGET_BIN"; then
    echo "Error: Failed to move ${APP_NAME} to $INSTALL_DIR"
    echo "You may need elevated permissions. Try: sudo mv $EXECUTABLE $TARGET_BIN"
    exit 1
fi

chmod +x "$TARGET_BIN" 2>/dev/null || true

# Verify installation
if ! [ -x "$TARGET_BIN" ]; then
    echo "Error: Installation verification failed. ${APP_NAME} executable not found or not executable."
    exit 1
fi

VERIFY_OUTPUT=$("$TARGET_BIN" --version 2>&1) || {
    echo "Error: Installation verification failed. ${APP_NAME} was downloaded, but it could not run on this system."
    if [ -n "$VERIFY_OUTPUT" ]; then
        echo "$VERIFY_OUTPUT"
    fi
    if [ "$OS_NAME" = "macos" ]; then
        echo "Hint: This usually means the downloaded build requires a newer macOS version or a different CPU architecture."
    fi
    exit 1
}

# Prompt user to update PATH if needed
echo "========================================"
echo "✓ Installation completed!"
echo "========================================"
echo "${APP_NAME} has been installed to: $TARGET_BIN"
echo ""

if ! echo "$PATH" | grep -q "$INSTALL_DIR"; then
    echo "⚠ Action required: Add $INSTALL_DIR to your PATH"
    echo ""
    echo "Run:"
    echo "  export PATH=\"\$PATH:$INSTALL_DIR\""
    echo ""
    if [ "$OS_NAME" = "windows" ]; then
        echo "To persist this, add the above line to your .bashrc or .profile"
    else
        echo "To persist this, add the above line to ~/.bashrc, ~/.zshrc, or ~/.profile"
    fi
    echo ""
else
    echo "✓ $INSTALL_DIR is already in your PATH"
    echo ""
fi

echo "Verify installation:"
echo "  ${APP_NAME} --version"
echo "  ${VERIFY_OUTPUT}"
echo ""
echo "For help:"
echo "  ${APP_NAME} --help"