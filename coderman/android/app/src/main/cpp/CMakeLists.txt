cmake_minimum_required(VERSION 3.10.2)

project("native-lib")

add_library(
    native-lib
    SHARED
    native.cpp
)