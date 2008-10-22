#^CFG FILE TESTING

### RADHYDRO TESTS FOR IDEAL GAS WITH GREY DIFFUSION ###

test: 
	@rm -f *.diff
	-@(make test_lowrie1_amr)
	-@(make test_lowrie2_2d)
	@ls -l *.diff

# Path to this test directory from the main directory
TESTDIR = CRASH_TEST/RadHydro/IdealGas/GrayDiffusion

# Main BATSRUS/CRASH directory
DIR = ../../../..

# All tests are done in this directory:
RUNDIR = run_test

# Tests are done either parallel or serial. Default:
MPIRUN = mpirun -np 2

help:
	@echo "    test                       (run all tests with ${MPIRUN})"
	@echo "    test MPIRUN=               (run all tests serially)"
	@echo "    test MPIRUN='mpirun -np 3' (run test with mpirun -np 3)"
	@echo "    test MPIRUN='mprun -np 2'  (run test with mprun -np 2)"
	@echo "    test_lowrie1_amr           (run Lowrie's test 1 with AMR only)"
	@echo "    test_lowrie2_2d            (run Lowrie's test 2 in 2D only)"

test_rundir:
	cd ${DIR}; \
		rm -rf ${RUNDIR}; \
		make rundir RUNDIR=${RUNDIR} STANDALONE=YES GMDIR=`pwd`; \
			DEFAULT_EXE=BATSRUS.exe


### Lowrie's 1 test with AMR grid ###

test_lowrie1_amr:
	@echo "test_lowrie1_amr_compile..." > test_lowrie1_amr.diff
	make test_lowrie1_amr_compile
	@echo "test_lowrie1_amr_rundir..." >> test_lowrie1_amr.diff
	make test_lowrie1_amr_rundir
	@echo "test_lowrie1_amr_run..." >> test_lowrie1_amr.diff
	make test_lowrie1_amr_run
	@echo "test_lowrie1_amr_check..." >> test_lowrie1_amr.diff
	make test_lowrie1_amr_check

test_lowrie1_amr_compile:
	cd ${DIR}; ./Config.pl -u=GrayDiffusion -e=HdEosRad -g=8,4,4,600,512
	cd ${DIR}; make BATSRUS PIDL

test_lowrie1_amr_rundir: test_rundir
	cp input/PARAM.in.lowrie1_amr ${DIR}/${RUNDIR}/PARAM.in
	cp input/initial_lowrie1.dat  ${DIR}/${RUNDIR}/

test_lowrie1_amr_run:
	make test_lowrie1_amr_run_res RES=24
	make test_lowrie1_amr_run_res RES=48
	make test_lowrie1_amr_run_res RES=96
	make test_lowrie1_amr_run_res RES=192
	rm -rf output/test_lowrie1_amr_results
	mv ${DIR}/${RUNDIR}/RESULTS output/test_lowrie1_amr_results

test_lowrie1_amr_run_res:
	cd ${DIR}/${RUNDIR}; \
		perl -pi -e '$$a=${RES}/8; s/\S+(\s*nRootBlockX)/$$a$$1/' PARAM.in; \
		perl -pi -e '$$a=${RES}/8; s/\S+(\s*nRootBlockY)/$$a$$1/' PARAM.in; \
		perl -pi -e '$$a=1.2e-3*24/${RES}; s/\S+(\s*DtFixedDim)/$$a$$1/' PARAM.in
	cd ${DIR}/${RUNDIR}; \
		${MPIRUN} ./BATSRUS.exe > runlog; \
		PostProc.pl -M RESULTS/${RES}

test_lowrie1_amr_check:
	cd output; \
		idl test_lowrie1_amr_error.pro; \
		diff test_lowrie1_amr.err test_lowrie1_amr.ref > test_lowrie1_amr.diff; \
		ls -l test_lowrie1_amr.diff; \
		idl test_lowrie1_amr_fig.pro

clean:
	rm -f *~ input/*~ output/*~
	cd output; rm -rf *.diff *.err *.eps *_results

distclean: clean
