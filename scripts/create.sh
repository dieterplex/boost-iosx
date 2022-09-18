#!/bin/bash
set -e

BUILD_DIR="$( cd "$( dirname "./" )" >/dev/null 2>&1 && pwd )"

files=("boost_atomic" "boost_filesystem" "boost_regex" "boost_system" "boost_locale")
for file in ${files[@]}
do
    echo "file = ${file}"
    # echo "${PWD}/frameworks/${file}.xcframework/ios-arm64/${file}.a"
    # 拆分模拟器编译文件
    lipo $BUILD_DIR/frameworks/${file}.xcframework/ios-arm64_x86_64-simulator/lib${file}.a \
         -thin x86_64 \
         -output $BUILD_DIR/frameworks/${file}.xcframework/ios-arm64_x86_64-simulator/lib${file}-x86.a
    # 合并
    lipo -create \
        -output $BUILD_DIR/lib${file}.a \
        $BUILD_DIR/frameworks/${file}.xcframework/ios-arm64/lib${file}.a \
        $BUILD_DIR/frameworks/${file}.xcframework/ios-arm64_x86_64-simulator/lib${file}-x86.a 
done

rm -rf $BUILD_DIR/dest && mkdir -p $BUILD_DIR/dest/stage/lib
mv $BUILD_DIR/*.a $BUILD_DIR/dest/stage/lib
cp -R $BUILD_DIR/boost/boost $BUILD_DIR/dest/