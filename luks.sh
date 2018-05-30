
echo "create encrypted.img..."
dd \
	if=/dev/zero \
	of=encrypted.img \
	bs=1 \
	count=0 \
	seek=1G

echo "luksFormat encrypted.img..."
sudo cryptsetup \
	luksFormat \
	encrypted.img \
	mykey.keyfile

echo "luksOpen encrypted.img in myEncryptedVolume..."
sudo cryptsetup \
	luksOpen \
	encrypted.img \
	myEncryptedVolume \
	--key-file mykey.keyfile

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

echo "run nativescript script..."
. $(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/run-nativescript.sh $PRIVATE_DIR

echo "umount dir..."
sudo umount \
	$PRIVATE_DIR \

echo "luksClose myEncryptedVolume..."
sudo cryptsetup \
	luksClose \
	myEncryptedVolume