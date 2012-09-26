#^CFG FILE TESTING

### BIERMANN BATTERY TESTS ###

test: 
	@rm -f output/*.diff
	-@(make test_wave)
	-@(make test_rzwave)
	-@(make test_wavesemi)
	-@(make test_gaussiansemi_cyl)
	@ls -l output/*.diff

# Path to this test directory from the main directory
TESTDIR = CRASHTEST/Mhd/Resistivity

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
	@echo "    test_wave                  (run wave test in xy-plane)"
	@echo "    test_rzwave                (run wave test in rz-plane)"
	@echo "    test_wavesemi              (run wave test in xy-plane and semi-implicit)"
	@echo "    test_gaussiansemi_cyl          (run cylindrical test and semi-implicit)"

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
	cd ${DIR}; ./Config.pl -e=MhdHypPe -u=Waves -g=4,4,1,1000,1000
	cd ${DIR}; make BATSRUS PIDL

test_wave_rundir: test_rundir
	cp input/PARAM.in.wave ${DIR}/${RUNDIR}/PARAM.in

test_wave_run:
	for RES in 10 20 40; do \
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

test_rzwave:
	@echo "test_rzwave_compile..." > output/test_rzwave.diff
	make test_rzwave_compile
	@echo "test_rzwave_rundir..." >> output/test_rzwave.diff
	make test_rzwave_rundir
	@echo "test_rzwave_run..." >> output/test_rzwave.diff
	make test_rzwave_run
	@echo "test_rzwave_check..." >> output/test_rzwave.diff
	make test_rzwave_check

test_rzwave_compile:
	cd ${DIR}; ./Config.pl -e=MhdHypPe -u=Waves -g=4,4,1,1000,1000
	cd ${DIR}; make BATSRUS PIDL

test_rzwave_rundir: test_rundir
	cp input/PARAM.in.rzwave ${DIR}/${RUNDIR}/PARAM.in

test_rzwave_run:
	for RES in 10 20 40; do \
	 make test_rzwave_run1 RES=$${RES}; \
	done
	rm -rf output/test_rzwave_results
	mv ${DIR}/${RUNDIR}/RESULTS output/test_rzwave_results

test_rzwave_run1:
	cd ${DIR}/${RUNDIR}; \
	perl -pi -e '$$a=${RES}; s/\S+(\s*nRootBlockX)/$$a$$1/; \
		     $$a=${RES}/2; s/\S+(\s*nRootBlockY)/$$a$$1/' PARAM.in
	cd ${DIR}/${RUNDIR}; \
		${MPIRUN} ./BATSRUS.exe > runlog; \
		PostProc.pl -M RESULTS/${RES}

test_rzwave_check:
	cd output; idl test_rzwave.pro; \
		rm -f test_rzwave_results/*.eps
	-(${SCRIPTDIR}/DiffNum.pl \
		output/test_rzwave_results/error.dat \
		output/test_rzwave.ref \
		> output/test_rzwave.diff)
	ls -l output/test_rzwave.diff

### Wave test on 2D AMR grid ###

test_wavesemi:
	@echo "test_wavesemi_compile..." > output/test_wavesemi.diff
	make test_wavesemi_compile
	@echo "test_wavesemi_rundir..." >> output/test_wavesemi.diff
	make test_wavesemi_rundir
	@echo "test_wavesemi_run..." >> output/test_wavesemi.diff
	make test_wavesemi_run
	@echo "test_wavesemi_check..." >> output/test_wavesemi.diff
	make test_wavesemi_check

test_wavesemi_compile:
	cd ${DIR}; ./Config.pl -e=MhdHypPe -u=Waves -g=4,4,1,1000,1000
	cd ${DIR}; make BATSRUS PIDL

test_wavesemi_rundir: test_rundir
	cp input/PARAM.in.wavesemi ${DIR}/${RUNDIR}/PARAM.in

test_wavesemi_run:
	for RES in 10 20 40; do \
	 make test_wavesemi_run1 RES=$${RES}; \
	done
	rm -rf output/test_wavesemi_results
	mv ${DIR}/${RUNDIR}/RESULTS output/test_wavesemi_results

test_wavesemi_run1:
	cd ${DIR}/${RUNDIR}; \
	perl -pi -e '$$a=${RES}; s/\S+(\s*nRootBlockX)/$$a$$1/; \
		     $$a=${RES}; s/\S+(\s*nRootBlockY)/$$a$$1/; \
		     $$a=0.005*(10/${RES})**2; s/\S+(\s*DtFixed)/$$a$$1/' PARAM.in
	cd ${DIR}/${RUNDIR}; \
		${MPIRUN} ./BATSRUS.exe > runlog; \
		PostProc.pl -M RESULTS/${RES}

test_wavesemi_check:
	cd output; idl test_wavesemi.pro; \
		rm -f test_wavesemi_results/*.eps
	-(${SCRIPTDIR}/DiffNum.pl \
		output/test_wavesemi_results/error.dat \
		output/test_wavesemi.ref \
		> output/test_wavesemi.diff)
	ls -l output/test_wavesemi.diff

### 2D semi-implicit test in cylindrical coordinates ###

test_gaussiansemi_cyl:
	@echo "test_gaussiansemi_cyl_compile..." > output/test_gaussiansemi_cyl.diff
	make test_gaussiansemi_cyl_compile
	@echo "test_gaussiansemi_cyl_rundir..." >> output/test_gaussiansemi_cyl.diff
	make test_gaussiansemi_cyl_rundir
	@echo "test_gaussiansemi_cyl_run..." >> output/test_gaussiansemi_cyl.diff
	make test_gaussiansemi_cyl_run
	@echo "test_gaussiansemi_cyl_check..." >> output/test_gaussiansemi_cyl.diff
	make test_gaussiansemi_cyl_check

test_gaussiansemi_cyl_compile:
	cd ${DIR}; ./Config.pl -e=Mhd -u=Waves -g=4,4,1,1000,1000
	cd ${DIR}; make BATSRUS PIDL

test_gaussiansemi_cyl_rundir: test_rundir
	cp input/PARAM.in.gaussiansemi_cyl ${DIR}/${RUNDIR}/PARAM.in

test_gaussiansemi_cyl_run:
	for RES in 2 4 8; do \
	 make test_gaussiansemi_cyl_run1 RES=$${RES}; \
	done
	rm -rf output/test_gaussiansemi_cyl_results
	mv ${DIR}/${RUNDIR}/RESULTS output/test_gaussiansemi_cyl_results

test_gaussiansemi_cyl_run1:
	cd ${DIR}/${RUNDIR}; \
        perl -pi -e '$$a=${RES}; s/\S+(\s*nRootBlockX)/$$a$$1/; \
                     $$a=${RES}; s/\S+(\s*nRootBlockY)/$$a$$1/; \
                     $$a=0.001*(2/${RES})**2; s/\S+(\s*DtFixed)/$$a$$1/' PARAM\
.in
	cd ${DIR}/${RUNDIR}; \
		${MPIRUN} ./BATSRUS.exe > runlog; \
		PostProc.pl -M RESULTS/${RES}

test_gaussiansemi_cyl_check:
	cd output; idl test_gaussiansemi_cyl.pro; \
		rm -f test_gaussiansemi_cyl_results/*.eps
	-(${SCRIPTDIR}/DiffNum.pl \
		output/test_gaussiansemi_cyl_results/error.dat \
		output/test_gaussiansemi_cyl.ref \
		> output/test_gaussiansemi_cyl.diff)
	ls -l output/test_gaussiansemi_cyl.diff
