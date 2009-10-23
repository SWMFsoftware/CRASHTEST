MPIRUN = mpirun -np 6

help:
	@echo "Examples:"
	@echo "make test                       (run all tests with ${MPIRUN})"
	@echo "make test MPIRUN=               (run all tests serially)"
	@echo "make test MPIRUN='mpirun -np 3' (run test with mpirun -np 3)"
	@echo "make test MPIRUN='mprun -np 2'  (run test with mprun -np 2)"

FILEDIFF = */output/*.diff */*/output/*.diff */*/*/output/*.diff

test:
	@rm -f test.results ${FILEDIFF}
	-@(cd HeatConduction;                  make test)
	-@(cd Radiation/GrayDiffusion;         make test)
	-@(cd Radiation/MultiGroup;            make test)
	-@(cd Radiography;                     make test)
	-@(cd Hydro/IdealGas;                  make test)
	-@(cd Hydro/MultiEos;                  make test)
	-@(cd RadHydro/IdealGas/GrayDiffusion; make test)
	-@(cd FullSystem/Version1;             make test)
	make check

check:
	@echo "<PRE>"      >  test_results.html
	ls -ltr ${FILEDIFF} >> test_results.html
	@echo "</PRE>"     >> test_results.html
	@perl -pi -e 's/(\S+diff)$$/<A HREF=$$1\>$$1<\/A>/' test_results.html

clean:
	-@(cd HeatConduction;                  make clean)
	-@(cd Radiation/GrayDiffusion;         make clean)
	-@(cd Radiation/MultiGroup;            make clean)
	-@(cd Radiography;                     make clean)
	-@(cd Hydro/IdealGas;                  make clean)
	-@(cd Hydro/MultiEos;                  make clean)
	-@(cd RadHydro/IdealGas/GrayDiffusion; make clean)
	-@(cd FullSystem/Version1;             make clean)

distclean: clean
	@rm -f test.results
