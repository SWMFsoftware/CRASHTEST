#^CFG FILE TESTING

### GRAY DIFFUSION RADIATION TESTS ###

test: 
	@rm -f output/*.diff
	-@(make test_suolson_1d)
	-@(make test_suolson_1d_amr)
	@ls -l output/*.diff

# Path to this test directory from the main directory
TESTDIR = CRASHTEST/Radiation/GrayDiffusion

# Main BATSRUS/CRASH directory
DIR = ../../..

# All tests are done in this directory:
RUNDIR = run_test

# Tests are done either parallel or serial. Default:
MPIRUN = mpirun -np 2

help:
	@echo "    test                       (run all tests with ${MPIRUN})"
	@echo "    test MPIRUN=               (run all tests serially)"
	@echo "    test MPIRUN='mpirun -np 3' (run test with mpirun -np 3)"
	@echo "    test MPIRUN='mprun -np 2'  (run test with mprun -np 2)"
	@echo "    test_suolson_1d           (run Su-Olson Marshak test in 1D)"
	@echo "    test_suolson_1d_amr       (run Su-Olson Marshak test in 1D with AMR)"


test_rundir:
	cd ${DIR}; \
		rm -rf ${RUNDIR}; \
		make rundir RUNDIR=${RUNDIR} STANDALONE=YES GMDIR=`pwd`; \
			DEFAULT_EXE=BATSRUS.exe


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
	cd ${DIR}; ./Config.pl -u=Marshak -e=HdEosRad -g=20,2,2,48,48
	cd ${DIR}; make BATSRUS PIDL

test_suolson_1d_rundir: test_rundir
	cp input/PARAM.in.suolson_1d ${DIR}/${RUNDIR}/PARAM.in

test_suolson_1d_run:
	make test_suolson_1d_run1 RES=80  SOLVER=radiation
	make test_suolson_1d_run1 RES=80  SOLVER=radcond
	make test_suolson_1d_run1 RES=160 SOLVER=radiation
	make test_suolson_1d_run1 RES=160 SOLVER=radcond
	make test_suolson_1d_run1 RES=320 SOLVER=radiation
	make test_suolson_1d_run1 RES=320 SOLVER=radcond
	make test_suolson_1d_run1 RES=960 SOLVER=radiation
	make test_suolson_1d_run1 RES=960 SOLVER=radcond
	rm -rf output/test_suolson_1d_results
	mv ${DIR}/${RUNDIR}/RESULTS output/test_suolson_1d_results

test_suolson_1d_run1:
	cd ${DIR}/${RUNDIR}; \
		perl -pi -e '$$a=${RES}/20; s/\S+(\s*nRootBlockX)/$$a$$1/' PARAM.in; \
		perl -pi -e '$$a=2.0e-14*100/${RES}; s/\S+(\s*DtFixedDim)/$$a$$1/' PARAM.in; \
		perl -pi -e 's/\S+(\s*TypeSemiImplicit)/${SOLVER}$$1/' PARAM.in
	cd ${DIR}/${RUNDIR}; \
		${MPIRUN} ./BATSRUS.exe > runlog; \
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
	cd ${DIR}; ./Config.pl -u=Marshak -e=HdEosRad -g=20,4,4,256,256
	cd ${DIR}; make BATSRUS PIDL

test_suolson_1d_amr_rundir: test_rundir
	cp input/PARAM.in.suolson_1d_amr ${DIR}/${RUNDIR}/PARAM.in

test_suolson_1d_amr_run:
	make test_suolson_1d_amr_run1 RES=80  SOLVER=radiation
	make test_suolson_1d_amr_run1 RES=80  SOLVER=radcond
	make test_suolson_1d_amr_run1 RES=160 SOLVER=radiation
	make test_suolson_1d_amr_run1 RES=160 SOLVER=radcond
	make test_suolson_1d_amr_run1 RES=320 SOLVER=radiation
	make test_suolson_1d_amr_run1 RES=320 SOLVER=radcond
	make test_suolson_1d_amr_run1 RES=960 SOLVER=radiation
	make test_suolson_1d_amr_run1 RES=960 SOLVER=radcond
	rm -rf output/test_suolson_1d_amr_results
	mv ${DIR}/${RUNDIR}/RESULTS output/test_suolson_1d_amr_results

test_suolson_1d_amr_run1:
	cd ${DIR}/${RUNDIR}; \
		perl -pi -e '$$a=${RES}/20; s/\S+(\s*nRootBlockX)/$$a$$1/' PARAM.in; \
		perl -pi -e '$$a=2.0e-14*100/${RES}; s/\S+(\s*DtFixedDim)/$$a$$1/' PARAM.in; \
		perl -pi -e 's/\S+(\s*TypeSemiImplicit)/${SOLVER}$$1/' PARAM.in
	cd ${DIR}/${RUNDIR}; \
		${MPIRUN} ./BATSRUS.exe > runlog; \
		PostProc.pl -M RESULTS/${SOLVER}_${RES}

test_suolson_1d_amr_check:
	cd output; idl test_suolson_1d_amr.pro; \
		rm -f test_suolson_1d_amr_results/*.eps
	-(diff  output/test_suolson_1d_amr_results/error.dat \
		output/test_suolson_1d_amr.ref \
		> output/test_suolson_1d_amr.diff)
	ls -l output/test_suolson_1d_amr.diff


clean:
	rm -f *~ input/*~ output/*~
	cd output; rm -rf *.diff *_results

distclean: clean
