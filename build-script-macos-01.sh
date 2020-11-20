#!/usr/bin/env bash

set -eE

PRODUCT_NAME="OBS Pre-Built Dependencies"

COLOR_RED=$(tput setaf 1)
COLOR_GREEN=$(tput setaf 2)
COLOR_BLUE=$(tput setaf 4)
COLOR_ORANGE=$(tput setaf 3)
COLOR_RESET=$(tput sgr0)

export MAC_QT_VERSION="5.14.1"
export WIN_QT_VERSION="5.10"
export LIBPNG_VERSION="1.6.37"
export LIBOPUS_VERSION="1.3.1"
export LIBOGG_VERSION="68ca3841567247ac1f7850801a164f58738d8df9"
export LIBVORBIS_VERSION="1.3.6"
export LIBVPX_VERSION="1.8.2"
export LIBJANSSON_VERSION="2.12"
export LIBX264_VERSION="origin/stable"
export LIBMBEDTLS_VERSION="2.16.5"
export LIBSRT_VERSION="1.4.1"
export FFMPEG_VERSION="4.2.2"
export LIBLUAJIT_VERSION="2.1.0-beta3"
export LIBFREETYPE_VERSION="2.10.1"
export SWIG_VERSION="3.0.12"
export MACOSX_DEPLOYMENT_TARGET="10.13"
export PATH="/usr/local/opt/ccache/libexec:${PATH}"
export CURRENT_DATE="$(date +"%Y-%m-%d")"
export PKG_CONFIG_PATH="$PKG_CONFIG_PATH:/tmp/obsdeps/lib/pkgconfig"
export PARALLELISM="$(sysctl -n hw.ncpu)"

hr() {
     echo -e "${COLOR_BLUE}[${PRODUCT_NAME}] ${1}${COLOR_RESET}"
}

step() {
    echo -e "${COLOR_GREEN}  + ${1}${COLOR_RESET}"
}

info() {
    echo -e "${COLOR_ORANGE}  + ${1}${COLOR_RESET}"
}

error() {
     echo -e "${COLOR_RED}  + ${1}${COLOR_RESET}"
}

exists() {
    command -v "${1}" >/dev/null 2>&1
}

ensure_dir() {
    [[ -n ${1} ]] && /bin/mkdir -p ${1} && builtin cd ${1}
}

cleanup() {
    :
}

mkdir() {
    /bin/mkdir -p $*
}

trap cleanup EXIT

caught_error() {
    error "ERROR during build step: ${1}"
    cleanup $/Users/drboxman/Development/obs-deps
    exit 1
}

build_24c74de7-83dd-450e-a9c0-e460f052c1a1() {
    step "Install Homebrew dependencies"
    trap "caught_error 'Install Homebrew dependencies'" ERR
    ensure_dir /Users/drboxman/Development/obs-deps

    #brew bundle
}


build_109d61e0-0487-42e4-9ad4-f7c5e5603f84() {
    step "Get Current Date"
    trap "caught_error 'Get Current Date'" ERR
    ensure_dir /Users/drboxman/Development/obs-deps


}


build_1318ef77-6dd1-4ce2-8d86-b1dc8b32c0ad() {
    step "Build environment setup"
    trap "caught_error 'Build environment setup'" ERR
    ensure_dir /Users/drboxman/Development/obs-deps

    mkdir -p CI_BUILD/obsdeps/bin
    mkdir -p CI_BUILD/obsdeps/include
    mkdir -p CI_BUILD/obsdeps/lib
    mkdir -p CI_BUILD/obsdeps/share
    
    
}


build_60e4a310-309e-4991-a06d-0342c1d7f829() {
    step "Build dependency swig"
    trap "caught_error 'Build dependency swig'" ERR
    ensure_dir /Users/drboxman/Development/obs-deps/CI_BUILD

    curl --retry 5 -L -O "https://downloads.sourceforge.net/project/swig/swig/swig-${SWIG_VERSION}/swig-${SWIG_VERSION}.tar.gz"
    tar -xf swig-${SWIG_VERSION}.tar.gz
    cd swig-${SWIG_VERSION}
    mkdir build
    cd build
    ../configure --disable-dependency-tracking --prefix="/tmp/obsdeps"
    make -j${PARALLELISM}
}


