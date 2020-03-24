all: compile


compile:
	f95 -c main.f90
	f95 -o Run main.o

clean:
	rm -rf *.o *.mod
