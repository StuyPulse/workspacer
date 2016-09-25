gcc launch.c -o /tmp/launch.o
chmod +xs /tmp/launch.o

gcc interface.c -o interface.o

touch users.csv

mkdir their-work
chmod a+rwxt their-work/
