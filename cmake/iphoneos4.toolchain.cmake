set(CMAKE_SYSTEM_NAME Darwin)
set(CMAKE_SYSTEM_VERSION 4.0)
set(CMAKE_OSX_SYSROOT $ENV{THEOS}/sdks/iPhoneOS4.0.sdk)

set(CMAKE_C_COMPILER $ENV{THEOS}/toolchain/linux/iphone/bin/clang)
set(CMAKE_CXX_COMPILER $ENV{THEOS}/toolchain/linux/iphone/bin/clang)
set(CMAKE_LINKER $ENV{THEOS}/toolchain/linux/iphone/bin/clang)
set(CMAKE_AR $ENV{THEOS}/toolchain/linux/iphone/bin/llvm-ar)
set(CMAKE_LIBTOOL $ENV{THEOS}/toolchain/linux/iphone/bin/libtool)
set(CMAKE_RANLIB $ENV{THEOS}/toolchain/linux/iphone/bin/llvm-ranlib)
set(CMAKE_STRIP $ENV{THEOS}/toolchain/linux/iphone/bin/llvm-strip)

set(CMAKE_C_FLAGS "-target armv6-apple-darwin9 -isysroot $ENV{THEOS}/sdks/iPhoneOS4.0.sdk -Os -DOLD_IPHONE")
set(CMAKE_CXX_FLAGS "${CMAKE_C_FLAGS}")

set(CMAKE_FIND_FRAMEWORK FIRST)
set(CMAKE_SYSTEM_FRAMEWORK_PATH ${CMAKE_OSX_SYSROOT}/System/Library/Frameworks)

set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
