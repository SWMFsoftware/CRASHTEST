#^CFG FILE TESTING

### GRAY DIFFUSION RADIATION TESTS ###

test: 
	@rm -f output/*.diff
	-@(make test_lightfront)
	@ls -l output/*.diff

# Path to this test directory from the main directory
TESTDIR = CRASHTEST/Radiation/MultiGroup

# Main BATSRUS/CRASH directory
DIR = ../../..

# All tests are done in this directory:
RUNDIR = run_test

# Tests are done either parallel or serial. Default:
MPIRUN = mpirun -np 16

help:
	@echo "    test                       (run all tests with ${MPIRUN})"
	@echo "    test MPIRUN=               (run all tests serially)"
	@echo "    test MPIRUN='mpirun -np 3' (run test with mpirun -np 3)"
	@echo "    test MPIRUN='mprun -np 2'  (run test with mprun -np 2)"
	@echo "    test_lightfront            (run lightfront test in 1D)"


test_rundir:
	cd ${DIR}; \
		rm -rf ${RUNDIR}; \
		make rundir RUNDIR=${RUNDIR} STANDALONE=YES GMDIR=`pwd`; \
			DEFAULT_EXE=BATSRUS.exe


### lightfront test in 1D ###

test_lightfront:
	@echo "test_lightfront_compile..." > output/test_lightfront.diff
	make test_lightfront_compile
	@echo "test_lightfront_rundir..." >> output/test_lightfront.diff
	make test_lightfront_rundir
	@echo "test_lightfront_run..." >> output/test_lightfront.diff
	make test_lightfront_run
	@echo "test_lightfront_check..." >> output/test_lightfront.diff
	make test_lightfront_check

test_lightfront_compile:
	cd ${DIR}; ./Config.pl -u=MultiGroup -e=HdEosRad -g=4,4,4,1000,1000 -setvar=nWave=2
	cd ${DIR}; make BATSRUS PIDL

test_lightfront_rundir: test_rundir

test_lightfront_run:
	for DIM in X Y Z; do \
	 for RES in 40 80 160; do \
	  cp input/PARAM.in.lightfront_$${DIM} ${DIR}/${RUNDIR}/PARAM.in; \
	  make test_lightfront_run1 RES=$${RES} DIM=$${DIM}; \
	 done \
	done
	rm -rf output/test_lightfront_results
	mv ${DIR}/${RUNDIR}/RESULTS output/test_lightfront_results

test_lightfront_run1:
	cd ${DIR}/${RUNDIR}; \
		perl -pi -e '$$a=${RES}/4; s/\S+(\s*nRootBlock${DIM})/$$a$$1/' PARAM.in; \
		perl -pi -e '$$a=4.16959e-6*40/${RES}; s/\S+(\s*DtFixedDim)/$$a$$1/' PARAM.in
	cd ${DIR}/${RUNDIR}; \
		${MPIRUN} ./BATSRUS.exe > runlog; \
		PostProc.pl -M RESULTS/${DIM}_${RES}

test_lightfront_check:
	cd output; idl test_lightfront.pro; \
		rm -f test_lightfront_results/*.eps
	-(diff  output/test_lightfront_results/error.dat \
		output/test_lightfront.ref \
		> output/test_lightfront.diff)
	ls -l output/test_lightfront.diff


clean:
	rm -f *~ input/*~ output/*~
	cd output; rm -rf *.diff *_results

distclean: clean
