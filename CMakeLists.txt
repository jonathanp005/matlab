cmake_minimum_required(VERSION 3.16)

project(basic_cpp_project VERSION 0.1.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

add_library(project_core
    src/math_utils.cpp
    src/string_utils.cpp
)

target_include_directories(project_core
    PUBLIC
        ${PROJECT_SOURCE_DIR}/include
)

add_executable(basic_cpp_app src/main.cpp)
target_link_libraries(basic_cpp_app PRIVATE project_core)

enable_testing()
add_test(NAME basic_cpp_app_runs COMMAND basic_cpp_app)
