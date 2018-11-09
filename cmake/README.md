# CMake for Amazon FreeRTOS

## CMake Tutorial

If you don't already know CMake, here's a great tutorial that covers almost everything, [An Introduction to Modern CMake](https://cliutils.gitlab.io/modern-cmake/). Most importantly, it talks about modern CMake, not CMake 2.x but CMake 3.1+ (even the official site lacks good introduction and best practices tutorial). It is highly recommended to go through at least the basics if you want to understand how CMake works and how to use it effectively.

## Build

There are 3 things you need to specify when configuring the CMake build:

- Target board. This follows the format of `{vendor}.{board}`, which is the exact name we use in our folder structure. For example, `ti.cc3220_launchpad`
- Toolchain file. This specify the compiler to use. Available options are under `cmake/toolchains` and `{board}/toolchains` folder.
- Target build system. This is the build system to generate. Typically, this could be `Unix Makefiles`, `Ninja`, etc.

If you compiler is not in system `PATH`, you can also provide the optional search path `TOOLCHAIN_PATH`.

Examples:

```sh
# Assuming you're under AFR source code root directory, this will generate makefile for ti demo and test projects.
mkdir build; cd build
cmake -DTARGET_BOARD=ti.cc3220_launchpad -DCMAKE_TOOLCHAIN_FILE=../cmake/toolchains/arm-ti.cmake -G 'Unix Makefiles' ..

# Or if your compiler is not in system PATH, you can set the TOOLCHAIN_PATH variable.
mkdir build; cd build
cmake -DTARGET_BOARD=ti.cc3220_launchpad -DCMAKE_TOOLCHAIN_FILE=../cmake/toolchains/arm-ti.cmake -DTOOLCHAIN_PATH=/Applications/ti/ti-cgt-arm_17.9.0.STS/bin -G 'Unix Makefiles' ..

# And to build you can either simply call make.
make -j8

# Or use CMake's generic interface. This abstracts the native build tool’s command-line interface
cmake --build .

# For single target, use --target option.
cmake --build . --target aws_tests
```

For more information about using cmake to build, please check here, [cmake build tool mode](https://cmake.org/cmake/help/v3.12/manual/cmake.1.html#build-tool-mode)

## Structure

There's one `CMakeLists.txt` file under the root directory and a `cmake` top level folder:

```txt
- CMakeLists.txt
- cmake
  - boards
  - toolchains
  - demos.cmake
  - tests.cmake
  - lib.cmake
```

`CMakeLists.txt` specifies the outline of AFR project, including board, toolchain, paths and board projects.

Under `cmake` folder, `lib.cmake`, `demos.cmake` and `tests.cmake` contains the library component targets, demos and tests targets correspondingly.

`cmake/toolchains` is where the compiler information is stored. These files are used by CMake to specify cross compiler.

`cmake/boards/{vendor}/{board}` is where the projects are defined. Generally, `common.cmake` set up the projects, and files under `toolchains` folder specify compiler options and compiler specific code. Additionally, if present, `override_lib`, `override_demos` and `override_tests` define board specific set up for lib, demos and tests, e.g., some lib and tests are not available on certain board.
