#^CFG FILE TESTING

### Radiography tests for multi-material (rad)hydro ###

test: 
	@rm -f output/*.diff
	-@(make test_sphere_3d)
	-@(make test_sphere_amr)
	-@(make test_tube_3d)
	-@(make test_sphere_rz)
	-@(make test_tube_rz)
	@ls -l output/*.diff

# Path to this test directory from the main directory
TESTDIR = CRASHTEST/Radiography

# Main BATSRUS/CRASH directory
DIR = ../..

# All tests are done in this directory:
RUNDIR = run_test

# Tests are done either parallel or serial. Default:
MPIRUN = mpirun -np 2

help:
	@echo "    test                       (run all tests with ${MPIRUN})"
	@echo "    test MPIRUN=               (run all tests serially)"
	@echo "    test MPIRUN='mpirun -np 3' (run test with mpirun -np 3)"
	@echo "    test MPIRUN='mprun -np 2'  (run test with mprun -np 2)"
	@echo "    test_sphere_3d             (run sphere LOS test in 3D)"
	@echo "    test_sphere_rz             (run sphere test in RZ coords)"
	@echo "    test_sphere_amr            (run sphere LOS test with AMR)"
	@echo "    test_tube_3d               (run tube LOS test in 3D)"

test_rundir:
	cd ${DIR}; \
		rm -rf ${RUNDIR}; \
		make rundir RUNDIR=${RUNDIR} STANDALONE=YES GMDIR=`pwd` \
			DEFAULT_EXE=CRASH.exe


clean:
	rm -f *~ input/*~ output/*~
	cd output; rm -rf *.diff *_results

distclean: clean

### Radiography test integrating a sphere on a uniform 3D grid ###

test_sphere_3d:
	@echo "test_sphere_3d_compile..." > output/test_sphere_3d.diff
	make test_sphere_3d_compile
	@echo "test_sphere_3d_rundir..." >> output/test_sphere_3d.diff
	make test_sphere_3d_rundir
	@echo "test_sphere_3d_run..." >> output/test_sphere_3d.diff
	make test_sphere_3d_run
	@echo "test_sphere_3d_check..." >> output/test_sphere_3d.diff
	make test_sphere_3d_check

test_sphere_3d_compile:
	cd ${DIR}; ./Config.pl  -e=HdRadCrash -u=Crash -g=10,10,10,600,1
	cd ${DIR}; make CRASH PIDL

test_sphere_3d_rundir: test_rundir
	cp input/PARAM.in.sphere_3d ${DIR}/${RUNDIR}/PARAM.in

test_sphere_3d_run:
	make test_sphere_3d_run_res RES=20
	make test_sphere_3d_run_res RES=40
	make test_sphere_3d_run_res RES=80
	rm -rf output/test_sphere_3d_results
	mv ${DIR}/${RUNDIR}/RESULTS output/test_sphere_3d_results

test_sphere_3d_run_res:
	cd ${DIR}/${RUNDIR}; \
	perl -pi -e '$$a=${RES}/10; s/\S+(\s*nRootBlock)/$$a$$1/' PARAM.in
	cd ${DIR}/${RUNDIR}; \
		${MPIRUN} ./CRASH.exe > runlog; \
		PostProc.pl RESULTS/${RES}

test_sphere_3d_check:
	cd output; idl test_sphere_3d.pro; \
		rm -f test_sphere_3d_results/*.eps
	-(diff  output/test_sphere_3d_results/error.dat \
		output/test_sphere_3d.ref \
		> output/test_sphere_3d.diff)
	ls -l output/test_sphere_3d.diff

### Radiography test integrating a sphere on a uniform RZ grid ###

test_sphere_rz:
	@echo "test_sphere_rz_compile..." > output/test_sphere_rz.diff
	make test_sphere_rz_compile
	@echo "test_sphere_rz_rundir..." >> output/test_sphere_rz.diff
	make test_sphere_rz_rundir
	@echo "test_sphere_rz_run..." >> output/test_sphere_rz.diff
	make test_sphere_rz_run
	@echo "test_sphere_rz_check..." >> output/test_sphere_rz.diff
	make test_sphere_rz_check

test_sphere_rz_compile:
	cd ${DIR}; ./Config.pl  -e=HdRadCrash -u=Crash -g=10,10,2,600,1
	cd ${DIR}; make CRASH PIDL

test_sphere_rz_rundir: test_rundir
	cp input/PARAM.in.sphere_rz ${DIR}/${RUNDIR}/PARAM.in

test_sphere_rz_run:
	make test_sphere_rz_run_res RES=20
	make test_sphere_rz_run_res RES=40
	make test_sphere_rz_run_res RES=80
	rm -rf output/test_sphere_rz_results
	mv ${DIR}/${RUNDIR}/RESULTS output/test_sphere_rz_results

test_sphere_rz_run_res:
	cd ${DIR}/${RUNDIR}; \
	perl -pi -e '$$a=${RES}/10; s/\S+(\s*nRootBlock[XY])/$$a$$1/' PARAM.in
	cd ${DIR}/${RUNDIR}; \
		${MPIRUN} ./CRASH.exe > runlog; \
		PostProc.pl RESULTS/${RES}

test_sphere_rz_check:
	cd output; idl test_sphere_rz.pro; \
		rm -f test_sphere_rz_results/*.eps
	-(diff  output/test_sphere_rz_results/error.dat \
		output/test_sphere_rz.ref \
		> output/test_sphere_rz.diff)
	ls -l output/test_sphere_rz.diff

### Radiography test integrating a sphere on a uniform 3D grid ###

test_sphere_amr:
	@echo "test_sphere_amr_compile..." > output/test_sphere_amr.diff
	make test_sphere_amr_compile
	@echo "test_sphere_amr_rundir..." >> output/test_sphere_amr.diff
	make test_sphere_amr_rundir
	@echo "test_sphere_amr_run..." >> output/test_sphere_amr.diff
	make test_sphere_amr_run
	@echo "test_sphere_amr_check..." >> output/test_sphere_amr.diff
	make test_sphere_amr_check

test_sphere_amr_compile:
	cd ${DIR}; ./Config.pl  -e=HdRadCrash -u=Crash -g=10,10,10,600,1
	cd ${DIR}; make CRASH PIDL

test_sphere_amr_rundir: test_rundir
	cp input/PARAM.in.sphere_amr ${DIR}/${RUNDIR}/PARAM.in

test_sphere_amr_run:
	make test_sphere_amr_run_res RES=20
	make test_sphere_amr_run_res RES=40
	make test_sphere_amr_run_res RES=80
	rm -rf output/test_sphere_amr_results
	mv ${DIR}/${RUNDIR}/RESULTS output/test_sphere_amr_results

test_sphere_amr_run_res:
	cd ${DIR}/${RUNDIR}; \
	perl -pi -e '$$a=${RES}/10; s/\S+(\s*nRootBlock)/$$a$$1/' PARAM.in
	cd ${DIR}/${RUNDIR}; \
		${MPIRUN} ./CRASH.exe > runlog; \
		PostProc.pl RESULTS/${RES}

test_sphere_amr_check:
	cd output; idl test_sphere_amr.pro; \
		rm -f test_sphere_amr_results/*.eps
	-(diff  output/test_sphere_amr_results/error.dat \
		output/test_sphere_amr.ref \
		> output/test_sphere_amr.diff)
	ls -l output/test_sphere_amr.diff

### Radiography test integrating a cylindrical shock tube on a uniform 3D grid

test_tube_3d:
	@echo "test_tube_3d_compile..." > output/test_tube_3d.diff
	make test_tube_3d_compile
	@echo "test_tube_3d_rundir..." >> output/test_tube_3d.diff
	make test_tube_3d_rundir
	@echo "test_tube_3d_run..." >> output/test_tube_3d.diff
	make test_tube_3d_run
	@echo "test_tube_3d_check..." >> output/test_tube_3d.diff
	make test_tube_3d_check

test_tube_3d_compile:
	cd ${DIR}; ./Config.pl  -e=HdRadCrash -u=Crash -g=10,10,10,600,1
	cd ${DIR}; make CRASH PIDL

test_tube_3d_rundir: test_rundir
	cp input/PARAM.in.tube_3d ${DIR}/${RUNDIR}/PARAM.in

test_tube_3d_run:
	make test_tube_3d_run1
	make test_tube_3d_run1 ON=MIXED
	rm -rf output/test_tube_3d_results
	mv ${DIR}/${RUNDIR}/RESULTS output/test_tube_3d_results

test_tube_3d_run1:
	cd ${DIR}/${RUNDIR}; \
	perl -pi -e '$$a= "${ON}"; s/^#(MIXED)/$$1/; s/^($$a)/#$$1/ if $$a' \
		PARAM.in
	cd ${DIR}/${RUNDIR}; \
		${MPIRUN} ./CRASH.exe > runlog; \
		PostProc.pl RESULTS/tube_${ON}

test_tube_3d_check:
	cd output; idl test_tube_3d.pro; \
		rm -f test_tube_3d_results/*.eps
	ls -l output/test_tube_3d.diff

### Radiography test integrating a cylindrical shock tube on a uniform 3D grid

test_tube_rz:
	@echo "test_tube_rz_compile..." > output/test_tube_rz.diff
	make test_tube_rz_compile
	@echo "test_tube_rz_rundir..." >> output/test_tube_rz.diff
	make test_tube_rz_rundir
	@echo "test_tube_rz_run..." >> output/test_tube_rz.diff
	make test_tube_rz_run
	@echo "test_tube_rz_check..." >> output/test_tube_rz.diff
	make test_tube_rz_check

test_tube_rz_compile:
	cd ${DIR}; ./Config.pl  -e=HdRadCrash -u=Crash -g=10,10,2,600,1
	cd ${DIR}; make CRASH PIDL

test_tube_rz_rundir: test_rundir
	cp input/PARAM.in.tube_rz ${DIR}/${RUNDIR}/PARAM.in

test_tube_rz_run:
	cd ${DIR}/${RUNDIR}; \
		${MPIRUN} ./CRASH.exe > runlog; \
		PostProc.pl RESULTS/tube_rz
	rm -rf output/test_tube_rz_results
	mv ${DIR}/${RUNDIR}/RESULTS output/test_tube_rz_results

test_tube_rz_check:
	cd output; idl test_tube_rz.pro; \
		rm -f test_tube_rz_results/*.eps
	ls -l output/test_tube_rz.diff
