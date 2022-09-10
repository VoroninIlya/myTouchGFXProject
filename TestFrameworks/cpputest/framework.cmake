if(NOT DEFINED BSP_CONFIGURATION_com.sysprogs.testsettings.timeout)
    set(BSP_CONFIGURATION_com.sysprogs.testsettings.timeout "1800")
    set(BSP_CONFIGURATION_com.sysprogs.testsettings.timeout "${BSP_CONFIGURATION_com.sysprogs.testsettings.timeout}" PARENT_SCOPE)
endif()

set(_sources
    "${CMAKE_CURRENT_LIST_DIR}/src/CppUTest/CommandLineArguments.cpp"
    "${CMAKE_CURRENT_LIST_DIR}/src/CppUTest/CommandLineTestRunner.cpp"
    "${CMAKE_CURRENT_LIST_DIR}/src/CppUTest/JUnitTestOutput.cpp"
    "${CMAKE_CURRENT_LIST_DIR}/src/CppUTest/MemoryLeakDetector.cpp"
    "${CMAKE_CURRENT_LIST_DIR}/src/CppUTest/MemoryLeakWarningPlugin.cpp"
    "${CMAKE_CURRENT_LIST_DIR}/src/CppUTest/SimpleMutex.cpp"
    "${CMAKE_CURRENT_LIST_DIR}/src/CppUTest/SimpleString.cpp"
    "${CMAKE_CURRENT_LIST_DIR}/src/CppUTest/TeamCityTestOutput.cpp"
    "${CMAKE_CURRENT_LIST_DIR}/src/CppUTest/TestFailure.cpp"
    "${CMAKE_CURRENT_LIST_DIR}/src/CppUTest/TestFilter.cpp"
    "${CMAKE_CURRENT_LIST_DIR}/src/CppUTest/TestHarness_c.cpp"
    "${CMAKE_CURRENT_LIST_DIR}/src/CppUTest/TestMemoryAllocator.cpp"
    "${CMAKE_CURRENT_LIST_DIR}/src/CppUTest/TestOutput.cpp"
    "${CMAKE_CURRENT_LIST_DIR}/src/CppUTest/TestPlugin.cpp"
    "${CMAKE_CURRENT_LIST_DIR}/src/CppUTest/TestRegistry.cpp"
    "${CMAKE_CURRENT_LIST_DIR}/src/CppUTest/TestResult.cpp"
    "${CMAKE_CURRENT_LIST_DIR}/src/CppUTest/TestTestingFixture.cpp"
    "${CMAKE_CURRENT_LIST_DIR}/src/CppUTest/Utest.cpp"
    "${CMAKE_CURRENT_LIST_DIR}/Platforms/SysprogsTestHooks.cpp"
    "${CMAKE_CURRENT_LIST_DIR}/include/CppUTest/CommandLineArguments.h"
    "${CMAKE_CURRENT_LIST_DIR}/include/CppUTest/CommandLineTestRunner.h"
    "${CMAKE_CURRENT_LIST_DIR}/include/CppUTest/CppUTestConfig.h"
    "${CMAKE_CURRENT_LIST_DIR}/include/CppUTest/CppUTestGeneratedConfig.h"
    "${CMAKE_CURRENT_LIST_DIR}/include/CppUTest/JUnitTestOutput.h"
    "${CMAKE_CURRENT_LIST_DIR}/include/CppUTest/MemoryLeakDetector.h"
    "${CMAKE_CURRENT_LIST_DIR}/include/CppUTest/MemoryLeakDetectorMallocMacros.h"
    "${CMAKE_CURRENT_LIST_DIR}/include/CppUTest/MemoryLeakDetectorNewMacros.h"
    "${CMAKE_CURRENT_LIST_DIR}/include/CppUTest/MemoryLeakWarningPlugin.h"
    "${CMAKE_CURRENT_LIST_DIR}/include/CppUTest/PlatformSpecificFunctions.h"
    "${CMAKE_CURRENT_LIST_DIR}/include/CppUTest/PlatformSpecificFunctions_c.h"
    "${CMAKE_CURRENT_LIST_DIR}/include/CppUTest/SimpleMutex.h"
    "${CMAKE_CURRENT_LIST_DIR}/include/CppUTest/SimpleString.h"
    "${CMAKE_CURRENT_LIST_DIR}/include/CppUTest/StandardCLibrary.h"
    "${CMAKE_CURRENT_LIST_DIR}/include/CppUTest/TeamCityTestOutput.h"
    "${CMAKE_CURRENT_LIST_DIR}/include/CppUTest/TestFailure.h"
    "${CMAKE_CURRENT_LIST_DIR}/include/CppUTest/TestFilter.h"
    "${CMAKE_CURRENT_LIST_DIR}/include/CppUTest/TestHarness.h"
    "${CMAKE_CURRENT_LIST_DIR}/include/CppUTest/TestHarness_c.h"
    "${CMAKE_CURRENT_LIST_DIR}/include/CppUTest/TestMemoryAllocator.h"
    "${CMAKE_CURRENT_LIST_DIR}/include/CppUTest/TestOutput.h"
    "${CMAKE_CURRENT_LIST_DIR}/include/CppUTest/TestPlugin.h"
    "${CMAKE_CURRENT_LIST_DIR}/include/CppUTest/TestRegistry.h"
    "${CMAKE_CURRENT_LIST_DIR}/include/CppUTest/TestResult.h"
    "${CMAKE_CURRENT_LIST_DIR}/include/CppUTest/TestTestingFixture.h"
    "${CMAKE_CURRENT_LIST_DIR}/include/CppUTest/Utest.h"
    "${CMAKE_CURRENT_LIST_DIR}/include/CppUTest/UtestMacros.h"
    "${CMAKE_CURRENT_LIST_DIR}/Platforms/SysprogsTestHooks.h")
