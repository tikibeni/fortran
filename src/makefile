prog: people.o functions.o main.o
	@gfortran -o prog people.o functions.o main.o

main.o: main.f90
	@gfortran -c main.f90

people.o: people.f90
	@gfortran -c people.f90

functions.o: functions.f90
	@gfortran -c functions.f90

clean:
	@rm -rf *.o *.mod prog

simulation:
	@$(MAKE) prog --no-print-directory
	@./prog main.o
	@$(MAKE) clean --no-print-directory