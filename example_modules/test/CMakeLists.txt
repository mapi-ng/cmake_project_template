project(test_example_modules)
include(CTest)

add_executable(${PROJECT_NAME}
    test_example_modules.cpp
)

add_test(NAME ${PROJECT_NAME}
    COMMAND ${PROJECT_NAME}
    WORKING_DIRECTORY $<TARGET_FILE_DIR:${PROJECT_NAME}>
)

target_link_libraries(${PROJECT_NAME}
    PRIVATE
    gtest_main
    example_modules
)

target_include_directories(${PROJECT_NAME}
    PRIVATE
)