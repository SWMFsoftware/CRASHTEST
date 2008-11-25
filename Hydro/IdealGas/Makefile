#^CFG FILE TESTING

### RADHYDRO TESTS FOR IDEAL GAS WITH GREY DIFFUSION ###

test: 
	@rm -f *.diff
	-@(make test_shu_osher_amr)
	@ls -l *.diff

# Path to this test directory from the main directory
TESTDIR = CRASHTEST/Hydro/IdealGas

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
	@echo "    test_shu_osher_1d          (run Shu-Osher test in 1D)"
	@echo "    test_shu_osher_2d          (run Shu-Osher test in 2D)"
	@echo "    test_shu_osher_amr         (run Shu-Osher test with 2D AMR)"

test_rundir:
	cd ${DIR}; \
		rm -rf ${RUNDIR}; \
		make rundir RUNDIR=${RUNDIR} STANDALONE=YES GMDIR=`pwd`; \
			DEFAULT_EXE=BATSRUS.exe

clean:
	rm -f *~ input/*~ output/*~
	cd output; rm -rf *.diff *.err *.eps *_results

distclean: clean

### Shu-Osher test on 1D grid ###

test_shu_osher_1d:
	@echo "test_shu_osher_1d_compile..." > output/test_shu_osher_1d.diff
	make test_shu_osher_1d_compile
	@echo "test_shu_osher_1d_rundir..." >> output/test_shu_osher_1d.diff
	make test_shu_osher_1d_rundir
	@echo "test_shu_osher_1d_run..." >> output/test_shu_osher_1d.diff
	make test_shu_osher_1d_run
	@echo "test_shu_osher_1d_check..." >> output/test_shu_osher_1d.diff
	make test_shu_osher_1d_check

test_shu_osher_1d_compile:
	cd ${DIR}; ./Config.pl -e=Hd -u=Waves -g=100,2,2,100,1
	cd ${DIR}; make BATSRUS PIDL

test_shu_osher_1d_rundir: test_rundir
	cp input/PARAM.in.shu_osher_1d ${DIR}/${RUNDIR}/PARAM.in

test_shu_osher_1d_run:
	make test_shu_osher_1d_run1 RES=200 SOLVER=Rusanov
	make test_shu_osher_1d_run1 RES=200 SOLVER=Linde
	make test_shu_osher_1d_run1 RES=200 SOLVER=Godunov
	make test_shu_osher_1d_run1 RES=400 SOLVER=Rusanov
	make test_shu_osher_1d_run1 RES=400 SOLVER=Linde
	make test_shu_osher_1d_run1 RES=400 SOLVER=Godunov
	make test_shu_osher_1d_run1 RES=800 SOLVER=Rusanov
	make test_shu_osher_1d_run1 RES=800 SOLVER=Linde
	make test_shu_osher_1d_run1 RES=800 SOLVER=Godunov
	make test_shu_osher_1d_run1 RES=1600 SOLVER=Rusanov
	make test_shu_osher_1d_run1 RES=1600 SOLVER=Linde
	make test_shu_osher_1d_run1 RES=1600 SOLVER=Godunov
	rm -rf output/test_shu_osher_1d_results
	mv ${DIR}/${RUNDIR}/RESULTS output/test_shu_osher_1d_results

test_shu_osher_1d_run1:
	cd ${DIR}/${RUNDIR}; \
		perl -pi -e '$$a=${RES}/100; s/\S+(\s*nRootBlockX)/$$a$$1/' PARAM.in;\
		perl -pi -e 's/\S+(\s*TypeFlux)/${SOLVER}$$1/' PARAM.in
	cd ${DIR}/${RUNDIR}; \
		${MPIRUN} ./BATSRUS.exe > runlog; \
		PostProc.pl -M RESULTS/${SOLVER}_${RES}

test_shu_osher_1d_check:
	${DIR}/Scripts/IDL/FixEndian.pl -e=machine -i \
		output/test_shu_osher_1d_ref.out
	cd output; idl test_shu_osher_1d.pro
	-(diff  output/test_shu_osher_1d_results/error.dat \
		output/test_shu_osher_1d.ref \
		> test_shu_osher_1d.diff)
	ls -l output/test_shu_osher_1d.diff

### Shu-Osher test on 2D grid ###

test_shu_osher_2d:
	@echo "test_shu_osher_2d_compile..." > output/test_shu_osher_2d.diff
	make test_shu_osher_2d_compile
	@echo "test_shu_osher_2d_rundir..." >> output/test_shu_osher_2d.diff
	make test_shu_osher_2d_rundir
	@echo "test_shu_osher_2d_run..." >> output/test_shu_osher_2d.diff
	make test_shu_osher_2d_run
	@echo "test_shu_osher_2d_check..." >> output/test_shu_osher_2d.diff
	make test_shu_osher_2d_check

test_shu_osher_2d_compile:
	cd ${DIR}; ./Config.pl -e=Hd -u=Waves -g=100,2,2,100,1
	cd ${DIR}; make BATSRUS PIDL

test_shu_osher_2d_rundir: test_rundir
	cp input/PARAM.in.shu_osher_2d ${DIR}/${RUNDIR}/PARAM.in

test_shu_osher_2d_run:
	make test_shu_osher_2d_run1 RES=200 SOLVER=Rusanov
	make test_shu_osher_2d_run1 RES=200 SOLVER=Linde
	make test_shu_osher_2d_run1 RES=200 SOLVER=Godunov
	make test_shu_osher_2d_run1 RES=400 SOLVER=Rusanov
	make test_shu_osher_2d_run1 RES=400 SOLVER=Linde
	make test_shu_osher_2d_run1 RES=400 SOLVER=Godunov
	make test_shu_osher_2d_run1 RES=800 SOLVER=Rusanov
	make test_shu_osher_2d_run1 RES=800 SOLVER=Linde
	make test_shu_osher_2d_run1 RES=800 SOLVER=Godunov
	make test_shu_osher_2d_run1 RES=1600 SOLVER=Rusanov
	make test_shu_osher_2d_run1 RES=1600 SOLVER=Linde
	make test_shu_osher_2d_run1 RES=1600 SOLVER=Godunov
	rm -rf output/test_shu_osher_2d_results
	mv ${DIR}/${RUNDIR}/RESULTS output/test_shu_osher_2d_results

test_shu_osher_2d_run1:
	cd ${DIR}/${RUNDIR}; \
	perl -pi -e '$$a=${RES}/100; s/\S+(\s*nRootBlockX)/$$a$$1/' PARAM.in;\
	cd ${DIR}/${RUNDIR}; \
	perl -pi -e '$$a=${RES}/200; s/\/\d+(\s*y(Min|Max))/\/$$a$$1/' PARAM.in;\
	perl -pi -e 's/\S+(\s*TypeFlux)/${SOLVER}$$1/' PARAM.in
	cd ${DIR}/${RUNDIR}; \
		${MPIRUN} ./BATSRUS.exe > runlog; \
		PostProc.pl -M RESULTS/${SOLVER}_${RES}

test_shu_osher_2d_check:
	${DIR}/Scripts/IDL/FixEndian.pl -e=machine -i \
		output/test_shu_osher_1d_ref.out
	cd output; idl test_shu_osher_2d.pro
	-(diff  output/test_shu_osher_2d_results/error.dat \
		output/test_shu_osher_2d.ref\
		> test_shu_osher_2d.diff)
	ls -l output/test_shu_osher_2d.diff

### Shu-Osher test on 2D AMR grid ###

test_shu_osher_amr:
	@echo "test_shu_osher_amr_compile..." > output/test_shu_osher_amr.diff
	make test_shu_osher_amr_compile
	@echo "test_shu_osher_amr_rundir..." >> output/test_shu_osher_amr.diff
	make test_shu_osher_amr_rundir
	@echo "test_shu_osher_amr_run..." >> output/test_shu_osher_amr.diff
	make test_shu_osher_amr_run
	@echo "test_shu_osher_amr_check..." >> output/test_shu_osher_amr.diff
	make test_shu_osher_amr_check

test_shu_osher_amr_compile:
	cd ${DIR}; ./Config.pl -e=Hd -u=Waves -g=10,4,4,1000,1
	cd ${DIR}; make BATSRUS PIDL

test_shu_osher_amr_rundir: test_rundir
	cp input/PARAM.in.shu_osher_amr ${DIR}/${RUNDIR}/PARAM.in

test_shu_osher_amr_run:
	make test_shu_osher_amr_run1 RES=200 SOLVER=Rusanov
	make test_shu_osher_amr_run1 RES=200 SOLVER=Linde
	make test_shu_osher_amr_run1 RES=200 SOLVER=Godunov
	make test_shu_osher_amr_run1 RES=400 SOLVER=Rusanov
	make test_shu_osher_amr_run1 RES=400 SOLVER=Linde
	make test_shu_osher_amr_run1 RES=400 SOLVER=Godunov
	make test_shu_osher_amr_run1 RES=800 SOLVER=Rusanov
	make test_shu_osher_amr_run1 RES=800 SOLVER=Linde
	make test_shu_osher_amr_run1 RES=800 SOLVER=Godunov
	rm -rf output/test_shu_osher_amr_results
	mv ${DIR}/${RUNDIR}/RESULTS output/test_shu_osher_amr_results

test_shu_osher_amr_run1:
	cd ${DIR}/${RUNDIR}; \
		perl -pi -e '$$a=${RES}/10; s/\S+(\s*nRootBlockX)/$$a$$1/' PARAM.in;\
		perl -pi -e '$$a=3*${RES}/200; s/\S+(\s*nRootBlockY)/$$a$$1/' PARAM.in;\
		perl -pi -e 's/\S+(\s*TypeFlux)/${SOLVER}$$1/' PARAM.in
	cd ${DIR}/${RUNDIR}; \
		${MPIRUN} ./BATSRUS.exe > runlog; \
		PostProc.pl -M RESULTS/${SOLVER}_${RES}

test_shu_osher_amr_check:
	${DIR}/Scripts/IDL/FixEndian.pl -e=machine -i \
		output/test_shu_osher_1d_ref.out
	cd output; idl test_shu_osher_amr.pro
	-(diff  output/test_shu_osher_amr_results/error.dat \
		output/test_shu_osher_amr.ref \
		> test_shu_osher_amr.diff)
	ls -l output/test_shu_osher_amr.diff

