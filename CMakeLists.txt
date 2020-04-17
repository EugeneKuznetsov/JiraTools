cmake_minimum_required(VERSION 3.16)

project(jiratools VERSION 0.1)

set(target ${PROJECT_NAME})

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CMAKE_AUTORCC ON)

find_package(Qt5 COMPONENTS Gui Qml REQUIRED)

set(QML_IMPORT_PATH "${CMAKE_CURRENT_SOURCE_DIR}/qml" CACHE STRING "Hello QtCreator! ;-)")

set(sources main.cpp)
set(resources resources.qrc)

add_executable(${target} ${sources} ${resources})

target_link_libraries(${target} Qt5::Gui Qt5::Qml)
