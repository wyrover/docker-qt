FROM dockcross/base:latest

# See: https://github.com/dockcross/dockcross

RUN dpkg --add-architecture armhf

RUN echo "deb http://emdebian.org/tools/debian/ jessie main" >> /etc/apt/sources.list && \
    dpkg --add-architecture armhf && \
    curl http://emdebian.org/tools/debian/emdebian-toolchain-archive.key | apt-key add -

RUN apt-get update

RUN apt-get -y install \
    wget \
    tar \
    coreutils \
    bison \
    build-essential \
    flex \
    gperf \
    perl \
    python \
    ruby \
#    ncurses-dev:armhf \
#    libfl-dev:armhf \
#    gfortran-arm-linux-gnueabihf \
    crossbuild-essential-armhf \
    qt5-qmake \
    libssl-dev:armhf \
    libcrypto++-dev:armhf \
    libc6-dev:armhf \
    libsqlite3-dev:armhf \
#    libmysqlclient-dev:armhf \
#    libpq-dev:armhf \
    ibgstreamer-plugins-base0.10-dev:armhf \
    libasound2-dev:armhf \
    libatkmm-1.6-dev:armhf \
    libbz2-dev:armhf \
    libcap-dev:armhf \
    libcups2-dev:armhf \
    libdrm-dev:armhf \
    libegl1-mesa-dev:armhf \
    libfontconfig1-dev:armhf \
    libfreetype6-dev:armhf \
    libgcrypt20-dev:armhf \
    libglu1-mesa-dev:armhf \
    libgstreamer0.10-dev:armhf \
    libicu-dev:armhf \
    libnss3-dev:armhf \
    libpci-dev:armhf \
    libpulse-dev:armhf \
    libudev-dev:armhf \
    libx11-dev:armhf \
    libx11-xcb-dev:armhf \
    libxcb-composite0:armhf \
    libxcb-composite0-dev:armhf \
    libxcb-cursor-dev:armhf \
    libxcb-cursor0:armhf \
    libxcb-damage0:armhf \
    libxcb-damage0-dev:armhf \
    libxcb-dpms0:armhf \
    libxcb-dpms0-dev:armhf \
    libxcb-dri2-0:armhf \
    libxcb-dri2-0-dev:armhf \
    libxcb-dri3-0:armhf \
    libxcb-dri3-dev:armhf \
    libxcb-ewmh-dev:armhf \
    libxcb-ewmh2:armhf \
    libxcb-glx0:armhf \
    libxcb-glx0-dev:armhf \
    libxcb-icccm4:armhf \
    libxcb-icccm4-dev:armhf \
    libxcb-image0:armhf \
    libxcb-image0-dev:armhf \
    libxcb-keysyms1:armhf \
    libxcb-keysyms1-dev:armhf \
    libxcb-present-dev:armhf \
    libxcb-present0:armhf \
    libxcb-randr0:armhf \
    libxcb-randr0-dev:armhf \
    libxcb-record0:armhf \
    libxcb-record0-dev:armhf \
    libxcb-render-util0:armhf \
    libxcb-render-util0-dev:armhf \
    libxcb-render0:armhf \
    libxcb-render0-dev:armhf \
    libxcb-res0:armhf \
    libxcb-res0-dev:armhf \
    libxcb-screensaver0:armhf \
    libxcb-screensaver0-dev:armhf \
    libxcb-shape0:armhf \
    libxcb-shape0-dev:armhf \
    libxcb-shm0:armhf \
    libxcb-shm0-dev:armhf \
    libxcb-sync-dev:armhf \
    libxcb-sync0-dev:armhf \
    libxcb-sync1:armhf \
#    libxcb-util-dev:armhf \
    libxcb-util0-dev:armhf \
#    libxcb-util1:armhf \
    libxcb-xevie0:armhf \
    libxcb-xevie0-dev:armhf \
    libxcb-xf86dri0:armhf \
    libxcb-xf86dri0-dev:armhf \
    libxcb-xfixes0:armhf \
    libxcb-xfixes0-dev:armhf \
    libxcb-xinerama0:armhf \
    libxcb-xinerama0-dev:armhf \
    libxcb-xkb-dev:armhf \
    libxcb-xkb1:armhf \
    libxcb-xprint0:armhf \
    libxcb-xprint0-dev:armhf \
    libxcb-xtest0:armhf \
    libxcb-xtest0-dev:armhf \
    libxcb-xv0:armhf \
    libxcb-xv0-dev:armhf \
    libxcb-xvmc0:armhf \
    libxcb-xvmc0-dev:armhf \
    libxcb1:armhf \
    libxcb1-dev:armhf \
    libxcomposite-dev:armhf \
    libxcursor-dev:armhf \
    libxdamage-dev:armhf \
    libxext-dev:armhf \
    libxfixes-dev:armhf \
    libxi-dev:armhf \
    libxrandr-dev:armhf \
    libxrender-dev:armhf \
    libxslt-dev:armhf \
    libxss-dev:armhf \
    libxtst-dev:armhf \
    libexpat1-dev:armhf \
    libevdev-dev:armhf \
    libxkbcommon-dev:armhf \
    libxkbcommon-x11-dev:armhf

RUN mkdir /build

WORKDIR /build

RUN wget -q http://download.qt.io/archive/qt/5.8/5.8.0/single/qt-everywhere-opensource-src-5.8.0.tar.gz
RUN tar -zxf qt-everywhere-opensource-src-5.8.0.tar.gz

WORKDIR  /build/qt-everywhere-opensource-src-5.8.0

RUN cp -R qtbase/mkspecs/linux-arm-gnueabi-g++ qtbase/mkspecs/linux-arm-gnueabihf-g++ 

RUN sed -i -E -e 's|arm-linux-gnueabi-(.*)|arm-linux-gnueabihf-\1|g' qtbase/mkspecs/linux-arm-gnueabihf-g++/qmake.conf

RUN ./configure \
    -v \
    -release \
    -xplatform linux-arm-gnueabihf-g++ \
    -opensource \
    -confirm-license \
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
    -no-compile-examples \
    -no-libproxy \
    -no-icu \
    -no-gif \
    -no-journald \
    -no-glib \
    -no-cups \
    -no-iconv \
    -no-tslib \
    -no-kms \
    \
    -qt-xcb \
    -qt-xkbcommon-x11 \
    -qt-zlib \
    -qt-libpng \
    -qt-libjpeg \
    -qt-freetype \
    -qt-harfbuzz \
    -qt-pcre \
    \
#    -sql-mysql \
#    -sql-psql \
    -sqlite \
    \
    -dbus-runtime \
    \
    -openssl-runtime

RUN make -k -j$(nproc --all)
RUN make -k install

RUN update-alternatives --install /usr/bin/qmake qmake /usr/local/Qt-5.8.0/bin/qmake 10

RUN rm -rf /build

RUN mkdir /src
