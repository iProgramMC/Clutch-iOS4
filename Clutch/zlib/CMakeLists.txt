cmake_minimum_required(VERSION 3.8)

project(zlib LANGUAGES C)

set(HEADERS_FILES crc32.h deflate.h inffast.h inffixed.h inflate.h inftrees.h trees.h zconf.h zlib.h zutil.h)

set(SOURCE_FILES deflate.c inflate.c compress.c zutil.c adler32.c crc32.c trees.c inftrees.c inffast.c)
source_group("" FILES ${HEADERS_FILES} ${SOURCE_FILES})

add_library(zlib OBJECT ${HEADERS_FILES} ${SOURCE_FILES})
target_include_directories(zlib PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})

if(CMAKE_GENERATOR STREQUAL Xcode)
  set_target_properties(zlib
                        PROPERTIES XCODE_ATTRIBUTE_SDKROOT
                                   iphoneos
                                   XCODE_ATTRIBUTE_IPHONEOS_DEPLOYMENT_TARGET
                                   ${DEPLOYMENT_TARGET}
                                   XCODE_ATTIRBUTE_ENABLE_BITCODE
                                   YES
                                   XCODE_ATTIRBUTE_SKIP_INSTALL
                                   YES
                                   XCODE_ATTRIBUTE_DEBUG_INFORMATION_FORMAT
                                   dwarf-with-dsym
                                   XCODE_ATTRIBUTE_TARGETED_DEVICE_FAMILY
                                   ${DEVICE_FAMILY}
                                   XCODE_ATTRIBUTE_INSTALL_PATH
                                   "$(LOCAL_APPS_DIR)"
                                   XCODE_ATTRIBUTE_ENABLE_TESTABILITY
                                   YES
                                   XCODE_ATTRIBUTE_GCC_SYMBOLS_PRIVATE_EXTERN
                                   YES)
else()
  target_compile_options(zlib
                         PRIVATE -miphoneos-version-min=${DEPLOYMENT_TARGET})
endif()
