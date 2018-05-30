#!/bin/bash
set -ex

echo "folder is " $PRIVATE_DIR
cd $PRIVATE_DIR
echo "create {N} project..."
tns create test

cd test

echo "build {N} project..."
tns build android 
