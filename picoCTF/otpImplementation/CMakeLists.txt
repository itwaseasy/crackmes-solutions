cmake_minimum_required(VERSION 3.16)
project(otpImplementation)

find_path(GMP_INCLUDE_DIR NAMES gmp.h)
find_library(GMP_LIB NAMES gmp)

if(NOT GMP_INCLUDE_DIR AND NOT GMP_LIB)
    message(FATAL_ERROR "Could not find GMP")
else ()
    message(STATUS "Found GMP: ${GMP_LIB}")
endif()

set(CMAKE_CXX_STANDARD 20)
set(FLAGS
        -Wall
        -Werror
        -Wextra
)

add_compile_options(${FLAGS})
include_directories(${GMP_INCLUDE_DIR})

add_executable(otp_impl main.cpp)
target_link_libraries(otp_impl ${GMP_LIB})