build_214e89e6-7493-4565-8c0f-56db110e7d69() {
    step "Install dependency swig"
    trap "caught_error 'Install dependency swig'" ERR
    ensure_dir /Users/drboxman/Development/obs-deps/CI_BUILD/swig-3.0.12/build

    cp swig /Users/drboxman/Development/obs-deps/CI_BUILD/obsdeps/bin/
    mkdir -p /Users/drboxman/Development/obs-deps/CI_BUILD/obsdeps/share/swig/${SWIG_VERSION}
    rsync -avh --include="*.i" --include="*.swg" --include="python" --include="lua" --include="typemaps" --exclude="*" ../Lib/* /Users/drboxman/Development/obs-deps/CI_BUILD/obsdeps/share/swig/${SWIG_VERSION}
}


build_616dc0b8-503d-4b14-9acf-b8aea07403d7() {
    step "Build dependency libpng"
    trap "caught_error 'Build dependency libpng'" ERR
    ensure_dir /Users/drboxman/Development/obs-deps/CI_BUILD

    curl --retry 5 -L -O "https://downloads.sourceforge.net/project/libpng/libpng16/${LIBPNG_VERSION}/libpng-${LIBPNG_VERSION}.tar.xz"
    tar -xf libpng-${LIBPNG_VERSION}.tar.xz
    cd libpng-${LIBPNG_VERSION}
    mkdir build
    cd build
    ../configure --enable-static --disable-shared --prefix="/tmp/obsdeps"
    make -j${PARALLELISM}
}


build_dac7ea30-8185-41f3-a883-4dc831cbcf82() {
    step "Install dependency libpng"
    trap "caught_error 'Install dependency libpng'" ERR
    ensure_dir /Users/drboxman/Development/obs-deps/CI_BUILD/libpng-1.6.37/build

    make install
}


build_736704c6-9e3c-4c04-8d8a-07d894f0e02d() {
    step "Build dependency libopus"
    trap "caught_error 'Build dependency libopus'" ERR
    ensure_dir /Users/drboxman/Development/obs-deps/CI_BUILD

    curl --retry 5 -L -C - -O "https://ftp.osuosl.org/pub/xiph/releases/opus/opus-${LIBOPUS_VERSION}.tar.gz"
    tar -xf opus-${LIBOPUS_VERSION}.tar.gz
    cd ./opus-${LIBOPUS_VERSION}
    mkdir build
    cd ./build
    ../configure --disable-shared --enable-static --prefix="/tmp/obsdeps"
    make -j${PARALLELISM}
}


build_b7c59d8d-19e8-4408-9963-035df21b4b00() {
    step "Install dependency libopus"
    trap "caught_error 'Install dependency libopus'" ERR
    ensure_dir /Users/drboxman/Development/obs-deps/CI_BUILD/opus-1.3.1/build

    make install
}


build_77c5667a-17d4-4cf8-9541-fa9ea8d3d405() {
    step "Build dependency libogg"
    trap "caught_error 'Build dependency libogg'" ERR
    ensure_dir /Users/drboxman/Development/obs-deps/CI_BUILD

    curl --retry 5 -L -O https://gitlab.xiph.org/xiph/ogg/-/archive/${LIBOGG_VERSION}/ogg-${LIBOGG_VERSION}.tar.gz
    tar -xf ogg-${LIBOGG_VERSION}.tar.gz
    cd ./ogg-${LIBOGG_VERSION}
    mkdir build
    libtoolize
    ./autogen.sh
    cd ./build
    ../configure --disable-shared --enable-static --prefix="/tmp/obsdeps"
    make -j${PARALLELISM}
}


build_168bba09-31de-4607-adc7-c8649f51d6b9() {
    step "Install dependency libogg"
    trap "caught_error 'Install dependency libogg'" ERR
    ensure_dir /Users/drboxman/Development/obs-deps/CI_BUILD/ogg-68ca3841567247ac1f7850801a164f58738d8df9/build

    make install
}


build_202f0f82-0acc-40d0-a0e3-130639da2da3() {
    step "Build dependency libvorbis"
    trap "caught_error 'Build dependency libvorbis'" ERR
    ensure_dir /Users/drboxman/Development/obs-deps/CI_BUILD

    curl --retry 5 -L -C - -O "https://ftp.osuosl.org/pub/xiph/releases/vorbis/libvorbis-${LIBVORBIS_VERSION}.tar.gz"
    tar -xf libvorbis-${LIBVORBIS_VERSION}.tar.gz
    cd ./libvorbis-${LIBVORBIS_VERSION}
    mkdir build
    cd ./build
    ../configure --disable-shared --enable-static --prefix="/tmp/obsdeps"
    make -j${PARALLELISM}
}


build_f54e0cb2-11c8-461b-a3fa-2f1999212660() {
    step "Install dependency libvorbis"
    trap "caught_error 'Install dependency libvorbis'" ERR
    ensure_dir /Users/drboxman/Development/obs-deps/CI_BUILD/libvorbis-1.3.6/build

    make install
}


build_aa890fdd-808b-4817-884f-0c2cdd0dedb8() {
    step "Build dependency libvpx"
    trap "caught_error 'Build dependency libvpx'" ERR
    ensure_dir /Users/drboxman/Development/obs-deps/CI_BUILD

    curl --retry 5 -L -O "https://chromium.googlesource.com/webm/libvpx/+archive/v${LIBVPX_VERSION}.tar.gz"
    mkdir -p ./libvpx-v${LIBVPX_VERSION}
    tar -xf v${LIBVPX_VERSION}.tar.gz -C $PWD/libvpx-v${LIBVPX_VERSION}
    cd ./libvpx-v${LIBVPX_VERSION}
    mkdir -p build
    cd ./build
    ../configure --disable-shared --prefix="/tmp/obsdeps" --libdir="/tmp/obsdeps/lib"
    make -j${PARALLELISM}
}


build_4a66ea61-0ddd-4de9-b9d5-ce9422dfad20() {
    step "Install dependency libvpx"
    trap "caught_error 'Install dependency libvpx'" ERR
    ensure_dir /Users/drboxman/Development/obs-deps/CI_BUILD/libvpx-v1.8.2/build

    make install
}


build_24b99c5e-8540-48e4-bf51-106937c7f7b2() {
    step "Build dependency libjansson"
    trap "caught_error 'Build dependency libjansson'" ERR
    ensure_dir /Users/drboxman/Development/obs-deps/CI_BUILD

    curl --retry 5 -L -C - -O http://www.digip.org/jansson/releases/jansson-${LIBJANSSON_VERSION}.tar.gz
    tar -xf jansson-${LIBJANSSON_VERSION}.tar.gz
    cd jansson-${LIBJANSSON_VERSION}
    mkdir build
    cd ./build
    ../configure --libdir="/tmp/obsdeps/bin" --enable-shared --disable-static
    make -j${PARALLELISM}
}


build_214b4eaa-3733-4326-9580-6772055a38f2() {
    step "Install dependency libjansson"
    trap "caught_error 'Install dependency libjansson'" ERR
    ensure_dir /Users/drboxman/Development/obs-deps/CI_BUILD/jansson-2.12/build

    find . -name \*.dylib -exec cp -PR \{\} /Users/drboxman/Development/obs-deps/CI_BUILD/obsdeps/bin/ \;
    rsync -avh --include="*/" --include="*.h" --exclude="*" ../src/* /Users/drboxman/Development/obs-deps/CI_BUILD/obsdeps/include/
    rsync -avh --include="*/" --include="*.h" --exclude="*" ./src/* /Users/drboxman/Development/obs-deps/CI_BUILD/obsdeps/include/
    cp ./*.h /Users/drboxman/Development/obs-deps/CI_BUILD/obsdeps/include/
}


build_c268bbba-76e6-4679-bfb4-a44a69df7b45() {
    step "Build dependency libx264"
    trap "caught_error 'Build dependency libx264'" ERR
    ensure_dir /Users/drboxman/Development/obs-deps/CI_BUILD

    if [ ! -d ./x264 ]; then git clone https://code.videolan.org/videolan/x264.git; fi
    cd ./x264
    git checkout master
    mkdir build
    cd ./build
    ../configure --enable-static --prefix="/tmp/obsdeps"  --host=aarch64-darwin
    make 
}


build_b4d6f584-cd5c-4d3e-a56c-732bd40544ee() {
    step "Install dependency libx264"
    trap "caught_error 'Install dependency libx264'" ERR
    ensure_dir /Users/drboxman/Development/obs-deps/CI_BUILD/x264/build

    make install
}


build_dc827b70-c5d0-42a9-8c9d-838b7856cff1() {
    step "Build dependency libx264 (dylib)"
    trap "caught_error 'Build dependency libx264 (dylib)'" ERR
    ensure_dir /Users/drboxman/Development/obs-deps/CI_BUILD/x264/build

    ../configure --enable-shared --libdir="/tmp/obsdeps/bin" --prefix="/tmp/obsdeps" --host=aarch64-darwin
    make -j${PARALLELISM}
}


build_91632439-99cd-4db4-a33b-543af62d0ee3() {
    step "Install dependency libx264 (dylib)"
    trap "caught_error 'Install dependency libx264 (dylib)'" ERR
    ensure_dir /Users/drboxman/Development/obs-deps/CI_BUILD/x264/build

    ln -f -s libx264.*.dylib libx264.dylib
    find . -name \*.dylib -exec cp -PR \{\} /Users/drboxman/Development/obs-deps/CI_BUILD/obsdeps/bin/ \;
    rsync -avh --include="*/" --include="*.h" --exclude="*" ../* /Users/drboxman/Development/obs-deps/CI_BUILD/obsdeps/include/
    rsync -avh --include="*/" --include="*.h" --exclude="*" ./* /Users/drboxman/Development/obs-deps/CI_BUILD/obsdeps/include/
}


build_bdd92c6e-d9ff-4674-926d-8205bf1e2cb4() {
    step "Build dependency libmbedtls"
    trap "caught_error 'Build dependency libmbedtls'" ERR
    ensure_dir /Users/drboxman/Development/obs-deps/CI_BUILD

    curl --retry 5 -L -C - -O https://tls.mbed.org/download/mbedtls-${LIBMBEDTLS_VERSION}-gpl.tgz
    tar -xf mbedtls-${LIBMBEDTLS_VERSION}-gpl.tgz
    cd mbedtls-${LIBMBEDTLS_VERSION}
    sed -i '.orig' 's/\/\/\#define MBEDTLS_THREADING_PTHREAD/\#define MBEDTLS_THREADING_PTHREAD/g' include/mbedtls/config.h
    sed -i '.orig' 's/\/\/\#define MBEDTLS_THREADING_C/\#define MBEDTLS_THREADING_C/g' include/mbedtls/config.h
    mkdir build
    cd ./build
    cmake -DCMAKE_INSTALL_PREFIX="/tmp/obsdeps" -DUSE_SHARED_MBEDTLS_LIBRARY=ON -DENABLE_PROGRAMS=OFF ..
    make -j${PARALLELISM}
}


build_828016c7-6beb-4a9d-9426-4f5ebc4d25e1() {
    step "Install dependency libmbedtls"
    trap "caught_error 'Install dependency libmbedtls'" ERR
    ensure_dir /Users/drboxman/Development/obs-deps/CI_BUILD/mbedtls-2.16.5/build

    make install
    install_name_tool -id /tmp/obsdeps/lib/libmbedtls.${LIBMBEDTLS_VERSION}.dylib /tmp/obsdeps/lib/libmbedtls.${LIBMBEDTLS_VERSION}.dylib
    install_name_tool -id /tmp/obsdeps/lib/libmbedcrypto.${LIBMBEDTLS_VERSION}.dylib /tmp/obsdeps/lib/libmbedcrypto.${LIBMBEDTLS_VERSION}.dylib
    install_name_tool -id /tmp/obsdeps/lib/libmbedx509.${LIBMBEDTLS_VERSION}.dylib /tmp/obsdeps/lib/libmbedx509.${LIBMBEDTLS_VERSION}.dylib
    install_name_tool -change libmbedx509.0.dylib /tmp/obsdeps/lib/libmbedx509.0.dylib /tmp/obsdeps/lib/libmbedtls.${LIBMBEDTLS_VERSION}.dylib
    install_name_tool -change libmbedcrypto.3.dylib /tmp/obsdeps/lib/libmbedcrypto.3.dylib /tmp/obsdeps/lib/libmbedtls.${LIBMBEDTLS_VERSION}.dylib
    install_name_tool -change libmbedcrypto.3.dylib /tmp/obsdeps/lib/libmbedcrypto.3.dylib /tmp/obsdeps/lib/libmbedx509.${LIBMBEDTLS_VERSION}.dylib
    find /tmp/obsdeps/lib -name libmbed\*.dylib -exec cp -PR \{\} /Users/drboxman/Development/obs-deps/CI_BUILD/obsdeps/lib/ \;
    rsync -avh --include="*/" --include="*.h" --exclude="*" ./include/mbedtls/* /Users/drboxman/Development/obs-deps/CI_BUILD/obsdeps/include/mbedtls
    rsync -avh --include="*/" --include="*.h" --exclude="*" ../include/mbedtls/* /Users/drboxman/Development/obs-deps/CI_BUILD/obsdeps/include/mbedtls
    if [ ! -d /tmp/obsdeps/lib/pkgconfig ]; then
        mkdir -p /tmp/obsdeps/lib/pkgconfig
    fi
    cat <<EOF > /tmp/obsdeps/lib/pkgconfig/mbedcrypto.pc
prefix=/tmp/obsdeps
libdir=\${prefix}/lib
includedir=\${prefix}/include
 
Name: mbedcrypto
Description: lightweight crypto and SSL/TLS library.
Version: ${LIBMBEDTLS_VERSION}
 
Libs: -L\${libdir} -lmbedcrypto
Cflags: -I\${includedir}
 
EOF
    cat <<EOF > /tmp/obsdeps/lib/pkgconfig/mbedtls.pc
prefix=/tmp/obsdeps
libdir=\${prefix}/lib
includedir=\${prefix}/include
 
Name: mbedtls
Description: lightweight crypto and SSL/TLS library.
Version: ${LIBMBEDTLS_VERSION}
 
Libs: -L\${libdir} -lmbedtls
Cflags: -I\${includedir}
Requires.private: mbedx509
 
EOF
    cat <<EOF > /tmp/obsdeps/lib/pkgconfig/mbedx509.pc
prefix=/tmp/obsdeps
libdir=\${prefix}/lib
includedir=\${prefix}/include
 
Name: mbedx509
Description: The mbedTLS X.509 library
Version: ${LIBMBEDTLS_VERSION}
 
Libs: -L\${libdir} -lmbedx509
Cflags: -I\${includedir}
Requires.private: mbedcrypto
 
EOF
}


build_97814d42-0944-46a8-976b-2abf0a3ced29() {
    step "Build dependency libsrt"
    trap "caught_error 'Build dependency libsrt'" ERR
    ensure_dir /Users/drboxman/Development/obs-deps/CI_BUILD

    curl --retry 5 -L -O https://github.com/Haivision/srt/archive/v${LIBSRT_VERSION}.tar.gz
    tar -xf v${LIBSRT_VERSION}.tar.gz
    cd srt-${LIBSRT_VERSION}
    mkdir build
    cd ./build
    cmake -DCMAKE_INSTALL_PREFIX="/tmp/obsdeps" -DENABLE_APPS=OFF -DUSE_ENCLIB="mbedtls" -DENABLE_STATIC=ON -DENABLE_SHARED=OFF -DSSL_INCLUDE_DIRS="/tmp/obsdeps/include" -DSSL_LIBRARY_DIRS="/tmp/obsdeps/lib" -DCMAKE_FIND_FRAMEWORK=LAST ..
    make -j${PARALLELISM}
}


build_60311792-3954-4d47-9ce4-f5b1b6db5ce9() {
    step "Install dependency libsrt"
    trap "caught_error 'Install dependency libsrt'" ERR
    ensure_dir /Users/drboxman/Development/obs-deps/CI_BUILD/srt-1.4.1/build

    make install
}


build_25fc9ffd-429f-47e4-ac66-97ba4e434b97() {
    step "Build dependency ffmpeg"
    trap "caught_error 'Build dependency ffmpeg'" ERR
    ensure_dir /Users/drboxman/Development/obs-deps/CI_BUILD

    export LDFLAGS="-L/tmp/obsdeps/lib"
    export CFLAGS="-I/tmp/obsdeps/include"
    export LD_LIBRARY_PATH="/tmp/obsdeps/lib"
    
    # FFMPEG
    curl --retry 5 -L -O https://github.com/FFmpeg/FFmpeg/archive/n${FFMPEG_VERSION}.zip
    unzip -q -u ./n${FFMPEG_VERSION}.zip
    cd ./FFmpeg-n${FFMPEG_VERSION}
    mkdir build
    cd ./build
    ../configure --pkg-config-flags="--static" --extra-ldflags="-mmacosx-version-min=${MACOSX_DEPLOYMENT_TARGET}" --enable-shared --disable-static --shlibdir="/tmp/obsdeps/bin" --enable-gpl --disable-doc --enable-libx264 --enable-libopus --enable-libvpx --enable-libsrt --disable-outdev=sdl
    make -j${PARALLELISM}
}


build_66bcd9f6-e59e-4323-b8d2-0dc052424dec() {
    step "Install dependency ffmpeg"
    trap "caught_error 'Install dependency ffmpeg'" ERR
    ensure_dir /Users/drboxman/Development/obs-deps/CI_BUILD/FFmpeg-n4.2.2/build

    find . -name \*.dylib -exec cp -PR \{\} /Users/drboxman/Development/obs-deps/CI_BUILD/obsdeps/bin/ \;
    rsync -avh --include="*/" --include="*.h" --exclude="*" ../* /Users/drboxman/Development/obs-deps/CI_BUILD/obsdeps/include/
    rsync -avh --include="*/" --include="*.h" --exclude="*" ./* /Users/drboxman/Development/obs-deps/CI_BUILD/obsdeps/include/
}


build_0d0d759a-7b65-48e0-8d22-4e5e9f83c37d() {
    step "Build dependency libluajit"
    trap "caught_error 'Build dependency libluajit'" ERR
    ensure_dir /Users/drboxman/Development/obs-deps/CI_BUILD

    curl --retry 5 -L -C - -O https://LuaJIT.org/download/LuaJIT-${LIBLUAJIT_VERSION}.tar.gz
    tar -xf LuaJIT-${LIBLUAJIT_VERSION}.tar.gz
    cd LuaJIT-${LIBLUAJIT_VERSION}
    make PREFIX="/tmp/obsdeps" -j${PARALLELISM}
}


build_e770129c-9a50-49ba-9d50-85673319cab3() {
    step "Install dependency libluajit"
    trap "caught_error 'Install dependency libluajit'" ERR
    ensure_dir /Users/drboxman/Development/obs-deps/CI_BUILD/LuaJIT-2.1.0-beta3

    make PREFIX="/tmp/obsdeps" install
    find /tmp/obsdeps/lib -name libluajit\*.dylib -exec cp -PR \{\} /Users/drboxman/Development/obs-deps/CI_BUILD/obsdeps/lib/ \;
    rsync -avh --include="*/" --include="*.h" --exclude="*" src/* /Users/drboxman/Development/obs-deps/CI_BUILD/obsdeps/include/
    make PREFIX="/tmp/obsdeps" uninstall
}


