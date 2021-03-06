#!/bin/bash

GCC_CFLAGS=""
GCC_CPPFLAGS=""
GCC_LDFLAGS=""
GCC_HOST=""
GCC_BUILD=""
GCC_TARGET=""
TARGET_ARCH="armhf"
TARGET_ARCH_CC="gnueabihf"
TARGET_ARCH_HOST="arm-linux-"$TARGET_ARCH_CC
TARGET_PREFIX="/usr/local"

dpkg --add-architecture $TARGET_ARCH

echo "deb http://emdebian.org/tools/debian/ jessie main" >> /etc/apt/sources.list

curl http://emdebian.org/tools/debian/emdebian-toolchain-archive.key | apt-key add -

apt-get update

apt-get -y install --no-install-recommends \
    \
    tar \
    git \
    wget \
    flex \
    gperf \
    bison \
    coreutils \
    subversion \
    dh-autoreconf \
    \
    perl \
    ruby \
    python \
    \
    build-essential \
    \
    crossbuild-essential-$TARGET_ARCH \
    \
    libc6-dev:$TARGET_ARCH \
    \
    libxcb-composite0:$TARGET_ARCH \
    libxcb-composite0-dev:$TARGET_ARCH \
    libxcb-cursor-dev:$TARGET_ARCH \
    libxcb-cursor0:$TARGET_ARCH \
    libxcb-damage0:$TARGET_ARCH \
    libxcb-damage0-dev:$TARGET_ARCH \
    libxcb-dpms0:$TARGET_ARCH \
    libxcb-dpms0-dev:$TARGET_ARCH \
    libxcb-dri2-0:$TARGET_ARCH \
    libxcb-dri2-0-dev:$TARGET_ARCH \
    libxcb-dri3-0:$TARGET_ARCH \
    libxcb-dri3-dev:$TARGET_ARCH \
    libxcb-ewmh-dev:$TARGET_ARCH \
    libxcb-ewmh2:$TARGET_ARCH \
    libxcb-glx0:$TARGET_ARCH \
    libxcb-glx0-dev:$TARGET_ARCH \
    libxcb-present-dev:$TARGET_ARCH \
    libxcb-present0:$TARGET_ARCH \
    libxcb-record0:$TARGET_ARCH \
    libxcb-record0-dev:$TARGET_ARCH \
    libxcb-render-util0:$TARGET_ARCH \
    libxcb-render-util0-dev:$TARGET_ARCH \
    libxcb-render0:$TARGET_ARCH \
    libxcb-render0-dev:$TARGET_ARCH \
    libxcb-res0:$TARGET_ARCH \
    libxcb-res0-dev:$TARGET_ARCH \
    libxcb-screensaver0:$TARGET_ARCH \
    libxcb-screensaver0-dev:$TARGET_ARCH \
    libxcb-sync-dev:$TARGET_ARCH \
    libxcb-sync0-dev:$TARGET_ARCH \
    libxcb-sync1:$TARGET_ARCH \
    libxcb-util0-dev:$TARGET_ARCH \
    libxcb-xevie0:$TARGET_ARCH \
    libxcb-xevie0-dev:$TARGET_ARCH \
    libxcb-xf86dri0:$TARGET_ARCH \
    libxcb-xf86dri0-dev:$TARGET_ARCH \
    libxcb-xprint0:$TARGET_ARCH \
    libxcb-xprint0-dev:$TARGET_ARCH \
    libxcb-xtest0:$TARGET_ARCH \
    libxcb-xtest0-dev:$TARGET_ARCH \
    libxcb-xv0:$TARGET_ARCH \
    libxcb-xv0-dev:$TARGET_ARCH \
    libxcb-xvmc0:$TARGET_ARCH \
    libxcb-xvmc0-dev:$TARGET_ARCH \
    libxcb1:$TARGET_ARCH \
    libxcb1-dev:$TARGET_ARCH \
    \
    libx11-dev:$TARGET_ARCH \
    libx11-xcb-dev:$TARGET_ARCH \
    \
    libxcomposite-dev:$TARGET_ARCH \
    libxcursor-dev:$TARGET_ARCH \
    libxdamage-dev:$TARGET_ARCH \
    libxext-dev:$TARGET_ARCH \
    libxfixes-dev:$TARGET_ARCH \
    libxi-dev:$TARGET_ARCH \
    libxrandr-dev:$TARGET_ARCH \
    libxrender-dev:$TARGET_ARCH \
    libxslt-dev:$TARGET_ARCH \
    libxss-dev:$TARGET_ARCH \
    libxtst-dev:$TARGET_ARCH \
    \
    libxkbcommon-dev:$TARGET_ARCH \
    libxkbcommon-x11-dev:$TARGET_ARCH \
    \
    libfontconfig1-dev:$TARGET_ARCH \
    libfreetype6-dev:$TARGET_ARCH \
    \
    libegl1-mesa-dev:$TARGET_ARCH \
    libglu1-mesa-dev:$TARGET_ARCH \
    \
    libudev-dev:$TARGET_ARCH \
    libevdev-dev:$TARGET_ARCH

mkdir -p /build

# +++++++++++++++++++++++++++++++++++++++++++
# + ZLIB
# +++++++++++++++++++++++++++++++++++++++++++

