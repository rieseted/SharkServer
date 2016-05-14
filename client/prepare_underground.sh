#!/bin/sh
base=$1
if [ "$base" == "" ]; then 
    base="IconUnderground";
fi

#android icons
echo Converting Underground icons
cp -v "$base-192.png" "Icon-xxxhdpi.png"
cp -v "$base-144.png" "Icon-xxhdpi.png"
cp -v "$base-96.png" "Icon-xhdpi.png"
cp -v "$base-72.png" "Icon-hdpi.png"
cp -v "$base-48.png" "Icon-mdpi.png"

echo Setting api_key.txt to Underground
cp api_key_underground.txt api_key.txt

