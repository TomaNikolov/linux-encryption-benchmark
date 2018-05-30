#!/bin/bash
set -ex

echo "create encrypted.img..."
dd \
	if=/dev/zero \
	of=encrypted.img \
	bs=1 \
	count=0 \
	seek=1G

echo "luksFormat encrypted.img..."
echo -n "test" | sudo cryptsetup -q\
	luksFormat \
	encrypted.img \
    -

echo "luksOpen encrypted.img in myEncryptedVolume..."
echo -n "test" | sudo cryptsetup \
	luksOpen \
	encrypted.img \
	myEncryptedVolume \
    -

echo "format myEncryptedVolume..."
sudo mkfs.ext4 \
	/dev/mapper/myEncryptedVolume

echo "ensure mount dir exist..."
PRIVATE_DIR=$HOME/Private
mkdir -p $PRIVATE_DIR

echo "mount dir..."
sudo mount \
	/dev/mapper/myEncryptedVolume \
	$PRIVATE_DIR/

sudo chown \
	-R $USER \
	$PRIVATE_DIR/

echo "run nativescript script..."
. $(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/run-nativescript.sh  ||:

# echo "umount dir..."
# sudo umount \
# 	$PRIVATE_DIR \

# echo "luksClose myEncryptedVolume..."
# sudo cryptsetup \
# 	luksClose \
# 	myEncryptedVolume