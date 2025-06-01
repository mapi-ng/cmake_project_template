cmake_minimum_required(VERSION 3.28.3)
project(ProjectName)
message(STATUS "==== Configuring ${PROJECT_NAME} for ${CMAKE_SYSTEM_NAME} ====")
message(STATUS "${PROJECT_NAME} VERSION: ${GIT_TAG}")

if (UNIX)
    set(CMAKE_GENERATOR "Ninja")
    if(NOT CMAKE_GENERATOR STREQUAL "Ninja")
        message(FATAL_ERROR "This project requires the Ninja generator.")
    endif()
endif()

# Create version header and CMake variable
execute_process(
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/ciScripts/
    COMMAND sh ${CMAKE_SOURCE_DIR}/ciScripts/versionize.sh
    OUTPUT_VARIABLE GIT_TAG
)

# C/C++ Standards
set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Generate compiler commands for C/C++ intellisense, SonarLint, etc.
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

if (MSVC)
    # warning level 4
    add_compile_options(/W4)
else ()
    # lots of warnings and all warnings as errors
    add_compile_options(-Wall -Wextra)
endif ()


include(cmake/fetch_dependencies.cmake)
include(CTest)

# Create directories structure in ProgramData at configure time

if (WIN32)
    set(DIR_PROGRAMDATA_HELIOS "C:/ProgramData/ProjectName")
    #file(MAKE_DIRECTORY ${DIR_PROGRAMDATA_HELIOS})
    #file(MAKE_DIRECTORY "${DIR_PROGRAMDATA_HELIOS}/config")
endif (WIN32)

add_subdirectory(example_modules)
