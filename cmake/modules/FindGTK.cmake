# - try to find GTK libraries
# Once done this will define
#
#  GTK_FOUND - system has GTK
#  GTK3_CFLAGS - the GTK CFlags
#  GTK3_LIBRARIES - Link these to use GTK
#
# Copyright 2008-2010 Pino Toscano, <pino@kde.org>
#
# Redistribution and use is allowed according to the terms of the BSD license.
# For details see the accompanying COPYING-CMAKE-SCRIPTS file.

if(GTK3_INCLUDE_DIRS AND GTK3_LIBRARIES)

  # in cache already
  set(GTK3_FOUND TRUE)

else(GTK3_INCLUDE_DIRS AND GTK3_LIBRARIES)

include(FindPackageHandleStandardArgs)

if (NOT WIN32)
  find_package(PkgConfig REQUIRED)

  pkg_check_modules(GTK3 "gtk+-3.0>=3.8" "gdk-pixbuf-2.0")

  find_package_handle_standard_args(GTK DEFAULT_MSG GTK3_LIBRARIES GTK3_CFLAGS)

else(NOT WIN32)
  # assume so, for now
  set(GTK3_FOUND TRUE)

endif(NOT WIN32)

if(GTK3_FOUND)
  # set it back as false
  set(GTK3_FOUND FALSE)

  find_library(GDK3_LIBRARY gdk-3.0
               HINTS ${_pc_gdk_LIBRARY_DIRS}
  )

  find_library(GDK3_LIBRARY gdk-3
               HINTS ${_pc_gdk_LIBRARY_DIRS}
  )

  find_library(GTK3_LIBRARY gtk-3.0
               HINTS ${_pc_gtk_LIBRARY_DIRS}
  )

  find_library(GTK3_LIBRARY gtk-3
               HINTS ${_pc_gtk_LIBRARY_DIRS}
  )

  find_library(GDK_PIXBUF_LIBRARY gdk_pixbuf-2.0
               HINTS ${_pc_gdk-pixbuf_LIBRARY_DIRS}
  )

  find_library(PANGOCAIRO_LIBRARY pangocairo-1.0
               HINTS ${_pc_pangocairo_LIBRARY_DIRS}
  )

  find_library(PANGO_LIBRARY pango-1.0
               HINTS ${_pc_pango_LIBRARY_DIRS}
  )

  find_library(ATK_LIBRARY atk-1.0
               HINTS ${_pc_atk_LIBRARY_DIRS}
  )
  set(GTK3_LIBRARIES "${GTK3_LIBRARY} ${GDK3_LIBRARY} ${GDK_PIXBUF_LIBRARY} ${PANGOCAIRO_LIBRARY} ${PANGO_LIBRARY} ${ATK_LIBRARY}")

  find_path(GTK3_INCLUDE_DIR gtk.h
            HINTS ${_pc_gtk_INCLUDE_DIRS}
            PATH_SUFFIXES gtk
  )
  set(GTK3_INCLUDE_DIRS "${GTK3_INCLUDE_DIR}")

  find_package_handle_standard_args(GTK DEFAULT_MSG GTK3_LIBRARIES GTK3_INCLUDE_DIRS)
endif(GTK3_FOUND)

endif(GTK3_INCLUDE_DIRS AND GTK3_LIBRARIES)

mark_as_advanced(
  GTK3_CFLAGS
  GTK3_INCLUDE_DIRS
  GTK3_LIBRARIES
)
