STM32 Cube Cmake template
*************************

Introduction
============

This template is created to work in Visual Studio Code on Windows platform.
It is basic template generated from STM32CubeMX for STM32F103.

Requirements
============

.. _`STM32Cube Programmer`: https://www.st.com/en/development-tools/stm32cubeprog.html
.. _`ST-Link Server`: https://my.st.com/content/my_st_com/en/products/development-tools/software-development-tools/stm32-software-development-tools/stm32-performance-and-debuggers/st-link-server.html
.. _`CMake`: https://cmake.org/download
.. _`Make`: http://www.equation.com/servlet/equation.cmd?fa=make
.. _`GNU ARM toolchain`: https://developer.arm.com/tools-and-software/open-source-software/developer-tools/gnu-toolchain/gnu-rm/downloads

Prepare utilities
=================

Create sibling folder stm32-utils (relative path from current folder is ../stm32-utils/)
stm32-utils folder structure:

    - stm32-utils
        - stm32-tools
        - cmake
        - gcc
        - st-link


For `STM32Cube Programmer`_ copy everything from install dir to stm32-tools
For `ST-Link Server`_ copy everything from bin folder to st-link
For `CMake`_ copy everything to cmake
For `Make`_ copy make.exe to stm32-tools folder
For `GNU ARM toolchain`_ copy everything to gcc 


Usage
=====

Build task: ctrl+shift+B
Start debuging: F5


