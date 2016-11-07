# Makefile for users' workspaces

PROJECT_ROOT = $(shell pwd)

LIB = $(PROJECT_ROOT)/lib

EDUGUI = $(LIB)/gui.jar
JAVAFX = $(LIB)/jfxrt.jar

SRC = $(PROJECT_ROOT)/src
BIN = $(PROJECT_ROOT)/build

JAVAC = javac
CLASSPATH = $(BIN):$(EDUGUI):$(JAVAFX)
JAVA_FLAGS = -g -d $(BIN) -cp $(CLASSPATH)
COMPILE = $(JAVAC) $(JAVA_FLAGS)

.DEFAULT_GOAL := run

# By default, run Animation class. Override with `make class=CLASS`
class=Animation

all: clean init-bin
	find $(SRC) -name '*.java' -print | xargs $(COMPILE)

clean:
	rm -rf $(BIN)

init-bin:
	mkdir $(BIN)

run: all
	java -cp $(CLASSPATH) $(class)
