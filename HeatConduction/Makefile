#^CFG FILE TESTING

### RADHYDRO TESTS FOR IDEAL GAS WITH GREY DIFFUSION ###

test: 
	@rm -f output/*.diff
	-@(make test_uniform_1d)
	-@(make test_uniform_2d)
	@ls -l output/*.diff

# Path to this test directory from the main directory
TESTDIR = CRASHTEST/HeatConduction

# Main BATSRUS/CRASH directory
DIR = ../..

# All tests are done in this directory:
RUNDIR = run_test

# Tests are done either parallel or serial. Default:
MPIRUN = mpirun -np 2

help:
	@echo "    test                       (run all tests with ${MPIRUN})"
	@echo "    test MPIRUN=               (run all tests serially)"
	@echo "    test MPIRUN='mpirun -np 3' (run test with mpirun -np 3)"
	@echo "    test MPIRUN='mprun -np 2'  (run test with mprun -np 2)"
	@echo "    test_uniform_1d            (run uniform heat conduction test in 1D)"
	@echo "    test_uniform_2d            (run uniform heat conduction test in 2D)"


test_rundir:
	cd ${DIR}; \
		rm -rf ${RUNDIR}; \
		make rundir RUNDIR=${RUNDIR} STANDALONE=YES GMDIR=`pwd`; \
			DEFAULT_EXE=BATSRUS.exe


### Heat conduction test in 1D with uniform diffusion coefficient ###

test_uniform_1d:
	@echo "test_uniform_1d_compile..." > output/test_uniform_1d.diff
	make test_uniform_1d_compile
	@echo "test_uniform_1d_rundir..." >> output/test_uniform_1d.diff
	make test_uniform_1d_rundir
	@echo "test_uniform_1d_run..." >> output/test_uniform_1d.diff
	make test_uniform_1d_run
	@echo "test_uniform_1d_check..." >> output/test_uniform_1d.diff
	make test_uniform_1d_check

test_uniform_1d_compile:
	cd ${DIR}; ./Config.pl -u=HeatConduction -e=Hd -g=100,2,2,16,1
	cd ${DIR}; make BATSRUS PIDL

test_uniform_1d_rundir: test_rundir
	cp input/PARAM.in.uniform_1d ${DIR}/${RUNDIR}/PARAM.in

test_uniform_1d_run:
	make test_uniform_1d_run_res RES=200
	make test_uniform_1d_run_res RES=400
	make test_uniform_1d_run_res RES=800
	make test_uniform_1d_run_res RES=1600
	make test_uniform_1d_run_res RES=3200
	rm -rf output/test_uniform_1d_results
	mv ${DIR}/${RUNDIR}/RESULTS output/test_uniform_1d_results

test_uniform_1d_run_res:
	cd ${DIR}/${RUNDIR}; \
		perl -pi -e '$$a=${RES}/100; s/\S+(\s*nRootBlockX)/$$a$$1/' PARAM.in
	cd ${DIR}/${RUNDIR}; \
		${MPIRUN} ./BATSRUS.exe > runlog; \
		PostProc.pl -M RESULTS/${RES}

test_uniform_1d_check:
	cd output; idl test_uniform_1d.pro
	-(diff  output/test_uniform_1d_results/error.dat \
		output/test_uniform_1d.ref \
		> output/test_uniform_1d.diff)
	ls -l output/test_uniform_1d.diff


### Heat conduction test in 2D with uniform diffusion coefficient ###

test_uniform_2d:
	@echo "test_uniform_2d_compile..." > output/test_uniform_2d.diff
	make test_uniform_2d_compile
	@echo "test_uniform_2d_rundir..." >> output/test_uniform_2d.diff
	make test_uniform_2d_rundir
	@echo "test_uniform_2d_run..." >> output/test_uniform_2d.diff
	make test_uniform_2d_run
	@echo "test_uniform_2d_check..." >> output/test_uniform_2d.diff
	make test_uniform_2d_check

test_uniform_2d_compile:
	cd ${DIR}; ./Config.pl -u=HeatConduction -e=Hd -g=20,20,2,800,1
	cd ${DIR}; make BATSRUS PIDL

test_uniform_2d_rundir: test_rundir
	cp input/PARAM.in.uniform_2d ${DIR}/${RUNDIR}/PARAM.in

test_uniform_2d_run:
	make test_uniform_2d_run_res RES=100
	make test_uniform_2d_run_res RES=200
	make test_uniform_2d_run_res RES=400
	make test_uniform_2d_run_res RES=800
	rm -rf output/test_uniform_2d_results
	mv ${DIR}/${RUNDIR}/RESULTS output/test_uniform_2d_results

test_uniform_2d_run_res:
	cd ${DIR}/${RUNDIR}; \
		perl -pi -e '$$a=${RES}/20; s/\S+(\s*nRootBlockX)/$$a$$1/' PARAM.in;\
		perl -pi -e '$$a=${RES}/20; s/\S+(\s*nRootBlockY)/$$a$$1/' PARAM.in
	cd ${DIR}/${RUNDIR}; \
		${MPIRUN} ./BATSRUS.exe > runlog; \
		PostProc.pl -M RESULTS/${RES}

test_uniform_2d_check:
	cd output; idl test_uniform_2d.pro
	-(diff  output/test_uniform_2d_results/error.dat \
		output/test_uniform_2d.ref \
		> output/test_uniform_2d.diff)
	ls -l output/test_uniform_2d.diff


clean:
	rm -f *~ input/*~ output/*~
	cd output; rm -rf *.diff *_results

distclean: clean
