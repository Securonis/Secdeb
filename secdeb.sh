#!/bin/bash

echo "== Securonis .deb Builder =="

read -p "Package folder (e.g., mytool): " PKG_DIR
read -p "Package name: " PKG_NAME
read -p "Version: " VERSION
read -p "Description: " DESCRIPTION
read -p "Architecture (all/amd64/arm64): " ARCH
read -p "Dependencies (comma-separated): " DEPENDS

if [ ! -d "$PKG_DIR" ]; then
    echo "Error folder '$PKG_DIR' not found!!"
    exit 1
fi

mkdir -p "$PKG_DIR/DEBIAN"

cat <<EOF > "$PKG_DIR/DEBIAN/control"
Package: $PKG_NAME
Version: $VERSION
Section: utils
Priority: optional
Architecture: $ARCH
Depends: ${DEPENDS:-none}
Maintainer: root0emir <securonis@securonislinux.github.io>
Description: $DESCRIPTION
EOF

dpkg-deb --build "$PKG_DIR"

echo ""
echo "$PKG_NAME_${VERSION}.deb has been successfully built."
