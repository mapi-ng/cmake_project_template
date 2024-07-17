add_executable(modules_example example_modules.cpp)

target_sources(modules_example PUBLIC
    FILE_SET CXX_MODULES
    FILES adder.ixx
)