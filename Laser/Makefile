#^CFG FILE TESTING

### Laser package test ###

test: 
	@rm -f output/*.diff
	-@(make test_onebeam)
	-@(make test_onebeam_amr)
	@ls -l output/*.diff

# Path to this test directory from the main directory
TESTDIR = CRASHTEST/Radiography

# Main BATSRUS/CRASH directory
DIR = ../..

SCRIPTDIR = ${DIR}/share/Scripts

# All tests are done in this directory:
RUNDIR = run_test

# Tests are done either parallel or serial. Default:
MPIRUN = mpirun -np 2

help:
	@echo "    test                       (run all tests with ${MPIRUN})"
	@echo "    test MPIRUN=               (run all tests serially)"
	@echo "    test MPIRUN='mpirun -np 3' (run test with mpirun -np 3)"
	@echo "    test MPIRUN='mprun -np 2'  (run test with mprun -np 2)"
	@echo "    test_onebeam               (run single beam test of Kruer)"
	@echo "    test_onebeam_amr           (run single beam test of Kruer)"

test_rundir:
	cd ${DIR}; \
		rm -rf ${RUNDIR}; \
		make rundir RUNDIR=${RUNDIR} STANDALONE=YES GMDIR=`pwd` \
			DEFAULT_EXE=CRASH.exe


clean:
	rm -f *~ input/*~ output/*~
	cd output; rm -rf *.diff *_results

distclean: clean

### single ray test: The Physics of Laser Interactions by W.L. Kruer, p. 51 ###

test_onebeam:
	@echo "test_onebeam_compile..." > output/test_onebeam.diff
	make test_onebeam_compile
	@echo "test_onebeam_rundir..." >> output/test_onebeam.diff
	make test_onebeam_rundir
	@echo "test_onebeam_run..." >> output/test_onebeam.diff
	make test_onebeam_run
	@echo "test_onebeam_check..." >> output/test_onebeam.diff
	make test_onebeam_check

test_onebeam_compile:
	cd ${DIR}; ./Config.pl  -e=Crash -u=Crash -g=4,4,1,3000,3000 \
		-nMaterial=5 -nWave=30
	cd ${DIR}; make CRASH PIDL

test_onebeam_rundir: test_rundir
	cp input/PARAM.in_onebeam ${DIR}/${RUNDIR}/PARAM.in
	cd ${DIR}/${RUNDIR}; ln -s ../dataCRASH/LookupTables Tables

test_onebeam_run:
	make test_onebeam_run_res RES=1
	make test_onebeam_run_res RES=2
	make test_onebeam_run_res RES=4
	rm -rf output/test_onebeam_results
	mv ${DIR}/${RUNDIR}/RESULTS output/test_onebeam_results

test_onebeam_run_res:
	cd ${DIR}/${RUNDIR}; \
	perl -pi -e '$$a=34*${RES}; s/\S+(\s*nRootBlockX)/$$a$$1/' PARAM.in
	cd ${DIR}/${RUNDIR}; \
		${MPIRUN} ./CRASH.exe > runlog; \
		PostProc.pl RESULTS/${RES}

test_onebeam_check:
	cd output; onebeam.pl test_onebeam
	-(diff  output/test_onebeam_results/error.dat \
		output/test_onebeam.ref \
		> output/test_onebeam.diff)
	ls -l output/test_onebeam.diff

### single ray test: The Physics of Laser Interactions by W.L. Kruer, p. 51 ###

test_onebeam_amr:
	@echo "test_onebeam_amr_compile..." > output/test_onebeam_amr.diff
	make test_onebeam_amr_compile
	@echo "test_onebeam_amr_rundir..." >> output/test_onebeam_amr.diff
	make test_onebeam_amr_rundir
	@echo "test_onebeam_amr_run..." >> output/test_onebeam_amr.diff
	make test_onebeam_amr_run
	@echo "test_onebeam_amr_check..." >> output/test_onebeam_amr.diff
	make test_onebeam_amr_check

test_onebeam_amr_compile:
	cd ${DIR}; ./Config.pl  -e=Crash -u=Crash -g=4,4,1,10000,10000 \
		-nMaterial=5 -nWave=30
	cd ${DIR}; make CRASH PIDL

test_onebeam_amr_rundir: test_rundir
	cp input/PARAM.in_onebeam_amr ${DIR}/${RUNDIR}/PARAM.in
	cd ${DIR}/${RUNDIR}; ln -s ../dataCRASH/LookupTables Tables

test_onebeam_amr_run:
	make test_onebeam_amr_run_res RES=1
	make test_onebeam_amr_run_res RES=2
	make test_onebeam_amr_run_res RES=4
	rm -rf output/test_onebeam_amr_results
	mv ${DIR}/${RUNDIR}/RESULTS output/test_onebeam_amr_results

test_onebeam_amr_run_res:
	cd ${DIR}/${RUNDIR}; \
	perl -pi -e '$$a=68*${RES}; s/\S+(\s*nRootBlockX)/$$a$$1/' PARAM.in
	cd ${DIR}/${RUNDIR}; \
		${MPIRUN} ./CRASH.exe > runlog; \
		PostProc.pl RESULTS/${RES}

test_onebeam_amr_check:
	cd output; onebeam.pl test_onebeam_amr
	-(diff  output/test_onebeam_amr_results/error.dat \
		output/test_onebeam_amr.ref \
		> output/test_onebeam_amr.diff)
	ls -l output/test_onebeam_amr.diff
