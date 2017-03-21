# Makefile for users' workspaces

PROJECT_ROOT = $(shell pwd)

LIB = $(PROJECT_ROOT)/lib

EDUGUI = $(LIB)/gui.jar
JAVAFX = $(LIB)/jfxrt.jar

SRC = $(PROJECT_ROOT)/src
BIN = $(PROJECT_ROOT)/build

JAVAC = javac
CLASSPATH = $(BIN):$(EDUGUI):$(JAVAFX)
COMPILE = $(JAVAC) -g -d $(BIN) -cp $(CLASSPATH)

LIBRARY_PATH = lib/opencv-3.0.0/build/lib

.DEFAULT_GOAL := run

# By default, run Animation class. Override with `make class=CLASS`
class=Animation

all: clean init-bin
	$(COMPILE) src/$(class).java

clean:
	rm -rf $(BIN)

init-bin:
	mkdir $(BIN)

run: all
	java -cp $(CLASSPATH) -Djava.library.path=$(LIBRARY_PATH)  $(class)
