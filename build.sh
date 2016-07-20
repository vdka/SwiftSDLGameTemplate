#!/bin/bash

CC=`swiftenv which swift`

echo "Using $CC"
export SDKROOT=$(xcrun --show-sdk-path --sdk macosx)

$CC build -Xlinker -L$(pwd)/

