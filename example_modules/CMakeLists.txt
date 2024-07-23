add_library(example_modules)

target_sources(example_modules PUBLIC
    FILE_SET CXX_MODULES
    FILES adder.ixx
)

add_subdirectory(test)