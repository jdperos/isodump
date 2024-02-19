cmake_minimum_required(VERSION 3.20)
project( isodump )

set( m_MainDir ${CMAKE_CURRENT_SOURCE_DIR} )
set( m_BuildDir ${m_MainDir}/_build )
set( m_SrcDir ${m_MainDir}/src )
set( m_ResourceDir ${m_MainDir}/resources )


# Set the C++ standard
set(CMAKE_CXX_STANDARD 11)

# Build configurations
set(CMAKE_CONFIGURATION_TYPES "Debug;Release")

# Source and header files
file(GLOB SOURCE_FILES "${m_SrcDir}/*.cpp")
file(GLOB HEADER_FILES "${m_SrcDir}/*.h")

# Target executable
add_executable(${PROJECT_NAME} ${SOURCE_FILES} ${HEADER_FILES})

set_property( GLOBAL PROPERTY VS_STARTUP_PROJECT ${PROJECT_NAME} )

# Add PortAudio include directory for the ff7test target
target_include_directories(${PROJECT_NAME} PUBLIC ${m_SrcDir})

# Compiler options
if(MSVC)
    target_compile_options(${PROJECT_NAME} PRIVATE
        $<$<CONFIG:Debug>:/Od /W3>
        $<$<CONFIG:Release>:/O2 /W3>
    )
endif()
	
set(VS_DEBUGGER_WORKING_DIRECTORY "${CMAKE_BINARY_DIR}/$<CONFIG>/")
file(TO_NATIVE_PATH "${VS_DEBUGGER_WORKING_DIRECTORY}" VS_DEBUGGER_WORKING_DIRECTORY_NATIVE)
set_target_properties(${PROJECT_NAME} PROPERTIES
    VS_DEBUGGER_WORKING_DIRECTORY "${VS_DEBUGGER_WORKING_DIRECTORY_NATIVE}"
)