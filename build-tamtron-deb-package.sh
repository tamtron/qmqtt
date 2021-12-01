#!/bin/bash

set -e

build_dir=build-qmqtt-release

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cd $script_dir/../
set +e
rm -rf $build_dir
set -e
mkdir $build_dir
cd $build_dir
cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=./debian/opt/tamtron/puntari/qmqtt ../qmqtt/
make -j8
make install
cp -r debian/opt $script_dir/debian
cd $script_dir
fakeroot dpkg-deb --build debian
version=$(grep Version debian/DEBIAN/control | awk '{ print $2; }')
mv debian.deb tamtron-qmqtt-${version}.deb
