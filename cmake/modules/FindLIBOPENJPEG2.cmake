# - Try to find the libopenjpeg2 library
# Once done this will define
#
#  LIBOPENJPEG2_FOUND - system has libopenjpeg
#  LIBOPENJPEG2_INCLUDE_DIRS - the libopenjpeg include directories
#  LIBOPENJPEG2_LIBRARIES - Link these to use libopenjpeg

# Copyright (c) 2008, Albert Astals Cid, <aacid@kde.org>
#
# Redistribution and use is allowed according to the terms of the BSD license.
# For details see the accompanying COPYING-CMAKE-SCRIPTS file.


if (LIBOPENJPEG2_LIBRARIES AND LIBOPENJPEG2_INCLUDE_DIR)

  # in cache already
  set(LIBOPENJPEG2_FOUND TRUE)

else ()

  set(LIBOPENJPEG2_FOUND FALSE)
  set(LIBOPENJPEG2_INCLUDE_DIRS)
  set(LIBOPENJPEG2_LIBRARIES)

  find_package(PkgConfig REQUIRED)
  pkg_check_modules(LIBOPENJPEG2 libopenjp2)
  if (LIBOPENJPEG2_FOUND)
    add_definitions(-DUSE_OPENJPEG2)
  else(LIBOPENJPEG2_FOUND)

    find_path (LIBOPENJPEG2_INCLUDE_DIR openjpeg.h PATH_SUFFIXES openjpeg-2.1)
    find_library(LIBOPENJPEG2_LIBRARIES openjp2)
    if(LIBOPENJPEG2_INCLUDE_DIR AND LIBOPENJPEG2_LIBRARIES)

      set(LIBOPENJPEG2_INCLUDE_DIRS ${LIBOPENJPEG2_INCLUDE_DIR})

      check_cxx_source_compiles("
#include <openjpeg.h>
int main()
{
  int foo = OPJ_DPARAMETERS_IGNORE_PCLR_CMAP_CDEF_FLAG;
  return 0;
}"
        WITH_OPENJPEG_IGNORE_PCLR_CMAP_CDEF_FLAG)

      set(CMAKE_REQUIRED_INCLUDES)
      set(CMAKE_REQUIRED_LIBRARIES)

      set(LIBOPENJPEG2_FOUND TRUE)
    endif(LIBOPENJPEG2_INCLUDE_DIR AND LIBOPENJPEG2_LIBRARIES)

    include(FindPackageHandleStandardArgs)
    find_package_handle_standard_args(LibOpenJPEG2 DEFAULT_MSG LIBOPENJPEG2_LIBRARIES LIBOPENJPEG2_INCLUDE_DIR)

  endif (LIBOPENJPEG2_FOUND)
endif ()
