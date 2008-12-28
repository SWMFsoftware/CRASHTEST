MPIRUN = mpirun -np 6

help:
	@echo "Examples:"
	@echo "make test                       (run all tests with ${MPIRUN})"
	@echo "make test MPIRUN=               (run all tests serially)"
	@echo "make test MPIRUN='mpirun -np 3' (run test with mpirun -np 3)"
	@echo "make test MPIRUN='mprun -np 2'  (run test with mprun -np 2)"

FILEDIFF = */*/output/*.diff */*/*/output/*.diff

test:
	@rm -f test.results ${FILEDIFF}
	-@(cd Hydro/IdealGas;                  make test)
	-@(cd Hydro/MultiEos;                  make test)
	-@(cd RadHydro/IdealGas/GrayDiffusion; make test)
	ls -l ${FILEDIFF} > test.results

clean:
	-@(cd Hydro/IdealGas;                  make clean)
	-@(cd Hydro/MultiEos;                  make clean)
	-@(cd RadHydro/IdealGas/GrayDiffusion; make clean)

distclean: clean
	@rm -f test.results
