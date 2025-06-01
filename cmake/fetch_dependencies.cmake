include(FetchContent)

find_package(GTest)
if (GTest_FOUND)
    message(STATUS "Found GTest")
else()
    message(STATUS "Fetching GTest library")
    FetchContent_Declare(
        googletest
        GIT_REPOSITORY https://github.com/google/googletest.git
        GIT_TAG v1.13.0
        GIT_SHALLOW TRUE
        GIT_PROGRESS TRUE)
    FetchContent_MakeAvailable(googletest)
    set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)
endif()

set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)

