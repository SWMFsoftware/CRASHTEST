#^CFG FILE TESTING

### GRAY DIFFUSION RADIATION TESTS ###

test: 
	@rm -f output/*.diff
	-@(make test_lightfront)
	-@(make test_infinitemedium)
	-@(make test_planckian)
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
	@echo "    test_infinitemedium        (run infinitemedium test)"
	@echo "    test_planckian             (run planckian test)"


test_rundir:
	cd ${DIR}; \
		rm -rf ${RUNDIR}; \
		make rundir RUNDIR=${RUNDIR} STANDALONE=YES GMDIR=`pwd` \
			DEFAULT_EXE=CRASH.exe


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
	cd ${DIR}; \
	 ./Config.pl -u=MultiGroup -e=HdEosRad -g=4,4,4,100,100 -setvar=nWave=3
	cd ${DIR}; make CRASH PIDL

test_lightfront_rundir: test_rundir

test_lightfront_run:
	for DIM in Z; do \
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
		${MPIRUN} ./CRASH.exe > runlog; \
		PostProc.pl -M RESULTS/${DIM}_${RES}

test_lightfront_check:
	cd output; idl test_lightfront.pro; \
		rm -f test_lightfront_results/*.eps
	-(diff  output/test_lightfront_results/error.dat \
		output/test_lightfront.ref \
		> output/test_lightfront.diff)
	ls -l output/test_lightfront.diff


### infinite medium test ###

test_infinitemedium:
	@echo "test_infinitemedium_compile..." > output/test_infinitemedium.diff
	make test_infinitemedium_compile
	@echo "test_infinitemedium_rundir..." >> output/test_infinitemedium.diff
	make test_infinitemedium_rundir
	@echo "test_infinitemedium_run..." >> output/test_infinitemedium.diff
	make test_infinitemedium_run
	@echo "test_infinitemedium_check..." >> output/test_infinitemedium.diff
	make test_infinitemedium_check

test_infinitemedium_compile:
	cd ${DIR}; ./Config.pl -u=MultiGroup -e=HdEosRad -g=2,2,2,1,1 -setvar=nWave=2
	cd ${DIR}; make CRASH PIDL

test_infinitemedium_rundir: test_rundir

test_infinitemedium_run:
	cp input/PARAM.in.infinitemedium ${DIR}/${RUNDIR}/PARAM.in; \
	for REDUCEDT in 1 2 4; do \
	 make test_infinitemedium_run1 REDUCEDT=$${REDUCEDT}; \
	done
	rm -rf output/test_infinitemedium_results
	mv ${DIR}/${RUNDIR}/RESULTS output/test_infinitemedium_results

test_infinitemedium_run1:
	cd ${DIR}/${RUNDIR}; \
		perl -pi -e '$$a=0.5559447e-4/${REDUCEDT}; s/\S+(\s*DtFixedDim)/$$a$$1/' PARAM.in
	cd ${DIR}/${RUNDIR}; \
		./CRASH.exe > runlog; \
		PostProc.pl -M RESULTS/${REDUCEDT}

test_infinitemedium_check:
	cd output; idl test_infinitemedium.pro; \
		rm -f test_infinitemedium_results/*.eps
	-(diff  output/test_infinitemedium_results/error.dat \
		output/test_infinitemedium.ref \
		> output/test_infinitemedium.diff)
	ls -l output/test_infinitemedium.diff


### planckian test ###

test_planckian:
	@echo "test_planckian_compile..." > output/test_planckian.diff
	make test_planckian_compile
	@echo "test_planckian_rundir..." >> output/test_planckian.diff
	make test_planckian_rundir
	@echo "test_planckian_run..." >> output/test_planckian.diff
	make test_planckian_run
	@echo "test_planckian_check..." >> output/test_planckian.diff
	make test_planckian_check

test_planckian_compile:
	cd ${DIR}; ./Config.pl -u=MultiGroup -e=HdEosRad -g=2,2,2,1,1 -setvar=nWave=80
	cd ${DIR}; make CRASH PIDL

test_planckian_rundir: test_rundir

test_planckian_run:
	cp input/PARAM.in.planckian ${DIR}/${RUNDIR}/PARAM.in; \
	for REDUCEDT in 2 4 8; do \
	 make test_planckian_run1 REDUCEDT=$${REDUCEDT}; \
	done
	rm -rf output/test_planckian_results
	mv ${DIR}/${RUNDIR}/RESULTS output/test_planckian_results

test_planckian_run1:
	cd ${DIR}/${RUNDIR}; \
		perl -pi -e '$$a=1.667834e-3/${REDUCEDT}; s/\S+(\s*DtFixedDim)/$$a$$1/' PARAM.in
	cd ${DIR}/${RUNDIR}; \
		./CRASH.exe > runlog; \
		PostProc.pl -M RESULTS/${REDUCEDT}

test_planckian_check:
	cd output; idl test_planckian.pro; \
		rm -f test_planckian_results/*.eps
	-(diff  output/test_planckian_results/error.dat \
		output/test_planckian.ref \
		> output/test_planckian.diff)
	ls -l output/test_planckian.diff



clean:
	rm -f *~ input/*~ output/*~
	cd output; rm -rf *.diff *_results

distclean: clean
