# CI Signing Setup (Android and iOS)

This document describes the secrets used by OS-specific workflows in this repository.

## Android build workflow

Workflow: `chabox_build_android.yml`

### Inputs

- `use_release_keystore` (boolean)
  - `false`: build release APK without custom signing secrets.
  - `true`: requires Android signing secrets below.

### Required Android secrets

- `ANDROID_KEYSTORE_BASE64`
- `ANDROID_KEY_ALIAS`
- `ANDROID_KEYSTORE_PASSWORD`
- `ANDROID_KEY_PASSWORD`

### How to prepare `ANDROID_KEYSTORE_BASE64`

1. Create/export your `release-keystore.jks`.
2. Encode as base64:

```bash
base64 release-keystore.jks | tr -d '\n'
```

3. Save the output string to repository secret `ANDROID_KEYSTORE_BASE64`.

## iOS build workflow

Workflow: `chabox_build_ios.yml`

### Inputs

- `require_signing_assets` (boolean)
  - `false`: workflow builds with `--no-codesign` and uploads `Runner.app`.
  - `true`: workflow only performs signing-secrets precheck (it still builds `--no-codesign`).

### Required iOS secrets for precheck

- `IOS_CERT_BASE64`
- `IOS_CERT_PASSWORD`
- `IOS_PROFILE_BASE64`
- `IOS_TEAM_ID`
- `IOS_BUNDLE_ID`

## Notes

- Current iOS workflow is intentionally `--no-codesign` for build diagnostics and integration testing.
- If you need signed IPA distribution in CI, add a separate iOS signing workflow that imports certificate/profile into keychain and runs an archive/export step.
