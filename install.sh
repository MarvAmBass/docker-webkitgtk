#!/bin/sh

download_package() {
  wget $(wget -O - "https://packages.debian.org/sid/amd64/$1/download" 2>/dev/null | grep '\.deb">' | head -n1 | sed 's/.*="//g' | sed 's/".*$//g')
}

apt-get update

# core dependencies
apt-get install -q -y libglib2.0-dev libgtk2.0-dev gir1.2-gtk-2.0 libgtk-3-dev gir1.2-gtk-3.0 libpango1.0-dev libharfbuzz-dev libcairo2-dev libfontconfig1-dev libfreetype6-dev libicu-dev libxslt1-dev libxml2-dev libsoup2.4-dev gir1.2-soup-2.4 libsqlite3-dev libgudev-1.0-dev libjpeg-dev libpng-dev libwebp-dev libxt-dev libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev libenchant-dev geoclue-2.0 libsecret-1-dev gobject-introspection libgirepository1.0-dev libgl1-mesa-dev libegl1-mesa-dev libgles2-mesa-dev


# other dependencies
apt-get install -q -y libgcrypt20-dev libtasn1-6-dev libnotify-dev libhyphen-dev

# gstreamer and youtube support etc.
apt-get install -q -y libgstreamer1.0-dev libgstreamer-plugins-bad1.0-dev libgstreamer-plugins-base1.0-dev libxvidcore4 gstreamer1.0-plugins-base gstreamer1.0-plugins-good gstreamer1.0-plugins-ugly gstreamer1.0-plugins-bad gstreamer1.0-alsa gstreamer1.0-fluendo-mp3 gstreamer1.0-libav

# brotli
if [ ! -d "brotli" ]; then
  mkdir brotli
  cd brotli
    download_package libbrotli1
    download_package libbrotli-dev
    download_package libwoff1
    download_package libwoff-dev
  cd -
fi
cd brotli
dpkg -i *.deb
cd -

# install webkit
[ -e "./ninja" ] && ./ninja install
