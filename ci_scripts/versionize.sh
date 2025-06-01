#!/usr/bin/env sh

GIT_TAG=$(git describe --tags --dirty --always)
printf "/******************************************************************\n"\
" *****  WARNING: Automatically generated file! Do not modify!  ****\n"\
" ******************************************************************/\n\n"\
"#pragma once\n"\
"#define GIT_VERSION_STRING \"$GIT_TAG\""\
> git_version_string.h

# Output version without new line characters
echo $GIT_TAG | tr -d '\r\n'
