FILE(GLOB_RECURSE SRC_LIST "./" "*.cc" "*.cpp" "*.c")


##############################################
#			Start, compute the building time.
##############################################
MACRO (TODAY RESULT)
    IF (WIN32)
        EXECUTE_PROCESS(COMMAND "cmd" " /C date /T" OUTPUT_VARIABLE ${RESULT})
        string(REGEX REPLACE "(..)/(..)/..(..).*" "\\1-\\2-\\3(DD-MM-YY)" ${RESULT} ${${RESULT}})
    ELSEIF(UNIX)
        EXECUTE_PROCESS(COMMAND "date" "+%d/%m/%Y" OUTPUT_VARIABLE ${RESULT})
        string(REGEX REPLACE "(..)/(..)/..(..).*" "\\1-\\2-\\3(DD-MM-YY)" ${RESULT} ${${RESULT}})
    ELSE (WIN32)
        MESSAGE(SEND_ERROR "date not implemented")
        SET(${RESULT} 000000)
    ENDIF (WIN32)
ENDMACRO (TODAY)

TODAY(BUILDING_DATE)
#message(STATUS "Compilation date = ${BUILDING_DATE}")

##############################################
#			End, got the building time.
##############################################

set (FAST_DBRD_VERSION_MAJOR 2)
set (FAST_DBRD_VERSION_MINOR 1)

configure_file (
	"${PROJECT_SOURCE_DIR}/src/util/Version.h.in"
	"${PROJECT_BINARY_DIR}/Version.h"
)

include_directories("${PROJECT_BINARY_DIR}")



set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} -Wall -Wextra -g")
set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} -Wall -Wconversion -Wextra")

ADD_EXECUTABLE(fast-dbrd ${SRC_LIST})

# statically linking the library.
# SET(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -static")


TARGET_LINK_LIBRARIES(fast-dbrd boost_program_options)