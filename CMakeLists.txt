cmake_minimum_required (VERSION 2.6)

set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_SYSTEM_PROCESSOR arm)


### Set this variable appropriate to the tools location
set(PRI_TOOLS_PTH "/media/constantine/Work/BOARDS/RASPBERRY/tools-master")

set(CROSS_COMPILE ${PRI_TOOLS_PTH}/arm-bcm2708/arm-linux-gnueabihf/bin/arm-linux-gnueabihf-)
set(CMAKE_C_COMPILER ${CROSS_COMPILE}gcc)
set(CMAKE_CXX_COMPILER ${CROSS_COMPILE}g++)

set(CMAKE_SYSROOT        "${PRI_TOOLS_PTH}/arm-bcm2708/arm-linux-gnueabihf/arm-linux-gnueabihf/sysroot")
message("CMAKE_SYSROOT = " ${CMAKE_SYSROOT})
set(CMAKE_FIND_ROOT_PATH "${PRI_TOOLS_PTH}/arm-bcm2708/arm-linux-gnueabihf/arm-linux-gnueabihf")
message("CMAKE_FIND_ROOT_PATH = " ${CMAKE_FIND_ROOT_PATH})

set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)

set(CMAKE_LIBRARY_PATH     "${CMAKE_SYSROOT}/usr/lib64")
set(CROSS_COMPILE_INCLUDES "${CMAKE_SYSROOT}/usr/include/linux")

set(CMAKE_BUILD_TYPE Debug)
set(CMAKE_CXX_FLAGS_DEBUG "-g")

set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -mfpu=neon")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall -mfpu=neon")

set(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} --sysroot=${CMAKE_SYSROOT}")
set(CMAKE_CXX_LINK_FLAGS      "${CMAKE_CXX_LINK_FLAGS}      --sysroot=${CMAKE_SYSROOT}")
set(CMAKE_C_LINK_FLAGS        "${CMAKE_C_LINK_FLAGS}        --sysroot=${CMAKE_SYSROOT}")

set(CMAKE_C_COMPILER_WORKS 1)
set(CMAKE_CXX_COMPILER_WORKS 1)

project (RPi_helloWorld)

add_executable(RPi_helloWorld RPi_helloWorld.cpp)

