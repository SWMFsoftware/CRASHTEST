#^CFG FILE TESTING

### BIERMANN BATTERY TESTS ###

test: 
	@rm -f output/*.diff
	-@(make test_wave_1step)
	-@(make test_wave)
	-@(make test_rzwave_1step)
	@ls -l output/*.diff

# Path to this test directory from the main directory
TESTDIR = CRASHTEST/Mhd/Biermann

# Main BATSRUS/CRASH directory
DIR = ../../..

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
	@echo "    test_wave_1step            (run wave test 1 step)"
	@echo "    test_wave                  (run wave test)"
	@echo "    test_rzwave_1step          (run wave test 1 step in rz-geometry)"

test_rundir:
	cd ${DIR}; \
		rm -rf ${RUNDIR}; \
		make rundir RUNDIR=${RUNDIR} STANDALONE=YES GMDIR=`pwd`; \
			DEFAULT_EXE=BATSRUS.exe

clean:
	rm -f *~ input/*~ output/*~
	cd output; rm -rf *.diff *.err *.eps *_results

distclean: clean

### Wave test on 2D AMR grid ###

test_wave_1step:
	@echo "test_wave_1step_compile..." > output/test_wave_1step.diff
	make test_wave_1step_compile
	@echo "test_wave_1step_rundir..." >> output/test_wave_1step.diff
	make test_wave_1step_rundir
	@echo "test_wave_1step_run..." >> output/test_wave_1step.diff
	make test_wave_1step_run
	@echo "test_wave_1step_check..." >> output/test_wave_1step.diff
	make test_wave_1step_check

test_wave_1step_compile:
	cd ${DIR}; ./Config.pl -e=MhdHypPe -u=Waves -g=4,4,1,2000,1
	cd ${DIR}; make BATSRUS PIDL

test_wave_1step_rundir: test_rundir
	cp input/PARAM.in.wave_1step ${DIR}/${RUNDIR}/PARAM.in

test_wave_1step_run:
	for RES in 10 20 40; do \
	 make test_wave_1step_run1 RES=$${RES}; \
	done
	rm -rf output/test_wave_1step_results
	mv ${DIR}/${RUNDIR}/RESULTS output/test_wave_1step_results

test_wave_1step_run1:
	cd ${DIR}/${RUNDIR}; \
	perl -pi -e '$$a=${RES}; s/\S+(\s*nRootBlockX)/$$a$$1/; \
		     $$a=${RES}; s/\S+(\s*nRootBlockY)/$$a$$1/' PARAM.in
	cd ${DIR}/${RUNDIR}; \
		${MPIRUN} ./BATSRUS.exe > runlog; \
		PostProc.pl -M RESULTS/${RES}

test_wave_1step_check:
	cd output; idl test_wave_1step.pro; \
		rm -f test_wave_1step_results/*.eps
	-(${SCRIPTDIR}/DiffNum.pl \
		output/test_wave_1step_results/error.dat \
		output/test_wave_1step.ref \
		> output/test_wave_1step.diff)
	ls -l output/test_wave_1step.diff

### Wave test on 2D AMR grid ###

test_wave:
	@echo "test_wave_compile..." > output/test_wave.diff
	make test_wave_compile
	@echo "test_wave_rundir..." >> output/test_wave.diff
	make test_wave_rundir
	@echo "test_wave_run..." >> output/test_wave.diff
	make test_wave_run
	@echo "test_wave_check..." >> output/test_wave.diff
	make test_wave_check

test_wave_compile:
	cd ${DIR}; ./Config.pl -e=MhdHypPe -u=Waves -g=4,4,1,2000,1
	cd ${DIR}; make BATSRUS PIDL

test_wave_rundir: test_rundir
	cp input/PARAM.in.wave ${DIR}/${RUNDIR}/PARAM.in

test_wave_run:
	for RES in 10 20 40 80; do \
	 make test_wave_run1 RES=$${RES}; \
	done
	rm -rf output/test_wave_results
	mv ${DIR}/${RUNDIR}/RESULTS output/test_wave_results

test_wave_run1:
	cd ${DIR}/${RUNDIR}; \
	perl -pi -e '$$a=${RES}; s/\S+(\s*nRootBlockX)/$$a$$1/; \
		     $$a=${RES}; s/\S+(\s*nRootBlockY)/$$a$$1/' PARAM.in
	cd ${DIR}/${RUNDIR}; \
		${MPIRUN} ./BATSRUS.exe > runlog; \
		PostProc.pl -M RESULTS/${RES}

test_wave_check:
	cd output; idl test_wave.pro; \
		rm -f test_wave_results/*.eps
	-(${SCRIPTDIR}/DiffNum.pl \
		output/test_wave_results/error.dat \
		output/test_wave.ref \
		> output/test_wave.diff)
	ls -l output/test_wave.diff


### Wave test on 2D AMR grid ###

test_rzwave_1step:
	@echo "test_rzwave_1step_compile..." > output/test_rzwave_1step.diff
	make test_rzwave_1step_compile
	@echo "test_rzwave_1step_rundir..." >> output/test_rzwave_1step.diff
	make test_rzwave_1step_rundir
	@echo "test_rzwave_1step_run..." >> output/test_rzwave_1step.diff
	make test_rzwave_1step_run
	@echo "test_rzwave_1step_check..." >> output/test_rzwave_1step.diff
	make test_rzwave_1step_check

test_rzwave_1step_compile:
	cd ${DIR}; ./Config.pl -e=MhdHypPe -u=Waves -g=4,4,1,2000,1
	cd ${DIR}; make BATSRUS PIDL

test_rzwave_1step_rundir: test_rundir
	cp input/PARAM.in.rzwave_1step ${DIR}/${RUNDIR}/PARAM.in

test_rzwave_1step_run:
	for RES in 10 20 40; do \
	 make test_rzwave_1step_run1 RES=$${RES}; \
	done
	rm -rf output/test_rzwave_1step_results
	mv ${DIR}/${RUNDIR}/RESULTS output/test_rzwave_1step_results

test_rzwave_1step_run1:
	cd ${DIR}/${RUNDIR}; \
	perl -pi -e '$$a=${RES}; s/\S+(\s*nRootBlockX)/$$a$$1/; \
		     $$a=${RES}/2; s/\S+(\s*nRootBlockY)/$$a$$1/' PARAM.in
	cd ${DIR}/${RUNDIR}; \
		${MPIRUN} ./BATSRUS.exe > runlog; \
		PostProc.pl -M RESULTS/${RES}

test_rzwave_1step_check:
	cd output; idl test_rzwave_1step.pro; \
		rm -f test_rzwave_1step_results/*.eps
	-(${SCRIPTDIR}/DiffNum.pl \
		output/test_rzwave_1step_results/error.dat \
		output/test_rzwave_1step.ref \
		> output/test_rzwave_1step.diff)
	ls -l output/test_rzwave_1step.diff
