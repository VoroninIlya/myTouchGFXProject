#Generated by VisualGDB (http://visualgdb.com)
#DO NOT EDIT THIS FILE MANUALLY UNLESS YOU ABSOLUTELY NEED TO
#USE VISUALGDB PROJECT PROPERTIES DIALOG INSTEAD

BINARYDIR := Release

#Additional flags
PREPROCESSOR_MACROS := NDEBUG=1 RELEASE=1
INCLUDE_DIRS := ../Core/Inc ../Drivers/BSP/Components/Common ../Drivers/BSP/Components/ili9341 ../Drivers/BSP/Components/stmpe811 ../Drivers/CMSIS/Device/ST/STM32F4xx/Include ../Drivers/CMSIS/Include ../Drivers/STM32F4xx_HAL_Driver/Inc ../Drivers/STM32F4xx_HAL_Driver/Inc/Legacy ../Middlewares/ST/threadx/common/inc ../Middlewares/ST/threadx/ports/cortex_m4/gnu/inc ../TouchGFX/App ../AZURE_RTOS/App ../TouchGFX/target ../TouchGFX/target/generated ../Middlewares/ST/touchgfx/framework/include/common ../Middlewares/ST/touchgfx/framework/include/mvp ../Middlewares/ST/touchgfx/framework/include/platform/core ../Middlewares/ST/touchgfx/framework/include/platform/driver/button ../Middlewares/ST/touchgfx/framework/include/platform/driver/i2c ../Middlewares/ST/touchgfx/framework/include/platform/driver/lcd ../Middlewares/ST/touchgfx/framework/include/platform/driver/touch ../Middlewares/ST/touchgfx/framework/include/platform/hal/simulator/sdl2 ../Middlewares/ST/touchgfx/framework/include/platform/hal/simulator/sdl2/vendor/SDL2 ../Middlewares/ST/touchgfx/framework/include/touchgfx ../Middlewares/ST/touchgfx/framework/include/touchgfx/canvas_widget_renderer ../Middlewares/ST/touchgfx/framework/include/touchgfx/containers ../Middlewares/ST/touchgfx/framework/include/touchgfx/containers/buttons ../Middlewares/ST/touchgfx/framework/include/touchgfx/containers/clock ../Middlewares/ST/touchgfx/framework/include/touchgfx/containers/progress_indicators ../Middlewares/ST/touchgfx/framework/include/touchgfx/containers/scrollers ../Middlewares/ST/touchgfx/framework/include/touchgfx/events ../Middlewares/ST/touchgfx/framework/include/touchgfx/hal ../Middlewares/ST/touchgfx/framework/include/touchgfx/lcd ../Middlewares/ST/touchgfx/framework/include/touchgfx/mixins ../Middlewares/ST/touchgfx/framework/include/touchgfx/transforms ../Middlewares/ST/touchgfx/framework/include/touchgfx/transitions ../Middlewares/ST/touchgfx/framework/include/touchgfx/widgets ../Middlewares/ST/touchgfx/framework/include/touchgfx/widgets/canvas ../Middlewares/ST/touchgfx/framework/include/touchgfx/widgets/graph ../TouchGFX/generated/fonts/include/fonts ../TouchGFX/generated/gui_generated/include/gui_generated/common ../TouchGFX/generated/gui_generated/include/gui_generated/main_screen ../TouchGFX/generated/images/include ../TouchGFX/generated/simulator/include/simulator ../TouchGFX/generated/simulator/include/simulator/video ../TouchGFX/generated/texts/include/texts ../TouchGFX/generated/videos/include/videos ../TouchGFX/gui/include/gui/common ../TouchGFX/gui/include/gui/common/ScrollingWheels ../TouchGFX/gui/include/gui/main_screen ../TouchGFX/gui/include/gui/model
LIBRARY_DIRS := 
LIBRARY_NAMES := 
ADDITIONAL_LINKER_INPUTS := 
MACOS_FRAMEWORKS := 
LINUX_PACKAGES := 

CFLAGS := -ggdb -ffunction-sections -O3
CXXFLAGS := -std=c++1z -ggdb -ffunction-sections -fno-exceptions -fno-rtti -O3
ASFLAGS := 
LDFLAGS := -Wl,-gc-sections
COMMONFLAGS := 
LINKER_SCRIPT := 

START_GROUP := -Wl,--start-group
END_GROUP := -Wl,--end-group

#Additional options detected from testing the toolchain
USE_DEL_TO_CLEAN := 1
CP_NOT_AVAILABLE := 1

ADDITIONAL_MAKE_FILES := stm32.mak
GENERATE_BIN_FILE := 1
GENERATE_IHEX_FILE := 1