cd /build

wget -q http://www.zlib.net/zlib-1.2.11.tar.gz
tar -zxf zlib-1.2.11.tar.gz

cd /build/zlib-1.2.11

CFLAGS=$GCC_CFLAGS \
CPPFLAGS=$GCC_CPPFLAGS \
LDFLAGS=$GCC_LDFLAGS \
CHOST=$TARGET_ARCH_HOST \
    ./configure \
    --static

make -j$(nproc --all)
make install

# +++++++++++++++++++++++++++++++++++++++++++
# + OPENSSL
# +++++++++++++++++++++++++++++++++++++++++++

cd /build

wget -q https://openssl.org/source/openssl-1.0.2k.tar.gz
tar -zxf openssl-1.0.2k.tar.gz

cd /build/openssl-1.0.2k

CC=$TARGET_ARCH_HOST-gcc \
AR=$TARGET_ARCH_HOST"-ar rcu" \
RANLIB=$TARGET_ARCH_HOST"-ranlib" \
LD=$TARGET_ARCH_HOST"-ld" \
    ./Configure \
    linux-armv4 \
    $GCC_CFLAGS \
    no-shared \
    no-capieng \
    zlib \
    no-zlib-dynamic \
    --with-zlib-include=/usr/local/lib/include \
    --with-zlib-lib=/usr/local/lib

make all -j1 \
    CC=$TARGET_ARCH_HOST"-gcc" \
    AR=$TARGET_ARCH_HOST"-ar rcu" \
    RANLIB=$TARGET_ARCH_HOST"-ranlib" \
    LD=$TARGET_ARCH_HOST"-ld"

make install_sw

# +++++++++++++++++++++++++++++++++++++++++++
# + QT
# +++++++++++++++++++++++++++++++++++++++++++

cd /build

wget -q http://download.qt.io/archive/qt/5.8/5.8.0/single/qt-everywhere-opensource-src-5.8.0.tar.gz
tar -zxf qt-everywhere-opensource-src-5.8.0.tar.gz

cd /build/qt-everywhere-opensource-src-5.8.0

cp -R qtbase/mkspecs/linux-arm-gnueabi-g++ qtbase/mkspecs/linux-arm-$TARGET_ARCH_CC-g++ 
sed -i -E -e 's|arm-linux-gnueabi-(.*)|arm-linux-'$TARGET_ARCH_CC'-\1|g' qtbase/mkspecs/linux-arm-$TARGET_ARCH_CC-g++/qmake.conf

PKG_CONFIG="/usr/bin/pkg-config" \
PKG_CONFIG_PATH=""$TARGET_PREFIX"/ssl/lib/pkgconfig/:"$TARGET_PREFIX"/lib/pkgconfig/:/usr/lib/"$TARGET_ARCH_HOST"/pkgconfig/" \
PKG_CONFIG_LIBDIR=""$TARGET_PREFIX"/ssl/lib/:"$TARGET_PREFIX"/lib/" \
PKG_CONFIG_SYSROOT_DIR="/" \
OPENSSL_LIBS="-L"$TARGET_PREFIX"/ssl/lib -L"$TARGET_PREFIX"/lib -lssl -lcrypto -ldl -lz" \
    ./configure \
    -v \
    -static \
    -release \
    -xplatform linux-arm-$TARGET_ARCH_CC-g++ \
    -c++std c++11 \
    -opensource \
    -confirm-license \
    -force-pkg-config \
    -sysroot / \
    \
    -skip qt3d \
    -skip qtactiveqt \
    -skip qtcanvas3d \
    -skip qtconnectivity \
    -skip qtdeclarative \
    -skip qtgamepad \
    -skip qtgraphicaleffects \
    -skip qtpurchasing \
    -skip qtquickcontrols \
    -skip qtquickcontrols2 \
    -skip qtscript \
    -skip qtscxml \
    -skip qtsensors \
    -skip qtserialbus \
    -skip qttools \
    -skip qtwayland \
    -skip qtwebchannel \
    -skip qtwebkit \
    -skip qtwebsockets \
    -skip qtwebview \
    -skip qtxmlpatterns \
    -skip qtwinextras \
    \
    -nomake examples \
    -nomake tests \
    \
    -no-use-gold-linker \
    -no-compile-examples \
    -no-libproxy \
    -no-icu \
    -no-gif \
    -no-journald \
    -no-glib \
    -no-cups \
    -no-iconv \
    -no-tslib \
    \
    -qt-xcb \
    -qt-xkbcommon-x11 \
    -qt-pcre \
    -qt-libjpeg \
    -qt-libpng \
    -qt-harfbuzz \
    -fontconfig \
    \
    -qt-sqlite \
    -no-sql-mysql \
    -no-sql-psql \
    \
    -openssl-linked \
    \
    -no-dbus \
    \
    -I""$TARGET_PREFIX"/ssl/include/" \
    -I""$TARGET_PREFIX"/include/" \
    -I"/usr/include"

make -j$(nproc --all)
make install

update-alternatives --install /usr/bin/qmake qmake $TARGET_PREFIX/Qt-5.8.0/bin/qmake 10

rm -rf /build

mkdir /src