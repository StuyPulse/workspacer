all:
	gcc -c interface.c
	gcc -c isUserTaken.c
	gcc -c addUser.c
	gcc -c checkCredentials.c
	gcc -c saveWork.c
	gcc interface.o isUserTaken.o -o isUserTaken
	gcc interface.o addUser.o -o addUser
	gcc interface.o checkCredentials.o -o checkCredentials
	gcc interface.o saveWork.o -o saveWork
	chown :robogroup addUser checkCredentials isUserTaken saveWork
	chmod +s isUserTaken addUser checkCredentials saveWork
	chmod o-x isUserTaken addUser checkCredentials saveWork
	chown :robogroup their-work
	chmod 770 their-work
	chmod 600 users.csv

clean:
	rm -f *.o
	rm -f isUserTaken
	rm -f addUser
	rm -f checkCredentials
	rm -f saveWork
