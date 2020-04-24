cmake_minimum_required(VERSION 3.16)

set(target ${PROJECT_NAME})

set(QML_IMPORT_PATH "${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/imports" CACHE INTERNAL "Hello QtCreator! ;-)")
set(QML_IMPORT_PATH "${CMAKE_CURRENT_SOURCE_DIR}/qml;${QML_IMPORT_PATH}" CACHE INTERNAL "Hello QtCreator! ;-)")

set(sources main.cpp)
set(resources resources.qrc)

add_executable(${target} ${sources} ${resources})
target_link_libraries(${target} PRIVATE Qt5::Gui PRIVATE Qt5::Qml PRIVATE qmljiraplugin)
