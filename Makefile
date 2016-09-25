.DEFAULT_GOAL = compile

setup: compile restore-tmp
	touch users.csv
	mkdir their-work
	chmod a+rwxt their-work/

restore-tmp:
	cp launch.o /tmp/launch.o
	chmod +xs /tmp/launch.o

compile:
	gcc launch.c -o launch.o
	gcc interface.c -o interface.o
