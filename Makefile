################################################################################
#                                                                              #
#                    VELOCITY CLASH – AI BATTLE ARENA                         #
#                          Custom Project Makefile                             #
#                                                                              #
#                    Author: Ankit Jha                                         #
#                    Language: C++ (C++14 Standard)                            #
#                    Graphics Library: raylib                                  #
#                    Platform: Windows Desktop                                 #
#                                                                              #
################################################################################


#===============================================================================
#  PHONY TARGETS
#===============================================================================

.PHONY: all build rebuild clean run debug release info help


#===============================================================================
#  PROJECT CONFIGURATION
#===============================================================================

PROJECT_NAME            ?= velocity_clash
PROJECT_DESCRIPTION     ?= AI Powered Pong Battle Game
PROJECT_VERSION         ?= 1.0.0
PROJECT_AUTHOR          ?= Ankit Jha

BUILD_MODE              ?= RELEASE
PLATFORM                ?= PLATFORM_DESKTOP


#===============================================================================
#  RAYLIB CONFIGURATION
#===============================================================================

RAYLIB_VERSION          ?= 4.2.0
RAYLIB_PATH             ?= ../../
RAYLIB_LIBTYPE          ?= STATIC

RAYLIB_INCLUDE_PATH     = $(RAYLIB_PATH)/src
RAYLIB_EXTERNAL_PATH    = $(RAYLIB_PATH)/src/external
RAYLIB_LIBRARY_PATH     = $(RAYLIB_PATH)/src


#===============================================================================
#  COMPILER CONFIGURATION
#===============================================================================

COMPILER_PATH           ?= C:/raylib/w64devkit/bin
CC                      = g++

C_STANDARD              = -std=c++14
WARNING_FLAGS           = -Wall -Wextra -Wno-missing-braces
SYSTEM_FLAGS            = -D_DEFAULT_SOURCE
THREAD_FLAGS            = -pthread

BASE_CFLAGS             = $(C_STANDARD) $(WARNING_FLAGS) $(SYSTEM_FLAGS)


#===============================================================================
#  BUILD MODE SETTINGS
#===============================================================================

ifeq ($(BUILD_MODE),DEBUG)
    OPT_FLAGS           = -g -O0
    BUILD_TAG           = [DEBUG MODE]
else
    OPT_FLAGS           = -O2 -s
    BUILD_TAG           = [RELEASE MODE]
endif

CFLAGS                  += $(BASE_CFLAGS) $(OPT_FLAGS)


#===============================================================================
#  INCLUDE & LIBRARY PATHS
#===============================================================================

INCLUDE_PATHS           = \
                          -I. \
                          -I$(RAYLIB_INCLUDE_PATH) \
                          -I$(RAYLIB_EXTERNAL_PATH)

LDFLAGS                 = \
                          -L. \
                          -L$(RAYLIB_LIBRARY_PATH)


#===============================================================================
#  SYSTEM LIBRARIES (Windows)
#===============================================================================

LDLIBS                  = \
                          -lraylib \
                          -lopengl32 \
                          -lgdi32 \
                          -lwinmm


#===============================================================================
#  SOURCE FILES
#===============================================================================

SRC_FILES               = \
                          main.cpp

OBJ_FILES               = $(SRC_FILES:.cpp=.o)


#===============================================================================
#  DEFAULT TARGET
#===============================================================================

all: build


#===============================================================================
#  BUILD EXECUTABLE
#===============================================================================

build:
	@echo ============================================================
	@echo Building $(PROJECT_NAME) $(PROJECT_VERSION) $(BUILD_TAG)
	@echo ============================================================
	$(CC) -o $(PROJECT_NAME).exe $(SRC_FILES) \
	$(CFLAGS) \
	$(INCLUDE_PATHS) \
	$(LDFLAGS) \
	$(LDLIBS)
	@echo.
	@echo Build Successful!
	@echo Executable Generated: $(PROJECT_NAME).exe
	@echo ============================================================


#===============================================================================
#  DEBUG BUILD
#===============================================================================

debug:
	$(MAKE) BUILD_MODE=DEBUG build


#===============================================================================
#  RELEASE BUILD
#===============================================================================

release:
	$(MAKE) BUILD_MODE=RELEASE build


#===============================================================================
#  RUN GAME
#===============================================================================

run:
	@echo Running $(PROJECT_NAME)...
	@echo.
	./$(PROJECT_NAME).exe


#===============================================================================
#  REBUILD PROJECT
#===============================================================================

rebuild:
	$(MAKE) clean
	$(MAKE) build


#===============================================================================
#  CLEAN BUILD FILES
#===============================================================================

clean:
	@echo Cleaning object files and executable...
	del /Q *.o 2>nul
	del /Q *.exe 2>nul
	@echo Clean Complete.


#===============================================================================
#  PROJECT INFORMATION
#===============================================================================

info:
	@echo ------------------------------------------------------------
	@echo Project Name       : $(PROJECT_NAME)
	@echo Description        : $(PROJECT_DESCRIPTION)
	@echo Version            : $(PROJECT_VERSION)
	@echo Author             : $(PROJECT_AUTHOR)
	@echo Build Mode         : $(BUILD_MODE)
	@echo Raylib Version     : $(RAYLIB_VERSION)
	@echo ------------------------------------------------------------


#===============================================================================
#  HELP MENU
#===============================================================================

help:
	@echo.
	@echo Available Commands:
	@echo.
	@echo make            -> Build project
	@echo make run        -> Build and run
	@echo make debug      -> Build in debug mode
	@echo make release    -> Build in release mode
	@echo make clean      -> Remove executable and object files
	@echo make rebuild    -> Clean and rebuild
	@echo make info       -> Show project information
	@echo.
	@echo ============================================================