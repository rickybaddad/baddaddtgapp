#!/bin/bash
set -e

APP_NAME="BadDadDTGQueueManager"
APP_BUNDLE="${APP_NAME}.app"
OUT_DIR=".build/release"
BINARY="${OUT_DIR}/${APP_NAME}"

SDK=$(xcrun --sdk macosx --show-sdk-path)
ARCH=$(uname -m)
# Detect actual SDK version to use as deployment target
SDK_VERSION=$(xcrun --sdk macosx --show-sdk-version)
TARGET="${ARCH}-apple-macosx${SDK_VERSION}"

# Collect all Swift source files
SWIFT_FILES=$(find BadDadDTGQueueManager -name "*.swift" | sort)

echo "Building ${APP_NAME} for ${ARCH} (SDK ${SDK_VERSION})..."
mkdir -p "${OUT_DIR}"
swiftc \
  -sdk "${SDK}" \
  -target "${TARGET}" \
  -parse-as-library \
  -F "${SDK}/System/Library/Frameworks" \
  -framework SwiftUI \
  -framework AppKit \
  -O \
  ${SWIFT_FILES} \
  -o "${BINARY}"

echo "Creating app bundle..."
mkdir -p "${APP_BUNDLE}/Contents/MacOS"
mkdir -p "${APP_BUNDLE}/Contents/Resources"

cp "${BINARY}" "${APP_BUNDLE}/Contents/MacOS/${APP_NAME}"

cat > "${APP_BUNDLE}/Contents/Info.plist" << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>CFBundleExecutable</key>
    <string>BadDadDTGQueueManager</string>
    <key>CFBundleIdentifier</key>
    <string>com.baddad.queuemanager</string>
    <key>CFBundleName</key>
    <string>BadDadDTG Queue Manager</string>
    <key>CFBundlePackageType</key>
    <string>APPL</string>
    <key>CFBundleShortVersionString</key>
    <string>1.0.0</string>
    <key>CFBundleVersion</key>
    <string>1</string>
    <key>LSMinimumSystemVersion</key>
    <string>13.0</string>
    <key>NSHighResolutionCapable</key>
    <true/>
    <key>NSPrincipalClass</key>
    <string>NSApplication</string>
    <key>NSSupportsAutomaticGraphicsSwitching</key>
    <true/>
</dict>
</plist>
EOF

echo "Launching ${APP_NAME}..."
open "${APP_BUNDLE}"
