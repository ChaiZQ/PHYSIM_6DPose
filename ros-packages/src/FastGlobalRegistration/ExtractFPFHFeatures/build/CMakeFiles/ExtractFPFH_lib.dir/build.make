# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.2

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list

# Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/local/bin/cmake

# The command to remove a file.
RM = /usr/local/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/pracsys/github/PHYSIM_6DPose/ros-packages/src/FastGlobalRegistration/ExtractFPFHFeatures

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/pracsys/github/PHYSIM_6DPose/ros-packages/src/FastGlobalRegistration/ExtractFPFHFeatures/build

# Include any dependencies generated for this target.
include CMakeFiles/ExtractFPFH_lib.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/ExtractFPFH_lib.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/ExtractFPFH_lib.dir/flags.make

CMakeFiles/ExtractFPFH_lib.dir/src/ExtractFPFH.cpp.o: CMakeFiles/ExtractFPFH_lib.dir/flags.make
CMakeFiles/ExtractFPFH_lib.dir/src/ExtractFPFH.cpp.o: ../src/ExtractFPFH.cpp
	$(CMAKE_COMMAND) -E cmake_progress_report /home/pracsys/github/PHYSIM_6DPose/ros-packages/src/FastGlobalRegistration/ExtractFPFHFeatures/build/CMakeFiles $(CMAKE_PROGRESS_1)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Building CXX object CMakeFiles/ExtractFPFH_lib.dir/src/ExtractFPFH.cpp.o"
	/usr/bin/c++   $(CXX_DEFINES) $(CXX_FLAGS) -o CMakeFiles/ExtractFPFH_lib.dir/src/ExtractFPFH.cpp.o -c /home/pracsys/github/PHYSIM_6DPose/ros-packages/src/FastGlobalRegistration/ExtractFPFHFeatures/src/ExtractFPFH.cpp

CMakeFiles/ExtractFPFH_lib.dir/src/ExtractFPFH.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/ExtractFPFH_lib.dir/src/ExtractFPFH.cpp.i"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -E /home/pracsys/github/PHYSIM_6DPose/ros-packages/src/FastGlobalRegistration/ExtractFPFHFeatures/src/ExtractFPFH.cpp > CMakeFiles/ExtractFPFH_lib.dir/src/ExtractFPFH.cpp.i

CMakeFiles/ExtractFPFH_lib.dir/src/ExtractFPFH.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/ExtractFPFH_lib.dir/src/ExtractFPFH.cpp.s"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -S /home/pracsys/github/PHYSIM_6DPose/ros-packages/src/FastGlobalRegistration/ExtractFPFHFeatures/src/ExtractFPFH.cpp -o CMakeFiles/ExtractFPFH_lib.dir/src/ExtractFPFH.cpp.s

CMakeFiles/ExtractFPFH_lib.dir/src/ExtractFPFH.cpp.o.requires:
.PHONY : CMakeFiles/ExtractFPFH_lib.dir/src/ExtractFPFH.cpp.o.requires

CMakeFiles/ExtractFPFH_lib.dir/src/ExtractFPFH.cpp.o.provides: CMakeFiles/ExtractFPFH_lib.dir/src/ExtractFPFH.cpp.o.requires
	$(MAKE) -f CMakeFiles/ExtractFPFH_lib.dir/build.make CMakeFiles/ExtractFPFH_lib.dir/src/ExtractFPFH.cpp.o.provides.build
.PHONY : CMakeFiles/ExtractFPFH_lib.dir/src/ExtractFPFH.cpp.o.provides

CMakeFiles/ExtractFPFH_lib.dir/src/ExtractFPFH.cpp.o.provides.build: CMakeFiles/ExtractFPFH_lib.dir/src/ExtractFPFH.cpp.o

# Object files for target ExtractFPFH_lib
ExtractFPFH_lib_OBJECTS = \
"CMakeFiles/ExtractFPFH_lib.dir/src/ExtractFPFH.cpp.o"

# External object files for target ExtractFPFH_lib
ExtractFPFH_lib_EXTERNAL_OBJECTS =

libExtractFPFH_lib.a: CMakeFiles/ExtractFPFH_lib.dir/src/ExtractFPFH.cpp.o
libExtractFPFH_lib.a: CMakeFiles/ExtractFPFH_lib.dir/build.make
libExtractFPFH_lib.a: CMakeFiles/ExtractFPFH_lib.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --red --bold "Linking CXX static library libExtractFPFH_lib.a"
	$(CMAKE_COMMAND) -P CMakeFiles/ExtractFPFH_lib.dir/cmake_clean_target.cmake
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/ExtractFPFH_lib.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/ExtractFPFH_lib.dir/build: libExtractFPFH_lib.a
.PHONY : CMakeFiles/ExtractFPFH_lib.dir/build

CMakeFiles/ExtractFPFH_lib.dir/requires: CMakeFiles/ExtractFPFH_lib.dir/src/ExtractFPFH.cpp.o.requires
.PHONY : CMakeFiles/ExtractFPFH_lib.dir/requires

CMakeFiles/ExtractFPFH_lib.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/ExtractFPFH_lib.dir/cmake_clean.cmake
.PHONY : CMakeFiles/ExtractFPFH_lib.dir/clean

CMakeFiles/ExtractFPFH_lib.dir/depend:
	cd /home/pracsys/github/PHYSIM_6DPose/ros-packages/src/FastGlobalRegistration/ExtractFPFHFeatures/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/pracsys/github/PHYSIM_6DPose/ros-packages/src/FastGlobalRegistration/ExtractFPFHFeatures /home/pracsys/github/PHYSIM_6DPose/ros-packages/src/FastGlobalRegistration/ExtractFPFHFeatures /home/pracsys/github/PHYSIM_6DPose/ros-packages/src/FastGlobalRegistration/ExtractFPFHFeatures/build /home/pracsys/github/PHYSIM_6DPose/ros-packages/src/FastGlobalRegistration/ExtractFPFHFeatures/build /home/pracsys/github/PHYSIM_6DPose/ros-packages/src/FastGlobalRegistration/ExtractFPFHFeatures/build/CMakeFiles/ExtractFPFH_lib.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/ExtractFPFH_lib.dir/depend

