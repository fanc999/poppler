# - try to find the GLIB libraries
# Once done this will define
#
#  GLIB_FOUND - system has GLib
#  GLIB2_CFLAGS - the GLib CFlags
#  GLIB2_LIBRARIES - Link these to use GLib
#
# Copyright 2008-2010 Pino Toscano, <pino@kde.org>
# Copyright 2013 Michael Weiser, <michael@weiser.dinsnail.net>
#
# Redistribution and use is allowed according to the terms of the BSD license.
# For details see the accompanying COPYING-CMAKE-SCRIPTS file.

if(GLIB2_INCLUDE_DIRS AND GLIB2_LIBRARIES)

  # in cache already
  set(GLIB2_FOUND TRUE)

else(GLIB2_INCLUDE_DIRS AND GLIB2_LIBRARIES)
  include(FindPackageHandleStandardArgs)

if (NOT WIN32)
  find_package(PkgConfig REQUIRED)

  pkg_check_modules(GLIB2 "glib-2.0>=${GLIB_REQUIRED}" "gobject-2.0>=${GLIB_REQUIRED}" "gio-2.0>=${GLIB_REQUIRED}")

  find_package_handle_standard_args(GLib DEFAULT_MSG GLIB2_LIBRARIES GLIB2_CFLAGS)

else(NOT WIN32)
  # assume so, for now
  set(GLIB2_FOUND TRUE)

endif(NOT WIN32)

if(GLIB2_FOUND)
  # set it back as false
  set(GLIB2_FOUND FALSE)

  find_library(GLIB2_LIBRARY glib-2.0
               HINTS ${_pc_glib_LIBRARY_DIRS}
  )

  find_library(GOBJECT2_LIBRARY gobject-2.0
               HINTS ${_pc_gobject_LIBRARY_DIRS}
  )

  find_library(GIO2_LIBRARY gio-2.0
               HINTS ${_pc_gio_LIBRARY_DIRS}
  )
  set(GLIB2_LIBRARIES "${GIO2_LIBRARY} ${GOBJECT2_LIBRARY} ${GLIB2_LIBRARY}")

  find_path(GLIB2_INCLUDE_DIR glib.h
            HINTS ${_pc_glib_INCLUDE_DIRS}
            PATH_SUFFIXES glib
  )
  set(GLIB2_INCLUDE_DIRS "${GLIB2_INCLUDE_DIR}")

  find_package_handle_standard_args(Glib DEFAULT_MSG GLIB2_LIBRARIES GLIB2_INCLUDE_DIRS)
endif(GLIB2_FOUND)

endif(GLIB2_INCLUDE_DIRS AND GLIB2_LIBRARIES)

mark_as_advanced(
  GLIB2_CFLAGS
  GLIB2_INCLUDE_DIRS
  GLIB2_LIBRARIES
)
