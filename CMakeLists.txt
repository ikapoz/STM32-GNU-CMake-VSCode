set (CMAKE_MODULE_PATH "${CMAKE_MODULE_PATH};${CMAKE_CURRENT_SOURCE_DIR}/cmake")
#include(toolchain)
include(utils)
cmake_minimum_required(VERSION 3.12..3.17)

if(${CMAKE_VERSION} VERSION_LESS 3.17)
    cmake_policy(VERSION ${CMAKE_MAJOR_VERSION}.${CMAKE_MINOR_VERSION})
endif()

project(cubecmain 
    VERSION 1.0
    DESCRIPTION "STM32F103 project"
    LANGUAGES CXX ASM C)

message("cubecmain parsing")
set(CPU cortex-m3) #MCU architecture
set(FLOAT_ABI soft)
set(MCU -mcpu=${CPU} -mthumb -mfloat-abi=${FLOAT_ABI})
set(TARGET main)
set(STARTUP_LIB_TARGET startup_lib)

# Source files added to project
    add_executable(${TARGET} 
            "Src/main.cpp"
            "Src/sys.c"
            "Src/stm32f1xx_it.c"
            "Src/system_stm32f1xx.c"
            "Src/gpio.c"          
            "Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_ll_gpio.c"
            "Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_ll_pwr.c"
            "Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_ll_exti.c"
            "Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_ll_rcc.c"
            "Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_ll_utils.c"
            "startup_stm32f103xb.s")
# asembler file added compile flags
    set_source_files_properties(startup_stm32f103xb.s PROPERTIES COMPILE_FLAGS "-x assembler-with-cpp")
    generate_object(${TARGET} .hex ihex FALSE)
    generate_object(${TARGET} .bin binary TRUE)
    firmware_size(${TARGET})
# C, CXX compile, debug properties and include folders
    set_target_properties(${TARGET} PROPERTIES CXX_STANDARD 20)
    target_compile_definitions(${TARGET} PUBLIC 
                        STM32F103xB #STM32 hardware
                        USE_FULL_LL_DRIVER #CUBE driver usage LL 
                        #USE_HALL_DRIVER
                        HSE_VALUE=8000000
                        HSE_STARTUP_TIMEOUT=100
                        LSE_STARTUP_TIMEOUT=5000
                        LSE_VALUE=32768
                        HSI_VALUE=8000000
                        LSI_VALUE=40000
                        VDD_VALUE=3300
                        PREFETCH_ENABLE=1)           
    target_compile_options(${TARGET} PUBLIC        
                                $<$<COMPILE_LANGUAGE:CXX>:
                                -fno-exceptions 
                                -fno-rtti 
                                -fno-threadsafe-statics 
                                -fno-use-cxa-atexit>)
    target_compile_options(${TARGET} PUBLIC
                        ${MCU}
                        --specs=nano.specs
                        -ffunction-sections
                        -fdata-sections
                        -fstack-usage)
    
    
    if(${CMAKE_BUILD_TYPE} MATCHES  Debug) 
        target_compile_definitions(main PUBLIC 
                        DEBUG
                        USE_FULL_ASSERT=1U)
        target_compile_options(${TARGET} PUBLIC
                        -Wall)
    endif()

    #add_library(${STARTUP_LIB_TARGET} startup_stm32f103xb)

    #target_link_libraries(${TARGET} ${STARTUP_LIB_TARGET})

    target_link_options(main PUBLIC
                    ${MCU}
                    -T${CMAKE_CURRENT_SOURCE_DIR}/STM32F103C8Tx_FLASH.ld
                    -specs=nano.specs
                    -Wl,-Map=${CMAKE_CURRENT_BINARY_DIR}/${TARGET}.map,--cref -Wl,--gc-sections)

    target_include_directories(main PUBLIC "Inc"
                                            "Drivers/STM32F1xx_HAL_Driver/Inc"
                                            "Drivers/CMSIS/Device/ST/STM32F1xx/Include"
                                            "Drivers/CMSIS/Include")      

