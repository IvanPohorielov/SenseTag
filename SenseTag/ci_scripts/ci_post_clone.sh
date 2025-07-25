#!/bin/sh

# Exit on error (-e), undefined vars (-u), and pipeline failures (-o pipefail)
set -euo pipefail

# Disable Xcode macro fingerprint validation to prevent spurious build errors
defaults write com.apple.dt.Xcode IDESkipMacroFingerprintValidation -bool YES
defaults delete com.apple.dt.Xcode IDEPackageOnlyUseVersionsFromResolvedFile
defaults delete com.apple.dt.Xcode IDEDisableAutomaticPackageResolution
