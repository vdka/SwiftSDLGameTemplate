#!/bin/bash

# Must have swiftenv installed here. Default for homebrew
CC=`/usr/local/bin/swiftenv which swift`

echo "Using $CC"
export SDKROOT=$(xcrun --show-sdk-path --sdk macosx)

SWIFTC_FLAGS="-DDebug"
LINKER_FLAGS="-L$(pwd)/"

$CC build -Xswiftc $SWIFTC_FLAGS -Xlinker $LINKER_FLAGS &&
  echo "Build Succeeded!" || echo "Build Failed!"
