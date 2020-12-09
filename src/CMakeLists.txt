cmake_minimum_required(VERSION 3.5)
project(
  Reck_demo
  VERSION 1.0.0
  LANGUAGES CXX)

add_executable(reck_demo main.cpp)
target_link_libraries(reck_demo PUBLIC reckless pthread)

install(TARGETS reck_demo DESTINATION ${CMAKE_INSTALL_BINDIR})
