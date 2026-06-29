# chabox Workflow Convention

This project uses a staged packaging flow:

1. Prepare
   - Run only when platform support, generated metadata, or package templates change.
   - Verify target platform folders exist and generated assets are ready.
   - Goal: make Build succeed.

2. Build
   - Run on GitHub Actions or a local machine with the required toolchain.
   - Produce one normalized ZIP artifact per platform and architecture.
   - Do not create final installer formats here.

3. Package
   - Consume the ZIP artifact produced by Build.
   - Generate final distributables such as msix, inno setup installers, snap, flatpak, dmg, apk, or testing bundles.
   - May run locally or in GitHub Actions.

4. Release
   - Optional.
   - Either publish Build ZIP artifacts as portable downloads or publish Package outputs as release assets.
   - Release does not own complex packaging logic.

Rules:

- Build artifacts are the shared input for Package.
- Prepare is the minimum prerequisite for Build.
- Package is the main place for channel-specific adjustments.
- Release is only a publishing step.

Recommended directory split:

- package/prepare/: validation and generation helpers
- package/templates/: snap, flatpak, and Inno Setup templates
- package/scripts/: template rendering and packaging scripts
