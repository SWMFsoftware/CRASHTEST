#^CFG FILE TESTING

### RADHYDRO TESTS FOR IDEAL GAS WITH GREY DIFFUSION ###

test: 
	@rm -f output/*.diff
	-@(make test_lowrie1_amr)
	-@(make test_lowrie2_amr)
	-@(make test_lowrie3_amr)
	@ls -l output/*.diff

# Path to this test directory from the main directory
TESTDIR = CRASHTEST/RadHydro/IdealGas/GrayDiffusion

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
	@echo "    test_lowrie1_amr           (run Lowrie's test 1 with AMR)"
	@echo "    test_lowrie2_amr           (run Lowrie's test 2 with AMR)"
	@echo "    test_lowrie3_amr           (run Lowrie's test 3 with AMR)"

test_rundir:
	cd ${DIR}; \
		rm -rf ${RUNDIR}; \
		make rundir RUNDIR=${RUNDIR} STANDALONE=YES GMDIR=`pwd`; \
			DEFAULT_EXE=BATSRUS.exe


### Lowrie's 1 test with AMR grid ###

test_lowrie1_amr:
	@echo "test_lowrie1_amr_compile..." > output/test_lowrie1_amr.diff
	make test_lowrie1_amr_compile
	@echo "test_lowrie1_amr_rundir..." >> output/test_lowrie1_amr.diff
	make test_lowrie1_amr_rundir
	@echo "test_lowrie1_amr_run..." >> output/test_lowrie1_amr.diff
	make test_lowrie1_amr_run
	@echo "test_lowrie1_amr_check..." >> output/test_lowrie1_amr.diff
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
	cd output; idl test_lowrie1_amr.pro; \
		rm -f test_lowrie1_amr_results/*.eps
	-(diff  output/test_lowrie1_amr_results/error.dat \
		output/test_lowrie1_amr.ref \
		> output/test_lowrie1_amr.diff)
	ls -l output/test_lowrie1_amr.diff


### Lowrie's 2 test with AMR grid ###

test_lowrie2_amr:
	@echo "test_lowrie2_amr_compile..." > output/test_lowrie2_amr.diff
	make test_lowrie2_amr_compile
	@echo "test_lowrie2_amr_rundir..." >> output/test_lowrie2_amr.diff
	make test_lowrie2_amr_rundir
	@echo "test_lowrie2_amr_run..." >> output/test_lowrie2_amr.diff
	make test_lowrie2_amr_run
	@echo "test_lowrie2_amr_check..." >> output/test_lowrie2_amr.diff
	make test_lowrie2_amr_check

test_lowrie2_amr_compile:
	cd ${DIR}; ./Config.pl -u=GrayDiffusion -e=HdEosRad -g=16,4,4,600,512
	cd ${DIR}; make BATSRUS PIDL

test_lowrie2_amr_rundir: test_rundir
	cp input/PARAM.in.lowrie2_amr ${DIR}/${RUNDIR}/PARAM.in
	cp input/initial_lowrie2.dat  ${DIR}/${RUNDIR}/

test_lowrie2_amr_run:
	make test_lowrie2_amr_run_res RES=48
	make test_lowrie2_amr_run_res RES=96
	make test_lowrie2_amr_run_res RES=192
	make test_lowrie2_amr_run_res RES=384
	rm -rf output/test_lowrie2_amr_results
	mv ${DIR}/${RUNDIR}/RESULTS output/test_lowrie2_amr_results

test_lowrie2_amr_run_res:
	cd ${DIR}/${RUNDIR}; \
		perl -pi -e '$$a=${RES}/16; s/\S+(\s*nRootBlockX)/$$a$$1/' PARAM.in; \
		perl -pi -e '$$a=${RES}/16; s/\S+(\s*nRootBlockY)/$$a$$1/' PARAM.in; \
		perl -pi -e '$$a=8.5e-5*48/${RES}; s/\S+(\s*DtFixedDim)/$$a$$1/' PARAM.in
	cd ${DIR}/${RUNDIR}; \
		${MPIRUN} ./BATSRUS.exe > runlog; \
		PostProc.pl -M RESULTS/${RES}

test_lowrie2_amr_check:
	cd output; idl test_lowrie2_amr.pro; \
		rm -f test_lowrie2_amr_results/*.eps
	-(diff  output/test_lowrie2_amr_results/error.dat \
		output/test_lowrie2_amr.ref \
		> output/test_lowrie2_amr.diff)
	ls -l output/test_lowrie2_amr.diff


### Lowrie's 3 test with AMR grid ###

test_lowrie3_amr:
	@echo "test_lowrie3_amr_compile..." > output/test_lowrie3_amr.diff
	make test_lowrie3_amr_compile
	@echo "test_lowrie3_amr_rundir..." >> output/test_lowrie3_amr.diff
	make test_lowrie3_amr_rundir
	@echo "test_lowrie3_amr_run..." >> output/test_lowrie3_amr.diff
	make test_lowrie3_amr_run
	@echo "test_lowrie3_amr_check..." >> output/test_lowrie3_amr.diff
	make test_lowrie3_amr_check

test_lowrie3_amr_compile:
	cd ${DIR}; ./Config.pl -u=GrayDiffusion -e=HdEosRad -g=32,4,4,600,512
	cd ${DIR}; make BATSRUS PIDL

test_lowrie3_amr_rundir: test_rundir
	cp input/PARAM.in.lowrie3_amr ${DIR}/${RUNDIR}/PARAM.in
	cp input/initial_lowrie3.dat  ${DIR}/${RUNDIR}/

test_lowrie3_amr_run:
	make test_lowrie3_amr_run_res RES=96
	make test_lowrie3_amr_run_res RES=192
	make test_lowrie3_amr_run_res RES=384
	#make test_lowrie3_amr_run_res RES=768
	rm -rf output/test_lowrie3_amr_results
	mv ${DIR}/${RUNDIR}/RESULTS output/test_lowrie3_amr_results

test_lowrie3_amr_run_res:
	cd ${DIR}/${RUNDIR}; \
		perl -pi -e '$$a=${RES}/32; s/\S+(\s*nRootBlockX)/$$a$$1/' PARAM.in; \
		perl -pi -e '$$a=${RES}/32; s/\S+(\s*nRootBlockY)/$$a$$1/' PARAM.in; \
		perl -pi -e '$$a=2.3e-5*96/${RES}; s/\S+(\s*DtFixedDim)/$$a$$1/' PARAM.in
	cd ${DIR}/${RUNDIR}; \
		${MPIRUN} ./BATSRUS.exe > runlog; \
		PostProc.pl -M RESULTS/${RES}

test_lowrie3_amr_check:
	cd output; idl test_lowrie3_amr.pro; \
		rm -f test_lowrie3_amr_results/*.eps
	-(diff  output/test_lowrie3_amr_results/error.dat \
		output/test_lowrie3_amr.ref \
		> output/test_lowrie3_amr.diff)
	ls -l output/test_lowrie3_amr.diff

clean:
	rm -f *~ input/*~ output/*~
	cd output; rm -rf *.diff *_results

distclean: clean
