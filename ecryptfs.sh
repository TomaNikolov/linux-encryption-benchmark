#!/bin/bash
set -ex


echo "ensure mount dir exist..."
PRIVATE_DIR=$HOME/Privatefs
mkdir -p $PRIVATE_DIR

sudo mount -t ecryptfs \
-o key=passphrase:passphrase_passwd=test,no_sig_cache,ecryptfs_cipher=aes,ecryptfs_key_bytes=16,ecryptfs_enable_filename_crypto=n,ecryptfs_passthrough=y \
/$PRIVATE_DIR /$PRIVATE_DIR


# echo "run nativescript script..."
# . $(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/run-nativescript.sh  ||:

echo "run nativescript script..."
mkdir -p $PRIVATE_DIR/fio
fio . $(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/ecryptfs.fio
rm -rf $PRIVATE_DIR/fio

sudo umount $PRIVATE_DIR

rm -rf $PRIVATE_DIR