set(_includes "${CMAKE_CURRENT_LIST_DIR}/include" "${CMAKE_CURRENT_LIST_DIR}/Platforms")
set(_defines)
set(_cflags)
set(_ldflags)
set(_linker_script "")
if("${VISUALGDB_TOOLCHAIN_TYPE}" STREQUAL "Embedded")
    set(_sources ${_sources} "${CMAKE_CURRENT_LIST_DIR}/Platforms/Embedded/UtestPlatformEmbedded.cpp")
    set(_includes ${_includes} "${CMAKE_CURRENT_LIST_DIR}/platforms/Embedded")
    set(_defines ${_defines} "CPPUTEST_STD_CPP_LIB_DISABLED" "SYSPROGS_TEST_PLATFORM_EMBEDDED")
endif()

if("${VISUALGDB_TOOLCHAIN_TYPE}" STREQUAL "Linux")
    set(_sources ${_sources}
        "${CMAKE_CURRENT_LIST_DIR}/src/CppUTestExt/CodeMemoryReportFormatter.cpp"
        "${CMAKE_CURRENT_LIST_DIR}/src/CppUTestExt/IEEE754ExceptionsPlugin.cpp"
        "${CMAKE_CURRENT_LIST_DIR}/src/CppUTestExt/MemoryReportAllocator.cpp"
        "${CMAKE_CURRENT_LIST_DIR}/src/CppUTestExt/MemoryReporterPlugin.cpp"
        "${CMAKE_CURRENT_LIST_DIR}/src/CppUTestExt/MemoryReportFormatter.cpp"
        "${CMAKE_CURRENT_LIST_DIR}/src/CppUTestExt/MockActualCall.cpp"
        "${CMAKE_CURRENT_LIST_DIR}/src/CppUTestExt/MockExpectedCall.cpp"
        "${CMAKE_CURRENT_LIST_DIR}/src/CppUTestExt/MockExpectedCallsList.cpp"
        "${CMAKE_CURRENT_LIST_DIR}/src/CppUTestExt/MockFailure.cpp"
        "${CMAKE_CURRENT_LIST_DIR}/src/CppUTestExt/MockNamedValue.cpp"
        "${CMAKE_CURRENT_LIST_DIR}/src/CppUTestExt/MockSupport.cpp"
        "${CMAKE_CURRENT_LIST_DIR}/src/CppUTestExt/MockSupportPlugin.cpp"
        "${CMAKE_CURRENT_LIST_DIR}/src/CppUTestExt/MockSupport_c.cpp"
        "${CMAKE_CURRENT_LIST_DIR}/src/CppUTestExt/OrderedTest.cpp"
        "${CMAKE_CURRENT_LIST_DIR}/Platforms/Linux/UtestPlatform.cpp"
        "${CMAKE_CURRENT_LIST_DIR}/include/CppUTestExt/CodeMemoryReportFormatter.h"
        "${CMAKE_CURRENT_LIST_DIR}/include/CppUTestExt/GMock.h"
        "${CMAKE_CURRENT_LIST_DIR}/include/CppUTestExt/GTest.h"
        "${CMAKE_CURRENT_LIST_DIR}/include/CppUTestExt/GTestConvertor.h"
        "${CMAKE_CURRENT_LIST_DIR}/include/CppUTestExt/IEEE754ExceptionsPlugin.h"
        "${CMAKE_CURRENT_LIST_DIR}/include/CppUTestExt/MemoryReportAllocator.h"
        "${CMAKE_CURRENT_LIST_DIR}/include/CppUTestExt/MemoryReporterPlugin.h"
        "${CMAKE_CURRENT_LIST_DIR}/include/CppUTestExt/MemoryReportFormatter.h"
        "${CMAKE_CURRENT_LIST_DIR}/include/CppUTestExt/MockActualCall.h"
        "${CMAKE_CURRENT_LIST_DIR}/include/CppUTestExt/MockCheckedActualCall.h"
        "${CMAKE_CURRENT_LIST_DIR}/include/CppUTestExt/MockCheckedExpectedCall.h"
        "${CMAKE_CURRENT_LIST_DIR}/include/CppUTestExt/MockExpectedCall.h"
        "${CMAKE_CURRENT_LIST_DIR}/include/CppUTestExt/MockExpectedCallsList.h"
        "${CMAKE_CURRENT_LIST_DIR}/include/CppUTestExt/MockFailure.h"
        "${CMAKE_CURRENT_LIST_DIR}/include/CppUTestExt/MockNamedValue.h"
        "${CMAKE_CURRENT_LIST_DIR}/include/CppUTestExt/MockSupport.h"
        "${CMAKE_CURRENT_LIST_DIR}/include/CppUTestExt/MockSupportPlugin.h"
        "${CMAKE_CURRENT_LIST_DIR}/include/CppUTestExt/MockSupport_c.h"
        "${CMAKE_CURRENT_LIST_DIR}/include/CppUTestExt/OrderedTest.h")
endif()

if("${VISUALGDB_TOOLCHAIN_TYPE}" STREQUAL "AndroidApp")
endif()

if("${VISUALGDB_TOOLCHAIN_TYPE}" STREQUAL "AndroidTool")
endif()

create_test_framework_library_from_vars("com.sysprogs.unittest.CppUTest")
