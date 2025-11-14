macro(AddFramework TARGET NAME)
  find_library(FRAMEWORK_${NAME}
               NAMES ${NAME}
               PATHS ${CMAKE_OSX_SYSROOT}/System/Library
               PATH_SUFFIXES Frameworks CMAKE_FIND_FRAMEWORK only
               NO_DEFAULT_PATH)
  if(${FRAMEWORK_${NAME}} STREQUAL FRAMEWORK_${NAME}-NOTFOUND)
    message(ERROR ": Framework ${NAME} not found")
  else()
    target_link_libraries(${TARGET} ${FRAMEWORK_${NAME}})
    message(STATUS "Framework ${NAME} found at ${FRAMEWORK_${NAME}}")
  endif()
endmacro(AddFramework)

macro(AddSystemLibrary TARGET NAME)
  find_library(SYSTEM_${NAME}
               NAMES ${NAME}
               PATHS ${CMAKE_OSX_SYSROOT}/usr/lib ${CMAKE_OSX_SYSROOT}/usr/lib/system
               NO_DEFAULT_PATH)
  if(${SYSTEM_${NAME}} STREQUAL SYSTEM_${NAME}-NOTFOUND)
    message(ERROR ": System Library ${NAME} not found")
  else()
    target_link_libraries(${TARGET} ${SYSTEM_${NAME}})
    message(STATUS "System Library ${NAME} found at ${SYSTEM_${NAME}}")
  endif()
endmacro(AddSystemLibrary)
