#^CFG FILE TESTING

### Laser package test ###

test: 
	@rm -f output/*.diff
	-@(make test_rz_ray)
	-@(make test_rz_ray_amr)
	-@(make test_3d_ray)
	-@(make test_3d_ray_amr)
	@ls -l output/*.diff

# Path to this test directory from the main directory
TESTDIR = CRASHTEST/Laser

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
	@echo "    test_rz_ray                (run single ray test of Kruer)"
	@echo "    test_rz_ray_amr            (run single ray test of Kruer)"
	@echo "    test_3d_ray                (run single ray test of Kruer)"
	@echo "    test_3d_ray_amr            (run single ray test of Kruer)"

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

test_rz_ray:
	@echo "test_rz_ray_compile..." > output/test_rz_ray.diff
	make test_rz_ray_compile
	@echo "test_rz_ray_rundir..." >> output/test_rz_ray.diff
	make test_rz_ray_rundir
	@echo "test_rz_ray_run..." >> output/test_rz_ray.diff
	make test_rz_ray_run
	@echo "test_rz_ray_check..." >> output/test_rz_ray.diff
	make test_rz_ray_check

test_rz_ray_compile:
	cd ${DIR}; ./Config.pl  -e=Crash -u=Crash -g=4,4,1,3000,1 \
		-nMaterial=5 -nWave=30
	cd ${DIR}; make CRASH PIDL

test_rz_ray_rundir: test_rundir
	cp input/PARAM.in.rz_ray ${DIR}/${RUNDIR}/PARAM.in
	cd ${DIR}/${RUNDIR}; ln -s ../dataCRASH/LookupTables Tables

test_rz_ray_run:
	for RES in 1 2 4 8; do \
	  make test_rz_ray_run_res RES=$${RES}; \
	done
	rm -rf output/test_rz_ray_results
	mv ${DIR}/${RUNDIR}/RESULTS output/test_rz_ray_results

test_rz_ray_run_res:
	cd ${DIR}/${RUNDIR}; \
	perl -pi -e '$$a=68*${RES}; s/\S+(\s*nRootBlockX)/$$a$$1/' PARAM.in
	cd ${DIR}/${RUNDIR}; \
		${MPIRUN} ./CRASH.exe > runlog; \
		PostProc.pl RESULTS/${RES}

test_rz_ray_check:
	cd output; singleray.pl test_rz_ray
	cd output; idl test_rz_ray.pro; \
		rm -f test_rz_ray_results/*.eps
	-(${SCRIPTDIR}/DiffNum.pl -r=1e-11 \
		output/test_rz_ray_results/error.dat \
		output/test_rz_ray.ref \
		> output/test_rz_ray.diff)
	ls -l output/test_rz_ray.diff

### single ray test: The Physics of Laser Interactions by W.L. Kruer, p. 51 ###

test_rz_ray_amr:
	@echo "test_rz_ray_amr_compile..." > output/test_rz_ray_amr.diff
	make test_rz_ray_amr_compile
	@echo "test_rz_ray_amr_rundir..." >> output/test_rz_ray_amr.diff
	make test_rz_ray_amr_rundir
	@echo "test_rz_ray_amr_run..." >> output/test_rz_ray_amr.diff
	make test_rz_ray_amr_run
	@echo "test_rz_ray_amr_check..." >> output/test_rz_ray_amr.diff
	make test_rz_ray_amr_check

test_rz_ray_amr_compile:
	cd ${DIR}; ./Config.pl  -e=Crash -u=Crash -g=4,4,1,10000,1 \
		-nMaterial=5 -nWave=30
	cd ${DIR}; make CRASH PIDL

test_rz_ray_amr_rundir: test_rundir
	cp input/PARAM.in.rz_ray_amr ${DIR}/${RUNDIR}/PARAM.in
	cd ${DIR}/${RUNDIR}; ln -s ../dataCRASH/LookupTables Tables

test_rz_ray_amr_run:
	for RES in 1 2 4 8; do \
	  make test_rz_ray_amr_run_res RES=$${RES}; \
	done
	rm -rf output/test_rz_ray_amr_results
	mv ${DIR}/${RUNDIR}/RESULTS output/test_rz_ray_amr_results

test_rz_ray_amr_run_res:
	cd ${DIR}/${RUNDIR}; \
	perl -pi -e '$$a=68*${RES}; s/\S+(\s*nRootBlockX)/$$a$$1/' PARAM.in
	cd ${DIR}/${RUNDIR}; \
		${MPIRUN} ./CRASH.exe > runlog; \
		PostProc.pl RESULTS/${RES}

test_rz_ray_amr_check:
	cd output; singleray.pl test_rz_ray_amr
	cd output; idl test_rz_ray_amr.pro; \
		rm -f test_rz_ray_amr_results/*.eps
	-(${SCRIPTDIR}/DiffNum.pl \
		output/test_rz_ray_amr_results/error.dat \
		output/test_rz_ray_amr.ref \
		> output/test_rz_ray_amr.diff)
	ls -l output/test_rz_ray_amr.diff

### single ray test: The Physics of Laser Interactions by W.L. Kruer, p. 51 ###

test_3d_ray:
	@echo "test_3d_ray_compile..." > output/test_3d_ray.diff
	make test_3d_ray_compile
	@echo "test_3d_ray_rundir..." >> output/test_3d_ray.diff
	make test_3d_ray_rundir
	@echo "test_3d_ray_run..." >> output/test_3d_ray.diff
	make test_3d_ray_run
	@echo "test_3d_ray_check..." >> output/test_3d_ray.diff
	make test_3d_ray_check

test_3d_ray_compile:
	cd ${DIR}; ./Config.pl  -e=Crash -u=Crash -g=4,4,1,3000,1 \
		-nMaterial=5 -nWave=30
	cd ${DIR}; make CRASH PIDL

test_3d_ray_rundir: test_rundir
	cp input/PARAM.in.3d_ray ${DIR}/${RUNDIR}/PARAM.in
	cd ${DIR}/${RUNDIR}; ln -s ../dataCRASH/LookupTables Tables

test_3d_ray_run:
	for RES in 1 2 4 8; do \
	  make test_3d_ray_run_res RES=$${RES}; \
	done
	rm -rf output/test_3d_ray_results
	mv ${DIR}/${RUNDIR}/RESULTS output/test_3d_ray_results

test_3d_ray_run_res:
	cd ${DIR}/${RUNDIR}; \
	perl -pi -e '$$a=68*${RES}; s/\S+(\s*nRootBlockX)/$$a$$1/' PARAM.in; \
	perl -pi -e '$$a=10*${RES}; s/\S+(\s*nRootBlockY)/$$a$$1/' PARAM.in
	cd ${DIR}/${RUNDIR}; \
		${MPIRUN} ./CRASH.exe > runlog; \
		PostProc.pl RESULTS/${RES}

test_3d_ray_check:
	cd output; singleray.pl test_3d_ray
	cd output; idl test_3d_ray.pro; \
		rm -f test_3d_ray_results/*.eps
	-(${SCRIPTDIR}/DiffNum.pl -r=1e-12 \
		output/test_3d_ray_results/error.dat \
		output/test_3d_ray.ref \
		> output/test_3d_ray.diff)
	ls -l output/test_3d_ray.diff

### single ray test: The Physics of Laser Interactions by W.L. Kruer, p. 51 ###

test_3d_ray_amr:
	@echo "test_3d_ray_amr_compile..." > output/test_3d_ray_amr.diff
	make test_3d_ray_amr_compile
	@echo "test_3d_ray_amr_rundir..." >> output/test_3d_ray_amr.diff
	make test_3d_ray_amr_rundir
	@echo "test_3d_ray_amr_run..." >> output/test_3d_ray_amr.diff
	make test_3d_ray_amr_run
	@echo "test_3d_ray_amr_check..." >> output/test_3d_ray_amr.diff
	make test_3d_ray_amr_check

test_3d_ray_amr_compile:
	cd ${DIR}; ./Config.pl  -e=Crash -u=Crash -g=4,4,1,10000,1 \
		-nMaterial=5 -nWave=30
	cd ${DIR}; make CRASH PIDL

test_3d_ray_amr_rundir: test_rundir
	cp input/PARAM.in.3d_ray_amr ${DIR}/${RUNDIR}/PARAM.in
	cd ${DIR}/${RUNDIR}; ln -s ../dataCRASH/LookupTables Tables

test_3d_ray_amr_run:
	for RES in 1 2 4 8; do \
	  make test_3d_ray_amr_run_res RES=$${RES}; \
	done
	rm -rf output/test_3d_ray_amr_results
	mv ${DIR}/${RUNDIR}/RESULTS output/test_3d_ray_amr_results

test_3d_ray_amr_run_res:
	cd ${DIR}/${RUNDIR}; \
	perl -pi -e '$$a=68*${RES}; s/\S+(\s*nRootBlockX)/$$a$$1/' PARAM.in; \
	perl -pi -e '$$a=10*${RES}; s/\S+(\s*nRootBlockY)/$$a$$1/' PARAM.in
	cd ${DIR}/${RUNDIR}; \
		${MPIRUN} ./CRASH.exe > runlog; \
		PostProc.pl RESULTS/${RES}

test_3d_ray_amr_check:
	cd output; singleray.pl test_3d_ray_amr
	cd output; idl test_3d_ray_amr.pro; \
		rm -f test_3d_ray_amr_results/*.eps
	-(${SCRIPTDIR}/DiffNum.pl -r=1e-11 \
		output/test_3d_ray_amr_results/error.dat \
		output/test_3d_ray_amr.ref \
		> output/test_3d_ray_amr.diff)
	ls -l output/test_3d_ray_amr.diff

