# usage - $ build - build the default folder (eg. test)
#       - $ build test02 - build the folder test02

FOLDER=${1:-test}

docker run -v $PWD/$FOLDER:/data -v $PWD/ndk_1.3:/root/amiga_sdk/ndk_1.3 --rm -w /data kick13builder make
sudo chown $USER $FOLDER/app