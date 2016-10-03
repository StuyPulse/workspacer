.DEFAULT_GOAL = compile

setup: compile
	touch users.csv
	mkdir their-work
	chmod a+rwxt their-work/

compile:
	gcc launch.c -o launch.o
	gcc interface.c -o interface.o
	chmod +xs ./launch.o
	chmod a+rx ./lib
