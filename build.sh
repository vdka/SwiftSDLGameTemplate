#!/bin/bash

# Must have swiftenv installed here. Default for homebrew
CC=`/usr/local/bin/swiftenv which swift`

echo "Using $CC"
export SDKROOT=$(xcrun --show-sdk-path --sdk macosx)

$CC build -Xlinker -L$(pwd)/ && echo "Build Succeeded!" || echo "Build Failed!"
