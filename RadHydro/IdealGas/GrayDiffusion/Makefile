#^CFG FILE TESTING

### RADHYDRO TESTS FOR IDEAL GAS WITH GREY DIFFUSION ###

test: 
	@rm -f output/*.diff
	-@(make test_lowrie1_amr)
	-@(make test_lowrie2_amr)
	-@(make test_lowrie3_amr)
	-@(make test_lowrie1_semi)
	-@(make test_lowrie2_semi)
	-@(make test_lowrie3_semi)
	-@(make test_lowrie3_dynamic)
	@ls -l output/*.diff

# Path to this test directory from the main directory
TESTDIR = CRASHTEST/RadHydro/IdealGas/GrayDiffusion

# Main BATSRUS/CRASH directory
DIR = ../../../..

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
	@echo "    test_lowrie1_amr           (run Lowrie's test 1 with AMR)"
	@echo "    test_lowrie2_amr           (run Lowrie's test 2 with AMR)"
	@echo "    test_lowrie3_amr           (run Lowrie's test 3 with AMR)"
	@echo "    test_lowrie1_semi          (run Lowrie's test 1 with AMR and semi-implicit)"
	@echo "    test_lowrie2_semi          (run Lowrie's test 2 with AMR and semi-implicit)"
	@echo "    test_lowrie3_semi          (run Lowrie's test 3 with AMR and semi-implicit)"
	@echo "    test_lowrie3_dynamic       (run Lowrie's test 3 with dynamic AMR)"

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
	cd ${DIR}; ./Config.pl -u=GrayDiffusion -e=HdEosRad -g=24,4,1,256,256
	cd ${DIR}; make BATSRUS PIDL

test_lowrie1_amr_rundir: test_rundir
	cp input/PARAM.in.lowrie1_amr ${DIR}/${RUNDIR}/PARAM.in
	cp input/initial_lowrie1.dat  ${DIR}/${RUNDIR}/

test_lowrie1_amr_run:
	make test_lowrie1_amr_run_res RES=72
	make test_lowrie1_amr_run_res RES=144
	make test_lowrie1_amr_run_res RES=288
	rm -rf output/test_lowrie1_amr_results
	mv ${DIR}/${RUNDIR}/RESULTS output/test_lowrie1_amr_results

test_lowrie1_amr_run_res:
	cd ${DIR}/${RUNDIR}; \
		perl -pi -e '$$a=${RES}/24; s/\S+(\s*nRootBlockX)/$$a$$1/' PARAM.in; \
		perl -pi -e '$$a=${RES}/24; s/\S+(\s*nRootBlockY)/$$a$$1/' PARAM.in; \
		perl -pi -e '$$a=6.0e-4*72/${RES}; s/\S+(\s*DtFixedDim)/$$a$$1/' PARAM.in
	cd ${DIR}/${RUNDIR}; \
		${MPIRUN} ./BATSRUS.exe > runlog; \
		PostProc.pl -M RESULTS/${RES}

test_lowrie1_amr_check:
	cd output; idl test_lowrie1_amr.pro; \
		rm -f test_lowrie1_amr_results/*.eps
	-(${SCRIPTDIR}/DiffNum.pl -a=2e-6  output/test_lowrie1_amr_results/error.dat \
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
	cd ${DIR}; ./Config.pl -u=GrayDiffusion -e=HdEosRad -g=32,4,1,256,256
	cd ${DIR}; make BATSRUS PIDL

test_lowrie2_amr_rundir: test_rundir
	cp input/PARAM.in.lowrie2_amr ${DIR}/${RUNDIR}/PARAM.in
	cp input/initial_lowrie2.dat  ${DIR}/${RUNDIR}/

test_lowrie2_amr_run:
	make test_lowrie2_amr_run_res RES=96
	make test_lowrie2_amr_run_res RES=192
	make test_lowrie2_amr_run_res RES=384
	rm -rf output/test_lowrie2_amr_results
	mv ${DIR}/${RUNDIR}/RESULTS output/test_lowrie2_amr_results

test_lowrie2_amr_run_res:
	cd ${DIR}/${RUNDIR}; \
		perl -pi -e '$$a=${RES}/32; s/\S+(\s*nRootBlockX)/$$a$$1/' PARAM.in; \
		perl -pi -e '$$a=${RES}/32; s/\S+(\s*nRootBlockY)/$$a$$1/' PARAM.in; \
		perl -pi -e '$$a=4.8e-5*96/${RES}; s/\S+(\s*DtFixedDim)/$$a$$1/' PARAM.in
	cd ${DIR}/${RUNDIR}; \
		${MPIRUN} ./BATSRUS.exe > runlog; \
		PostProc.pl -M RESULTS/${RES}

test_lowrie2_amr_check:
	cd output; idl test_lowrie2_amr.pro; \
		rm -f test_lowrie2_amr_results/*.eps
	-(${SCRIPTDIR}/DiffNum.pl -a=5e-7  output/test_lowrie2_amr_results/error.dat \
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
	cd ${DIR}; ./Config.pl -u=GrayDiffusion -e=HdEosRad -g=32,4,4,256,256
	cd ${DIR}; make BATSRUS PIDL

test_lowrie3_amr_rundir: test_rundir
	cp input/PARAM.in.lowrie3_amr ${DIR}/${RUNDIR}/PARAM.in
	cp input/initial_lowrie3.dat  ${DIR}/${RUNDIR}/

test_lowrie3_amr_run:
	make test_lowrie3_amr_run_res RES=96
	make test_lowrie3_amr_run_res RES=192
	make test_lowrie3_amr_run_res RES=384
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
	-(${SCRIPTDIR}/DiffNum.pl -a=3e-7  output/test_lowrie3_amr_results/error.dat \
		output/test_lowrie3_amr.ref \
		> output/test_lowrie3_amr.diff)
	ls -l output/test_lowrie3_amr.diff


### Lowrie's 1 test with AMR grid and operator split - semi-implicit ###

test_lowrie1_semi:
	@echo "test_lowrie1_semi_compile..." > output/test_lowrie1_semi.diff
	make test_lowrie1_semi_compile
	@echo "test_lowrie1_semi_rundir..." >> output/test_lowrie1_semi.diff
	make test_lowrie1_semi_rundir
	@echo "test_lowrie1_semi_run..." >> output/test_lowrie1_semi.diff
	make test_lowrie1_semi_run
	@echo "test_lowrie1_semi_check..." >> output/test_lowrie1_semi.diff
	make test_lowrie1_semi_check

test_lowrie1_semi_compile:
	cd ${DIR}; ./Config.pl -u=GrayDiffusion -e=HdEosRad -g=24,4,1,256,1
	cd ${DIR}; make BATSRUS PIDL

test_lowrie1_semi_rundir: test_rundir
	cp input/PARAM.in.lowrie1_semi ${DIR}/${RUNDIR}/PARAM.in
	cp input/initial_lowrie1.dat  ${DIR}/${RUNDIR}/

test_lowrie1_semi_run:
	make test_lowrie1_semi_run_res RES=72
	make test_lowrie1_semi_run_res RES=144
	make test_lowrie1_semi_run_res RES=288
	rm -rf output/test_lowrie1_semi_results
	mv ${DIR}/${RUNDIR}/RESULTS output/test_lowrie1_semi_results

test_lowrie1_semi_run_res:
	cd ${DIR}/${RUNDIR}; \
		perl -pi -e '$$a=${RES}/24; s/\S+(\s*nRootBlockX)/$$a$$1/' PARAM.in; \
		perl -pi -e '$$a=${RES}/24; s/\S+(\s*nRootBlockY)/$$a$$1/' PARAM.in; \
		perl -pi -e '$$a=0.8*(72/${RES}); s/\S+(\s*CflExpl)/$$a$$1/' PARAM.in
	cd ${DIR}/${RUNDIR}; \
		perl -pi -e '$$a=F; s/\S+(\s*UseNonConservative)/$$a$$1/' PARAM.in; \
		${MPIRUN} ./BATSRUS.exe > runlog; \
		PostProc.pl -M RESULTS/CONS/${RES}; \
		perl -pi -e '$$a=T; s/\S+(\s*UseNonConservative)/$$a$$1/' PARAM.in; \
		${MPIRUN} ./BATSRUS.exe > runlog; \
		PostProc.pl -M RESULTS/NONCONS/${RES}

test_lowrie1_semi_check:
	cd output; idl test_lowrie1_semi.pro; \
		rm -f test_lowrie1_semi_results/*.eps
	-(diff  output/test_lowrie1_semi_results/error.dat \
		output/test_lowrie1_semi.ref \
		> output/test_lowrie1_semi.diff)
	ls -l output/test_lowrie1_semi.diff


### Lowrie's 2 test with AMR grid and operator split - semi-implicit ###

test_lowrie2_semi:
	@echo "test_lowrie2_semi_compile..." > output/test_lowrie2_semi.diff
	make test_lowrie2_semi_compile
	@echo "test_lowrie2_semi_rundir..." >> output/test_lowrie2_semi.diff
	make test_lowrie2_semi_rundir
	@echo "test_lowrie2_semi_run..." >> output/test_lowrie2_semi.diff
	make test_lowrie2_semi_run
	@echo "test_lowrie2_semi_check..." >> output/test_lowrie2_semi.diff
	make test_lowrie2_semi_check

test_lowrie2_semi_compile:
	cd ${DIR}; ./Config.pl -u=GrayDiffusion -e=HdEosRad -g=32,4,1,256,1
	cd ${DIR}; make BATSRUS PIDL

test_lowrie2_semi_rundir: test_rundir
	cp input/PARAM.in.lowrie2_semi ${DIR}/${RUNDIR}/PARAM.in
	cp input/initial_lowrie2.dat  ${DIR}/${RUNDIR}/

test_lowrie2_semi_run:
	make test_lowrie2_semi_run_res RES=96
	make test_lowrie2_semi_run_res RES=192
	make test_lowrie2_semi_run_res RES=384
	rm -rf output/test_lowrie2_semi_results
	mv ${DIR}/${RUNDIR}/RESULTS output/test_lowrie2_semi_results

test_lowrie2_semi_run_res:
	cd ${DIR}/${RUNDIR}; \
		perl -pi -e '$$a=${RES}/32; s/\S+(\s*nRootBlockX)/$$a$$1/' PARAM.in; \
		perl -pi -e '$$a=${RES}/32; s/\S+(\s*nRootBlockY)/$$a$$1/' PARAM.in
	cd ${DIR}/${RUNDIR}; \
		${MPIRUN} ./BATSRUS.exe > runlog; \
		PostProc.pl -M RESULTS/${RES}

test_lowrie2_semi_check:
	cd output; idl test_lowrie2_semi.pro; \
		rm -f test_lowrie2_semi_results/*.eps
	-(diff  output/test_lowrie2_semi_results/error.dat \
		output/test_lowrie2_semi.ref \
		> output/test_lowrie2_semi.diff)
	ls -l output/test_lowrie2_semi.diff


### Lowrie's 3 test with AMR grid and operator split - semi-implicit ###

test_lowrie3_semi:
	@echo "test_lowrie3_semi_compile..." > output/test_lowrie3_semi.diff
	make test_lowrie3_semi_compile
	@echo "test_lowrie3_semi_rundir..." >> output/test_lowrie3_semi.diff
	make test_lowrie3_semi_rundir
	@echo "test_lowrie3_semi_run..." >> output/test_lowrie3_semi.diff
	make test_lowrie3_semi_run
	@echo "test_lowrie3_semi_check..." >> output/test_lowrie3_semi.diff
	make test_lowrie3_semi_check

test_lowrie3_semi_compile:
	cd ${DIR}; ./Config.pl -u=GrayDiffusion -e=HdEosRad -g=32,4,1,256,1
	cd ${DIR}; make BATSRUS PIDL

test_lowrie3_semi_rundir: test_rundir
	cp input/PARAM.in.lowrie3_semi ${DIR}/${RUNDIR}/PARAM.in
	cp input/initial_lowrie3.dat  ${DIR}/${RUNDIR}/

test_lowrie3_semi_run:
	make test_lowrie3_semi_run_res RES=96
	make test_lowrie3_semi_run_res RES=192
	make test_lowrie3_semi_run_res RES=384
	rm -rf output/test_lowrie3_semi_results
	mv ${DIR}/${RUNDIR}/RESULTS output/test_lowrie3_semi_results

test_lowrie3_semi_run_res:
	cd ${DIR}/${RUNDIR}; \
		perl -pi -e '$$a=${RES}/32; s/\S+(\s*nRootBlockX)/$$a$$1/' PARAM.in; \
		perl -pi -e '$$a=${RES}/32; s/\S+(\s*nRootBlockY)/$$a$$1/' PARAM.in
	cd ${DIR}/${RUNDIR}; \
		${MPIRUN} ./BATSRUS.exe > runlog; \
		PostProc.pl -M RESULTS/${RES}

test_lowrie3_semi_check:
	cd output; idl test_lowrie3_semi.pro; \
		rm -f test_lowrie3_semi_results/*.eps
	-(diff  output/test_lowrie3_semi_results/error.dat \
		output/test_lowrie3_semi.ref \
		> output/test_lowrie3_semi.diff)
	ls -l output/test_lowrie3_semi.diff

### Lowrie's 3 test with dynamic AMR and operator split - semi-implicit ###

test_lowrie3_dynamic:
	@echo "test_lowrie3_dynamic_compile..." > output/test_lowrie3_dynamic.diff
	make test_lowrie3_dynamic_compile
	@echo "test_lowrie3_dynamic_rundir..." >> output/test_lowrie3_dynamic.diff
	make test_lowrie3_dynamic_rundir
	@echo "test_lowrie3_dynamic_run..." >> output/test_lowrie3_dynamic.diff
	make test_lowrie3_dynamic_run
	@echo "test_lowrie3_dynamic_check..." >> output/test_lowrie3_dynamic.diff
	make test_lowrie3_dynamic_check

test_lowrie3_dynamic_compile:
	cd ${DIR}; ./Config.pl -u=GrayDiffusion -e=HdEosRad -g=4,4,4,2000,1
	cd ${DIR}; make BATSRUS PIDL

test_lowrie3_dynamic_rundir: test_rundir
	cp input/PARAM.in.lowrie3_dynamic ${DIR}/${RUNDIR}/PARAM.in
	cp input/initial_lowrie3.dat  ${DIR}/${RUNDIR}/

test_lowrie3_dynamic_run:
	make test_lowrie3_dynamic_run_res RES=96
	make test_lowrie3_dynamic_run_res RES=192
	make test_lowrie3_dynamic_run_res RES=384
	rm -rf output/test_lowrie3_dynamic_results
	mv ${DIR}/${RUNDIR}/RESULTS output/test_lowrie3_dynamic_results

test_lowrie3_dynamic_run_res:
	cd ${DIR}/${RUNDIR}; \
		perl -pi -e '$$a=${RES}/4; s/\S+(\s*nRootBlockX)/$$a$$1/' PARAM.in; \
		perl -pi -e '$$a=${RES}/24; s/\S+(\s*nRootBlockY)/$$a$$1/' PARAM.in
	cd ${DIR}/${RUNDIR}; \
		${MPIRUN} ./BATSRUS.exe > runlog; \
		PostProc.pl -M RESULTS/${RES}

test_lowrie3_dynamic_check:
	cd output; idl test_lowrie3_dynamic.pro; \
		rm -f test_lowrie3_dynamic_results/*.eps
	-(diff  output/test_lowrie3_dynamic_results/error.dat \
		output/test_lowrie3_dynamic.ref \
		> output/test_lowrie3_dynamic.diff)
	ls -l output/test_lowrie3_dynamic.diff

clean:
	rm -f *~ input/*~ output/*~
	cd output; rm -rf *.diff *_results

distclean: clean
