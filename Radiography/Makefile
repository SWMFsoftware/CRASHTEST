#^CFG FILE TESTING

### RADHYDRO TESTS FOR IDEAL GAS WITH GREY DIFFUSION ###

test: 
	@rm -f output/*.diff
	-@(make test_sphere_3d)
	@ls -l output/*.diff

# Path to this test directory from the main directory
TESTDIR = CRASHTEST/Radiography

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
	@echo "    test_sphere_3d             (run sphere LOS test in 3D)"

test_rundir:
	cd ${DIR}; \
		rm -rf ${RUNDIR}; \
		make rundir RUNDIR=${RUNDIR} STANDALONE=YES GMDIR=`pwd` \
			DEFAULT_EXE=CRASH.exe


clean:
	rm -f *~ input/*~ output/*~
	cd output; rm -rf *.diff *_results

distclean: clean

### Heat conduction test in 1D with uniform diffusion coefficient ###

test_sphere_3d:
	@echo "test_sphere_3d_compile..." > output/test_sphere_3d.diff
	make test_sphere_3d_compile
	@echo "test_sphere_3d_rundir..." >> output/test_sphere_3d.diff
	make test_sphere_3d_rundir
	@echo "test_sphere_3d_run..." >> output/test_sphere_3d.diff
	make test_sphere_3d_run
	@echo "test_sphere_3d_check..." >> output/test_sphere_3d.diff
	make test_sphere_3d_check

test_sphere_3d_compile:
	cd ${DIR}; ./Config.pl  -e=HdRadCrash -u=Crash -g=10,10,10,600,1
	cd ${DIR}; make CRASH PIDL

test_sphere_3d_rundir: test_rundir
	cp input/PARAM.in.sphere_3d ${DIR}/${RUNDIR}/PARAM.in

test_sphere_3d_run:
	make test_sphere_3d_run_res RES=20
	make test_sphere_3d_run_res RES=40
	make test_sphere_3d_run_res RES=80
	rm -rf output/test_sphere_3d_results
	mv ${DIR}/${RUNDIR}/RESULTS output/test_sphere_3d_results

test_sphere_3d_run_res:
	cd ${DIR}/${RUNDIR}; \
		perl -pi -e '$$a=${RES}/10; s/\S+(\s*nRootBlock)/$$a$$1/' PARAM.in
	cd ${DIR}/${RUNDIR}; \
		${MPIRUN} ./CRASH.exe > runlog; \
		PostProc.pl RESULTS/${RES}

test_sphere_3d_check:
	cd output; idl test_sphere_3d.pro
	-(diff  output/test_sphere_3d_results/error.dat \
		output/test_sphere_3d.ref \
		> output/test_sphere_3d.diff)
	ls -l output/test_sphere_3d.diff
