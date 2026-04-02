#!/bin/bash
set -e

APP_NAME="BadDadDTGQueueManager"
APP_BUNDLE="${APP_NAME}.app"
OUT_DIR=".build/release"
BINARY="${OUT_DIR}/${APP_NAME}"

ARCH=$(uname -m)
TARGET="${ARCH}-apple-macosx12.0"

# Collect all Swift source files
SWIFT_FILES=$(find BadDadDTGQueueManager -name "*.swift" | sort)

echo "Building ${APP_NAME} for ${ARCH}..."
mkdir -p "${OUT_DIR}"

# Use system frameworks directly — CLT SDK omits SwiftUI Swift module files,
# but they exist on the installed macOS at /System/Library/Frameworks
swiftc \
  -target "${TARGET}" \
  -parse-as-library \
  -F "/System/Library/Frameworks" \
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
    <string>12.0</string>
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
