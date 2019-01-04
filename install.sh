#!/bin/sh

# This install script is intended to download and install the latest available
# release of the dep dependency manager for Golang.
#
# It attempts to identify the current platform and an error will be thrown if
# the platform is not supported.
#
# Environment variables:
# - INSTALL_DIRECTORY (optional): defaults to $GOPATH/bin
# - DEP_RELEASE_TAG (optional): defaults to fetching the latest release
# - DEP_OS (optional): use a specific value for OS (mostly for testing)
# - DEP_ARCH (optional): use a specific value for ARCH (mostly for testing)
#
# You can install using this script:
# $ curl https://raw.githubusercontent.com/testthedocs/edic/master/install.sh | sh

set -e

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run with root/sudo "
   exit 1
fi

DEP_RELEASE_TAG="0.0.1"
RELEASES_URL="https://github.com/testthedocs/edic/releases"
INSTALL_DIRECTORY="/usr/local/bin"

downloadJSON() {
    url="$2"

    echo "Fetching $url.."
    if test -x "$(command -v curl)"; then
        response=$(curl -s -L -w 'HTTPSTATUS:%{http_code}' -H 'Accept: application/json' "$url")
        body=$(echo "$response" | sed -e 's/HTTPSTATUS\:.*//g')
        code=$(echo "$response" | tr -d '\n' | sed -e 's/.*HTTPSTATUS://')
    elif test -x "$(command -v wget)"; then
        temp=$(mktemp)
        body=$(wget -q --header='Accept: application/json' -O - --server-response "$url" 2> "$temp")
        code=$(awk '/^  HTTP/{print $2}' < "$temp" | tail -1)
        rm "$temp"
    else
        echo "Neither curl nor wget was available to perform http requests."
        exit 1
    fi
    if [ "$code" != 200 ]; then
        echo "Request failed with code $code"
        exit 1
    fi

    eval "$1='$body'"
}

downloadFile() {
    url="$1"
    destination="$2"

    echo "Fetching $url.."
    if test -x "$(command -v curl)"; then
        code=$(curl -s -w '%{http_code}' -L "$url" -o "$destination")
    elif test -x "$(command -v wget)"; then
        code=$(wget -q -O "$destination" --server-response "$url" 2>&1 | awk '/^  HTTP/{print $2}' | tail -1)
    else
        echo "Neither curl nor wget was available to perform http requests."
        exit 1
    fi

    if [ "$code" != 200 ]; then
        echo "Request failed with code $code"
        exit 1
    fi
}

initArch() {
    ARCH=$(uname -m)
    if [ -n "$DEP_ARCH" ]; then
        echo "Using DEP_ARCH"
        ARCH="$DEP_ARCH"
    fi
    case $ARCH in
        amd64) ARCH="amd64";;
        x86_64) ARCH="amd64";;
        i386) ARCH="386";;
        ppc64) ARCH="ppc64";;
        ppc64le) ARCH="ppc64le";;
        *) echo "Architecture ${ARCH} is not supported by this installation script"; exit 1;;
    esac
    echo "ARCH = $ARCH"
}

initOS() {
    OS=$(uname | tr '[:upper:]' '[:lower:]')
    OS_CYGWIN=0
    if [ -n "$DEP_OS" ]; then
        echo "Using DEP_OS"
        OS="$DEP_OS"
    fi
    case "$OS" in
        darwin) OS='darwin';;
        linux) OS='linux';;
        freebsd) OS='freebsd';;
        mingw*) OS='windows';;
        msys*) OS='windows';;
	cygwin*)
	    OS='windows'
	    OS_CYGWIN=1
	    ;;
        *) echo "OS ${OS} is not supported by this installation script"; exit 1;;
    esac
    echo "OS = $OS"
}

# identify platform based on uname output
initArch
initOS

# determine install directory if required
echo "Will install into $INSTALL_DIRECTORY"

# assemble expected release artifact name
if [ "${OS}" != "linux" ] && { [ "${ARCH}" = "ppc64" ] || [ "${ARCH}" = "ppc64le" ];}; then
    # ppc64 and ppc64le are only supported on Linux.
    echo "${OS}_${ARCH} is not supported by this instalation script"
else
    BINARY="edic_${OS}_${ARCH}"
fi

# add .exe if on windows
if [ "$OS" = "windows" ]; then
    BINARY="$BINARY.exe"
fi

# if DEP_RELEASE_TAG was not provided, assume latest
if [ -z "$DEP_RELEASE_TAG" ]; then
    downloadJSON LATEST_RELEASE "$RELEASES_URL/latest"
    DEP_RELEASE_TAG=$(echo "${LATEST_RELEASE}" | tr -s '\n' ' ' | sed 's/.*"tag_name":"//' | sed 's/".*//' )
fi
echo "Release Tag = $DEP_RELEASE_TAG"

# fetch the real release data to make sure it exists before we attempt a download
downloadJSON RELEASE_DATA "$RELEASES_URL/tag/$DEP_RELEASE_TAG"

BINARY_URL="$RELEASES_URL/download/$DEP_RELEASE_TAG/$BINARY"
DOWNLOAD_FILE=$(mktemp)

downloadFile "$BINARY_URL" "$DOWNLOAD_FILE"

echo "Setting executable permissions."
chmod +x "$DOWNLOAD_FILE"

INSTALL_NAME="edic"

if [ "$OS" = "windows" ]; then
    INSTALL_NAME="$INSTALL_NAME.exe"
fi

echo "Moving executable to $INSTALL_DIRECTORY/$INSTALL_NAME"
mv "$DOWNLOAD_FILE" "$INSTALL_DIRECTORY/$INSTALL_NAME"
