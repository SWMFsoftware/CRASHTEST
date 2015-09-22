#^CFG FILE TESTING

### GRAY DIFFUSION RADIATION TESTS ###

test: 
	@rm -f output/*.diff
	-@(make test_suolson_1d)
	-@(make test_suolson_1d_amr)
	-@(make test_lightfront)
	-@(make test_infinitemedium)
	@ls -l output/*.diff

# Path to this test directory from the main directory
TESTDIR = CRASHTEST/Radiation/GrayDiffusion

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
	@echo "    test_suolson_1d            (run Su-Olson Marshak test in 1D)"
	@echo "    test_suolson_1d_amr        (run Su-Olson Marshak test in 1D with AMR)"
	@echo "    test_infinitemedium        (run infinitemedium test)"
	@echo "    test_lightfront            (run lightfront test in 1D)"
	@echo "    test_diffusionfront        (run diffusion front test in 1D)"


test_rundir:
	cd ${DIR}; \
		rm -rf ${RUNDIR}; \
		make rundir RUNDIR=${RUNDIR} STANDALONE=YES GMDIR=`pwd` \
			DEFAULT_EXE=CRASH.exe


### Su-Olson Marshak test in 1D ###

test_suolson_1d:
	@echo "test_suolson_1d_compile..." > output/test_suolson_1d.diff
	make test_suolson_1d_compile
	@echo "test_suolson_1d_rundir..." >> output/test_suolson_1d.diff
	make test_suolson_1d_rundir
	@echo "test_suolson_1d_run..." >> output/test_suolson_1d.diff
	make test_suolson_1d_run
	@echo "test_suolson_1d_check..." >> output/test_suolson_1d.diff
	make test_suolson_1d_check

test_suolson_1d_compile:
	cd ${DIR}; ./Config.pl -u=Marshak -e=HdEosRad -g=10,1,1,48,1
	cd ${DIR}; make CRASH PIDL

test_suolson_1d_rundir: test_rundir
	cp input/PARAM.in.suolson_1d ${DIR}/${RUNDIR}/PARAM.in

test_suolson_1d_run:
	make test_suolson_1d_run1 RES=60  SOLVER=radiation
	make test_suolson_1d_run1 RES=60  SOLVER=radcond
	make test_suolson_1d_run1 RES=120 SOLVER=radiation
	make test_suolson_1d_run1 RES=120 SOLVER=radcond
	make test_suolson_1d_run1 RES=240 SOLVER=radiation
	make test_suolson_1d_run1 RES=240 SOLVER=radcond
	make test_suolson_1d_run1 RES=960 SOLVER=radiation
	make test_suolson_1d_run1 RES=960 SOLVER=radcond
	rm -rf output/test_suolson_1d_results
	mv ${DIR}/${RUNDIR}/RESULTS output/test_suolson_1d_results

test_suolson_1d_run1:
	cd ${DIR}/${RUNDIR}; \
		perl -pi -e '$$a=${RES}/10; s/\S+(\s*nRootBlockX)/$$a$$1/' PARAM.in; \
		perl -pi -e '$$a=5.0e-5*60/${RES}; s/\S+(\s*DtFixedDim)/$$a$$1/' PARAM.in; \
		perl -pi -e 's/\S+(\s*TypeSemiImplicit)/${SOLVER}$$1/' PARAM.in
	cd ${DIR}/${RUNDIR}; \
		${MPIRUN} ./CRASH.exe > runlog; \
		PostProc.pl -M RESULTS/${SOLVER}_${RES}

test_suolson_1d_check:
	cd output; idl test_suolson_1d.pro; \
		rm -f test_suolson_1d_results/*.eps
	-(diff  output/test_suolson_1d_results/error.dat \
		output/test_suolson_1d.ref \
		> output/test_suolson_1d.diff)
	ls -l output/test_suolson_1d.diff

### Su-Olson Marshak test in 1D with AMR###

test_suolson_1d_amr:
	@echo "test_suolson_1d_amr_compile..." > output/test_suolson_1d_amr.diff
	make test_suolson_1d_amr_compile
	@echo "test_suolson_1d_amr_rundir..." >> output/test_suolson_1d_amr.diff
	make test_suolson_1d_amr_rundir
	@echo "test_suolson_1d_amr_run..." >> output/test_suolson_1d_amr.diff
	make test_suolson_1d_amr_run
	@echo "test_suolson_1d_amr_check..." >> output/test_suolson_1d_amr.diff
	make test_suolson_1d_amr_check

test_suolson_1d_amr_compile:
	cd ${DIR}; ./Config.pl -u=Marshak -e=HdEosRad -g=10,1,1,256,1
	cd ${DIR}; make CRASH PIDL

test_suolson_1d_amr_rundir: test_rundir
	cp input/PARAM.in.suolson_1d_amr ${DIR}/${RUNDIR}/PARAM.in

test_suolson_1d_amr_run:
	make test_suolson_1d_amr_run1 RES=60  SOLVER=radiation
	make test_suolson_1d_amr_run1 RES=60  SOLVER=radcond
	make test_suolson_1d_amr_run1 RES=120 SOLVER=radiation
	make test_suolson_1d_amr_run1 RES=120 SOLVER=radcond
	make test_suolson_1d_amr_run1 RES=240 SOLVER=radiation
	make test_suolson_1d_amr_run1 RES=240 SOLVER=radcond
	make test_suolson_1d_amr_run1 RES=960 SOLVER=radiation
	make test_suolson_1d_amr_run1 RES=960 SOLVER=radcond
	rm -rf output/test_suolson_1d_amr_results
	mv ${DIR}/${RUNDIR}/RESULTS output/test_suolson_1d_amr_results

test_suolson_1d_amr_run1:
	cd ${DIR}/${RUNDIR}; \
		perl -pi -e '$$a=${RES}/10; s/\S+(\s*nRootBlockX)/$$a$$1/' PARAM.in; \
		perl -pi -e '$$a=5.0e-5*60/${RES}; s/\S+(\s*DtFixedDim)/$$a$$1/' PARAM.in; \
		perl -pi -e 's/\S+(\s*TypeSemiImplicit)/${SOLVER}$$1/' PARAM.in
	cd ${DIR}/${RUNDIR}; \
		${MPIRUN} ./CRASH.exe > runlog; \
		PostProc.pl -M RESULTS/${SOLVER}_${RES}

test_suolson_1d_amr_check:
	cd output; idl test_suolson_1d_amr.pro; \
		rm -f test_suolson_1d_amr_results/*.eps
	-(diff  output/test_suolson_1d_amr_results/error.dat \
		output/test_suolson_1d_amr.ref \
		> output/test_suolson_1d_amr.diff)
	ls -l output/test_suolson_1d_amr.diff


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
	cd ${DIR}; ./Config.pl -u=MultiGroup -e=HdEosRad -g=4,4,4,1000,1
	cd ${DIR}; make CRASH PIDL

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
		${MPIRUN} ./CRASH.exe > runlog; \
		PostProc.pl -M RESULTS/${DIM}_${RES}

test_lightfront_check:
	cd output; idl test_lightfront.pro; \
		rm -f test_lightfront_results/*.eps
	-(${SCRIPTDIR}/DiffNum.pl -a=1e-9 \
		output/test_lightfront_results/error.dat \
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
	cd ${DIR}; ./Config.pl -u=MultiGroup -e=HdEosRad -f -g=2,2,2,1,1
	cd ${DIR}; make CRASH PIDL

test_infinitemedium_rundir: test_rundir

test_infinitemedium_run:
	cp input/PARAM.in.infinitemedium ${DIR}/${RUNDIR}/PARAM.in; \
	for SOLVER in radiation radcond; do \
	 for REDUCEDT in 2 4 8; do \
	  make test_infinitemedium_run1 REDUCEDT=$${REDUCEDT} SOLVER=$${SOLVER}; \
	 done \
	done
	rm -rf output/test_infinitemedium_results
	mv ${DIR}/${RUNDIR}/RESULTS output/test_infinitemedium_results

test_infinitemedium_run1:
	cd ${DIR}/${RUNDIR}; \
		perl -pi -e '$$a=1.667834e-3/${REDUCEDT}; s/\S+(\s*DtFixedDim)/$$a$$1/' PARAM.in; \
		perl -pi -e 's/\S+(\s*TypeSemiImplicit)/${SOLVER}$$1/' PARAM.in
	cd ${DIR}/${RUNDIR}; \
		./CRASH.exe > runlog; \
		PostProc.pl -M RESULTS/${SOLVER}_${REDUCEDT}

test_infinitemedium_check:
	cd output; idl test_infinitemedium.pro; \
		rm -f test_infinitemedium_results/*.eps
	-(diff  output/test_infinitemedium_results/error.dat \
		output/test_infinitemedium.ref \
		> output/test_infinitemedium.diff)
	ls -l output/test_infinitemedium.diff


### diffusionfront test in 1D ###

test_diffusionfront:
	@echo "test_diffusionfront_compile..." > output/test_diffusionfront.diff
	make test_diffusionfront_compile
	@echo "test_diffusionfront_rundir..." >> output/test_diffusionfront.diff
	make test_diffusionfront_rundir
	@echo "test_diffusionfront_run..." >> output/test_diffusionfront.diff
	make test_diffusionfront_run
	@echo "test_diffusionfront_check..." >> output/test_diffusionfront.diff
	make test_diffusionfront_check

test_diffusionfront_compile:
	cd ${DIR}; ./Config.pl -u=MultiGroup -e=HdEosRad -g=10,1,1,1000,1
	cd ${DIR}; make CRASH PIDL

test_diffusionfront_rundir: test_rundir
	cp input/PARAM.in.diffusionfront ${DIR}/${RUNDIR}/PARAM.in

test_diffusionfront_run:
	cd ${DIR}/${RUNDIR}; \
		${MPIRUN} ./CRASH.exe > runlog; \
		PostProc.pl -M RESULTS/test_diffusionfront
	rm -rf output/test_diffusionfront_results
	mv ${DIR}/${RUNDIR}/RESULTS output/test_diffusionfront_results

test_diffusionfront_check:
	cd output; idl test_diffusionfront.pro; \
		rm -f test_diffusionfront_results/*.eps


clean:
	rm -f *~ input/*~ output/*~
	cd output; rm -rf *.diff *_results

distclean: clean
