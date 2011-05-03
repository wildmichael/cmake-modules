# - Find OpenCL cross-platform parallel programming library
#
# This module defines the following non-cached variables:
#  OPENCL_FOUND        - TRUE if OpenCL was found
#  OPENCL_INCLUDE_DIRS - Include directories of OpenCL (not cached)
#  OPENCL_LIBRARIES    - Libraries to link against (not cached)
#
# The following cached variables are also defined, but are not intended for
# general use:
#  OPENCL_INCLUDE_DIR  - Directory containing CL/cl.h or OpenCL/cl.h (cached)
#  OPENCL_LIBRARY      - The OpenCL library (cached)
#

# Copyright (C) 2009 Michael Wild <themiwi@users.sf.net>
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#
# * Redistributions of source code must retain the above copyright notice,
#   this list of conditions and the following disclaimer.
# * Redistributions in binary form must reproduce the above copyright notice,
#   this list of conditions and the following disclaimer in the documentation
#   and/or other materials provided with the distribution.
# * The names of its contributors may not be used to endorse or promote
#   products derived from this software without specific prior written
#   permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
# LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
# INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
# CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
# ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
# POSSIBILITY OF SUCH DAMAGE.

find_path(OPENCL_INCLUDE_DIR NAMES CL/cl.h OpenCL/cl.h
  PATHS ENV OPENCL_DIR
  PATH_SUFFIXES include
  )

# if not an Apple framework, provide a search hint for the
# library based on the include path and a path suffix based on whether the
# system is 32 or 64 bit.
if(NOT OPENCL_INCLUDE_DIR MATCHES "\\.framework/")
  get_filename_component(__opencl_lib_dir_hint "${OPENCL_INCLUDE_DIR}" PATH)
  set(__opencl_lib_dir_hint HINTS "${__opencl_lib_dir_hint}/lib")
  if(CMAKE_SIZEOF_VOID_P EQUAL 8)
    set(__opencl_libdir_suffix PATH_SUFFIXES x86_64)
  else()
    set(__opencl_libdir_suffix PATH_SUFFIXES x86)
  endif()
else()
  set(__opencl_lib_dir_hint)
  set(__opencl_libdir_suffix)
endif()

find_library(OPENCL_LIBRARY NAMES OpenCL
  ${__opencl_lib_dir_hint}
  ${__opencl_libdir_suffix}
  )

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(OpenCL DEFAULT_MSG
  OPENCL_LIBRARY OPENCL_INCLUDE_DIR)

set(OPENCL_INCLUDE_DIRS ${OPENCL_INCLUDE_DIR})
set(OPENCL_LIBRARIES ${OPENCL_LIBRARY})

mark_as_advanced(OPENCL_INCLUDE_DIR OPENCL_LIBRARY)
