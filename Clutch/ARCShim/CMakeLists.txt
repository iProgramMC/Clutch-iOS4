cmake_minimum_required(VERSION 3.8)

add_library(ARCShim OBJECT ARCShim.m)
target_compile_options(ARCShim PRIVATE -fno-objc-arc)
