FC=gfortran
OBJS=test.o

test: $(OBJS)
	$(FC) -o $@ $?

clean:
	rm -rf *.mod *.o a.out test

%.o: %.f90
	$(FC) -c -o $@ $<