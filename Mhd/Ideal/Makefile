#^CFG FILE TESTING

### BIERMANN BATTERY TESTS ###

test: 
	@rm -f output/*.diff
	-@(make test_alfven_1d)
	-@(make test_alfven_2d)
	-@(make test_alfven_amr)
	@ls -l output/*.diff

# Path to this test directory from the main directory
TESTDIR = CRASHTEST/Mhd/Ideal

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
	@echo "    test_alfven_1d             (run Alfven test in 1D)"
	@echo "    test_alfven_2d             (run Alfven test in 2D)"
	@echo "    test_alfven_amr            (run Alfven test with AMR)"

test_rundir:
	cd ${DIR}; \
		rm -rf ${RUNDIR}; \
		make rundir RUNDIR=${RUNDIR} STANDALONE=YES GMDIR=`pwd`; \
			DEFAULT_EXE=BATSRUS.exe

clean:
	rm -f *~ input/*~ output/*~
	cd output; rm -rf *.diff *.err *.eps *_results

distclean: clean


### Alfven wave test on 1D uniform grid ###

test_alfven_1d:
	@echo "test_alfven_1d_compile..." > output/test_alfven_1d.diff
	make test_alfven_1d_compile
	@echo "test_alfven_1d_rundir..." >> output/test_alfven_1d.diff
	make test_alfven_1d_rundir
	@echo "test_alfven_1d_run..." >> output/test_alfven_1d.diff
	make test_alfven_1d_run
	@echo "test_alfven_1d_check..." >> output/test_alfven_1d.diff
	make test_alfven_1d_check

test_alfven_1d_compile:
	cd ${DIR}; ./Config.pl -e=Mhd -u=Waves -g=6,1,1,1000,1 -ng=3
	cd ${DIR}; make BATSRUS PIDL
	cd ${DIR}; ./Config.pl -ng=2

test_alfven_1d_rundir: test_rundir
	cp input/PARAM.in.alfven_1d ${DIR}/${RUNDIR}/PARAM.in

test_alfven_1d_run:
	for ORDER in 2 4 5; do \
	  for RES in 24 48 96; do \
	    make test_alfven_1d_run1 ORDER=$${ORDER} RES=$${RES}; \
	  done \
	done
	rm -rf output/test_alfven_1d_results
	mv ${DIR}/${RUNDIR}/RESULTS output/test_alfven_1d_results

test_alfven_1d_run1:
	cd ${DIR}/${RUNDIR}; \
	perl -pi -e 's/^\#?(SCHEME|RK)/$$1/; s/^((SCHEME|RK)\s+${ORDER})/\#$$1/;\
		     $$a=${RES}/6; s/\S+(\s*nRootBlockX)/$$a$$1/' PARAM.in
	cd ${DIR}/${RUNDIR}; \
		${MPIRUN} ./BATSRUS.exe > runlog; \
		PostProc.pl -M RESULTS/ORDER${ORDER}_${RES}

test_alfven_1d_check:
	cd output; idl test_alfven_1d.pro; \
		rm -f test_alfven_1d_results/*.eps
	-(${SCRIPTDIR}/DiffNum.pl \
		output/test_alfven_1d_results/error.dat \
		output/test_alfven_1d.ref \
		> output/test_alfven_1d.diff)
	ls -l output/test_alfven_1d.diff

### Alfven wave test on 2D uniform grid ###

test_alfven_2d:
	@echo "test_alfven_2d_compile..." > output/test_alfven_2d.diff
	make test_alfven_2d_compile
	@echo "test_alfven_2d_rundir..." >> output/test_alfven_2d.diff
	make test_alfven_2d_rundir
	@echo "test_alfven_2d_run..." >> output/test_alfven_2d.diff
	make test_alfven_2d_run
	@echo "test_alfven_2d_check..." >> output/test_alfven_2d.diff
	make test_alfven_2d_check

test_alfven_2d_compile:
	cd ${DIR}; ./Config.pl -e=Mhd -u=Waves -g=6,6,1,1000,1 -ng=3
	cd ${DIR}; make BATSRUS PIDL
	cd ${DIR}; ./Config.pl -ng=2

test_alfven_2d_rundir: test_rundir
	cp input/PARAM.in.alfven_2d ${DIR}/${RUNDIR}/PARAM.in

test_alfven_2d_run:
	for ORDER in 2 4 5; do \
	  for RES in 24 48 96; do \
	    make test_alfven_2d_run1 ORDER=$${ORDER} RES=$${RES}; \
	  done \
	done
	rm -rf output/test_alfven_2d_results
	mv ${DIR}/${RUNDIR}/RESULTS output/test_alfven_2d_results

test_alfven_2d_run1:
	cd ${DIR}/${RUNDIR}; \
	perl -pi -e 's/^\#?(SCHEME|RK)/$$1/; s/^((SCHEME|RK)\s+${ORDER})/\#$$1/;\
		     $$a=${RES}/6; s/\S+(\s*nRootBlock[XY])/$$a$$1/' PARAM.in
	cd ${DIR}/${RUNDIR}; \
		${MPIRUN} ./BATSRUS.exe > runlog; \
		PostProc.pl -M RESULTS/ORDER${ORDER}_${RES}

test_alfven_2d_check:
	cd output; idl test_alfven_2d.pro; \
		rm -f test_alfven_2d_results/*.eps
	-(${SCRIPTDIR}/DiffNum.pl \
		output/test_alfven_2d_results/error.dat \
		output/test_alfven_2d.ref \
		> output/test_alfven_2d.diff)
	ls -l output/test_alfven_2d.diff

### Alfven wave test on AMR uniform grid ###

test_alfven_amr:
	@echo "test_alfven_amr_compile..." > output/test_alfven_amr.diff
	make test_alfven_amr_compile
	@echo "test_alfven_amr_rundir..." >> output/test_alfven_amr.diff
	make test_alfven_amr_rundir
	@echo "test_alfven_amr_run..." >> output/test_alfven_amr.diff
	make test_alfven_amr_run
	@echo "test_alfven_amr_check..." >> output/test_alfven_amr.diff
	make test_alfven_amr_check

test_alfven_amr_compile:
	cd ${DIR}; ./Config.pl -e=Mhd -u=Waves -g=6,6,1,1000,1 -ng=3
	cd ${DIR}; make BATSRUS PIDL
	cd ${DIR}; ./Config.pl -ng=2

test_alfven_amr_rundir: test_rundir
	cp input/PARAM.in.alfven_amr ${DIR}/${RUNDIR}/PARAM.in

test_alfven_amr_run:
	for ORDER in 2 4 5; do \
	  for RES in 12 24 48; do \
	    make test_alfven_amr_run1 ORDER=$${ORDER} RES=$${RES}; \
	  done \
	done
	rm -rf output/test_alfven_amr_results
	mv ${DIR}/${RUNDIR}/RESULTS output/test_alfven_amr_results

test_alfven_amr_run1:
	cd ${DIR}/${RUNDIR}; \
	perl -pi -e 's/^\#?(SCHEME|RK)/$$1/; \
		     s/^((SCHEME|RK)\s+${ORDER})/\#$$1/; \
		     $$a=${RES}/6; s/\S+(\s*nRootBlock[XY])/$$a$$1/' PARAM.in
	cd ${DIR}/${RUNDIR}; \
		${MPIRUN} ./BATSRUS.exe > runlog; \
		PostProc.pl -M RESULTS/ORDER${ORDER}_${RES}

test_alfven_amr_check:
	cd output; idl test_alfven_amr.pro; \
		rm -f test_alfven_amr_results/*.eps
	-(${SCRIPTDIR}/DiffNum.pl \
		output/test_alfven_amr_results/error.dat \
		output/test_alfven_amr.ref \
		> output/test_alfven_amr.diff)
	ls -l output/test_alfven_amr.diff

