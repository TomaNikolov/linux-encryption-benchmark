#!/bin/bash
set -ex

CUR_DIR=$1

cd $1
echo "create {N} project..."
tns create test

cd test

echo "build {N} project..."
tns build android 
