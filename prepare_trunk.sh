#!/bin/sh
base=$1
androidBase=$2
iconset=$3


if [ "$base" == "" ]; then
	$androidBase=$base;
fi

if [ "$iconset" == "" ]; then
        $iconset=OSX.iconset;
fi

echo base image: $base
echo anroidBase image: $androidBase

#windows icons
echo Converting Windows icons
convert "$base" -resize '16x16'     -unsharp 1x4 "Icon-win32-16.png"
convert "$base" -resize '32x32'     -unsharp 1x4 "Icon-win32-32.png"
convert "$base" -resize '48x48'     -unsharp 1x4 "Icon-win32-48.png"

#osx icons
echo Converting OSX icons
rm -R $iconset
mkdir $iconset
convert "$base" -resize '16x16'     -unsharp 1x4 "$iconset/icon_16x16.png"
convert "$base" -resize '32x32'     -unsharp 1x4 "$iconset/icon_16x16@2x.png"
convert "$base" -resize '32x32'     -unsharp 1x4 "$iconset/icon_32x32.png"
convert "$base" -resize '64x64'     -unsharp 1x4 "$iconset/icon_32x32@2x.png"
convert "$base" -resize '128x128'   -unsharp 1x4 "$iconset/icon_128x128.png"
convert "$base" -resize '256x256'   -unsharp 1x4 "$iconset/icon_128x128@2x.png"
convert "$base" -resize '256x256'   -unsharp 1x4 "$iconset/icon_256x256.png"
convert "$base" -resize '512x512'   -unsharp 1x4 "$iconset/icon_256x256@2x.png"
convert "$base" -resize '512x512'   -unsharp 1x4 "$iconset/icon_512x512.png"
convert "$base" -resize '1024x1024' -unsharp 1x4 "$iconset/icon_512x512@2x.png"
iconutil -c icns --output Icon-osx.icns "$iconset"

#ios icons
echo Converting iOS icons
convert "$base" -resize '29x29'     -unsharp 1x4 "Icon-Small.png"
convert "$base" -resize '58x58'     -unsharp 1x4 "Icon-Small@2x.png"
convert "$base" -resize '87x87'     -unsharp 1x4 "Icon-Small@3x.png"
convert "$base" -resize '40x40'     -unsharp 1x4 "Icon-Small-40.png"
convert "$base" -resize '80x80'     -unsharp 1x4 "Icon-Small-40@2x.png"
convert "$base" -resize '50x50'     -unsharp 1x4 "Icon-Small-50.png"
convert "$base" -resize '100x100'   -unsharp 1x4 "Icon-Small-50@2x.png"
convert "$base" -resize '57x57'     -unsharp 1x4 "Icon.png"
convert "$base" -resize '114x114'   -unsharp 1x4 "Icon@2x.png"
convert "$base" -resize '171x171'   -unsharp 1x4 "Icon@3x.png"
convert "$base" -resize '60x60'     -unsharp 1x4 "Icon-60.png"
convert "$base" -resize '72x72'     -unsharp 1x4 "Icon-72.png"
convert "$base" -resize '76x76'     -unsharp 1x4 "Icon-76.png"
convert "$base" -resize '120x120'   -unsharp 1x4 "Icon-60@2x.png"
convert "$base" -resize '180x180'   -unsharp 1x4 "Icon-60@3x.png"
convert "$base" -resize '144x144'   -unsharp 1x4 "Icon-72@2x.png"
convert "$base" -resize '152x152'   -unsharp 1x4 "Icon-76@2x.png"
convert "$base" -resize '512x512'   -unsharp 1x4 "iTunesArtwork"
convert "$base" -resize '1024x1024' -unsharp 1x4 "iTunesArtwork@2x"

#tvos icons
echo Converting tvOS icons
convert "Icon-tvOS-Large-1.jpg" -resize '400x240'   -unsharp 1x4 "Icon-tvOS-Small-1.jpg"
convert "Icon-tvOS-Large-2.png" -resize '400x240'   -unsharp 1x4 "Icon-tvOS-Small-2.png"
convert "Icon-tvOS-Large-3.png" -resize '400x240'   -unsharp 1x4 "Icon-tvOS-Small-3.png"
convert "Icon-tvOS-Large-4.png" -resize '400x240'   -unsharp 1x4 "Icon-tvOS-Small-4.png"
convert "Icon-tvOS-Large-5.png" -resize '400x240'   -unsharp 1x4 "Icon-tvOS-Small-5.png"

#android icons
echo Converting Android icons
convert "$androidBase" -resize '36x36'     -unsharp 1x4 "Icon-ldpi.png"
convert "$androidBase" -resize '48x48'     -unsharp 1x4 "Icon-mdpi.png"
convert "$androidBase" -resize '72x72'     -unsharp 1x4 "Icon-hdpi.png"
convert "$androidBase" -resize '96x96'     -unsharp 1x4 "Icon-xhdpi.png"
convert "$androidBase" -resize '144x144'   -unsharp 1x4 "Icon-xxhdpi.png"
convert "$androidBase" -resize '192x192'   -unsharp 1x4 "Icon-xxxhdpi.png"

echo Setting api_key.txt to Original
cp api_key_original.txt api_key.txt
