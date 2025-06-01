# Run windeployqt

find_package(Qt6Core REQUIRED)

# Retrieve the absolute path to qmake and then use that path to find
# the binaries
get_target_property(_qmake_executable Qt6::qmake IMPORTED_LOCATION)
get_filename_component(_qt_bin_dir "${_qmake_executable}" DIRECTORY)
find_program(WINDEPLOYQT_EXECUTABLE windeployqt HINTS "${_qt_bin_dir}")

# Add commands that copy the Qt runtime to the target's output directory after
# build and install the Qt runtime
function(run_windeployqt target_in)
    add_custom_command(TARGET ${target_in} POST_BUILD
        COMMAND "${CMAKE_COMMAND}" -E
        env PATH="${_qt_bin_dir}" "${WINDEPLOYQT_EXECUTABLE}"
            --no-translations
            --no-compiler-runtime
            -opengl
            -openglwidgets
        "$<TARGET_FILE:${target_in}>"
        COMMENT "Running windeployqt..."
    )
endfunction()