build_0800b2ad-0121-498f-b61c-e1b2c9a57551() {
    step "Build dependency libfreetype"
    trap "caught_error 'Build dependency libfreetype'" ERR
    ensure_dir /Users/drboxman/Development/obs-deps/CI_BUILD

    export CFLAGS="-mmacosx-version-min=${MACOSX_DEPLOYMENT_TARGET}"
    
    curl --retry 5 -L -C - -O "https://download.savannah.gnu.org/releases/freetype/freetype-${LIBFREETYPE_VERSION}.tar.gz"
    tar -xf freetype-${LIBFREETYPE_VERSION}.tar.gz
    cd freetype-${LIBFREETYPE_VERSION}
    mkdir build
    cd build
    ../configure --enable-shared --disable-static --prefix="/tmp/obsdeps" --enable-freetype-config --without-harfbuzz
    make -j${PARALLELISM}
}


build_123f0cb3-c636-4b7a-9d82-9108cd3797b0() {
    step "Install dependency libfreetype"
    trap "caught_error 'Install dependency libfreetype'" ERR
    ensure_dir /Users/drboxman/Development/obs-deps/CI_BUILD/freetype-2.10.1/build

    make install
    find /tmp/obsdeps/lib -name libfreetype\*.dylib -exec cp -PR \{\} /Users/drboxman/Development/obs-deps/CI_BUILD/obsdeps/lib/ \;
    rsync -avh --include="*/" --include="*.h" --exclude="*" ../include/* /Users/drboxman/Development/obs-deps/CI_BUILD/obsdeps/include/
    unset CFLAGS
}


build_63216996-248b-4fe4-85b8-2431378de619() {
    step "Package dependencies"
    trap "caught_error 'Package dependencies'" ERR
    ensure_dir /Users/drboxman/Development/obs-deps/CI_BUILD

    tar -czf macos-deps-${CURRENT_DATE}.tar.gz obsdeps
    if [ ! -d "/Users/drboxman/Development/obs-deps/macos" ]; then
      mkdir /Users/drboxman/Development/obs-deps/macos
    fi
    mv ./macos-deps-${CURRENT_DATE}.tar.gz /Users/drboxman/Development/obs-deps/macos
}


obs-deps-build-main() {
    ensure_dir /Users/drboxman/Development/obs-deps

    build_24c74de7-83dd-450e-a9c0-e460f052c1a1
    build_109d61e0-0487-42e4-9ad4-f7c5e5603f84
    build_1318ef77-6dd1-4ce2-8d86-b1dc8b32c0ad
    build_60e4a310-309e-4991-a06d-0342c1d7f829
    build_214e89e6-7493-4565-8c0f-56db110e7d69
    build_616dc0b8-503d-4b14-9acf-b8aea07403d7
    build_dac7ea30-8185-41f3-a883-4dc831cbcf82
    build_736704c6-9e3c-4c04-8d8a-07d894f0e02d
    build_b7c59d8d-19e8-4408-9963-035df21b4b00
    #build_77c5667a-17d4-4cf8-9541-fa9ea8d3d405
    #build_168bba09-31de-4607-adc7-c8649f51d6b9
    #build_202f0f82-0acc-40d0-a0e3-130639da2da3
    #build_f54e0cb2-11c8-461b-a3fa-2f1999212660
    build_aa890fdd-808b-4817-884f-0c2cdd0dedb8
    build_4a66ea61-0ddd-4de9-b9d5-ce9422dfad20
    build_24b99c5e-8540-48e4-bf51-106937c7f7b2
    build_214b4eaa-3733-4326-9580-6772055a38f2
    build_c268bbba-76e6-4679-bfb4-a44a69df7b45
    build_b4d6f584-cd5c-4d3e-a56c-732bd40544ee
    build_dc827b70-c5d0-42a9-8c9d-838b7856cff1
    build_91632439-99cd-4db4-a33b-543af62d0ee3
    build_bdd92c6e-d9ff-4674-926d-8205bf1e2cb4
    build_828016c7-6beb-4a9d-9426-4f5ebc4d25e1
    build_97814d42-0944-46a8-976b-2abf0a3ced29
    build_60311792-3954-4d47-9ce4-f5b1b6db5ce9
    build_25fc9ffd-429f-47e4-ac66-97ba4e434b97
    build_66bcd9f6-e59e-4323-b8d2-0dc052424dec
    build_0d0d759a-7b65-48e0-8d22-4e5e9f83c37d
    build_e770129c-9a50-49ba-9d50-85673319cab3
    build_0800b2ad-0121-498f-b61c-e1b2c9a57551
    build_123f0cb3-c636-4b7a-9d82-9108cd3797b0
    build_63216996-248b-4fe4-85b8-2431378de619

    hr "All Done"
}

obs-deps-build-main $*