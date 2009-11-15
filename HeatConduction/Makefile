#^CFG FILE TESTING

### RADHYDRO TESTS FOR IDEAL GAS WITH GREY DIFFUSION ###

test: 
	@rm -f output/*.diff
	-@(make test_uniform_1d)
	-@(make test_uniform_2d)
	-@(make test_uniform_2d_amr)
	-@(make test_rmtv)
	-@(make test_lowrie3)
	@ls -l output/*.diff

# Path to this test directory from the main directory
TESTDIR = CRASHTEST/HeatConduction

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
	@echo "    test_uniform_1d            (run uniform heat conduction test in 1D)"
	@echo "    test_uniform_2d            (run uniform heat conduction test in 2D)"
	@echo "    test_uniform_2d_amr        (run uniform heat conduction test in 2D with AMR)"
	@echo "    test_rmtv                  (run Reinicke Meyer-ter Vehn test)"
	@echo "    test_lowrie3               (run lowrie3 test modified for heat conduction)"


test_rundir:
	cd ${DIR}; \
		rm -rf ${RUNDIR}; \
		make rundir RUNDIR=${RUNDIR} STANDALONE=YES GMDIR=`pwd`; \
			DEFAULT_EXE=BATSRUS.exe


### Heat conduction test in 1D with uniform diffusion coefficient ###

test_uniform_1d:
	@echo "test_uniform_1d_compile..." > output/test_uniform_1d.diff
	make test_uniform_1d_compile
	@echo "test_uniform_1d_rundir..." >> output/test_uniform_1d.diff
	make test_uniform_1d_rundir
	@echo "test_uniform_1d_run..." >> output/test_uniform_1d.diff
	make test_uniform_1d_run
	@echo "test_uniform_1d_check..." >> output/test_uniform_1d.diff
	make test_uniform_1d_check

test_uniform_1d_compile:
	cd ${DIR}; ./Config.pl -u=HeatConduction -e=HdEos -g=100,2,2,16,16
	cd ${DIR}; make BATSRUS PIDL

test_uniform_1d_rundir: test_rundir
	cp input/PARAM.in.uniform_1d ${DIR}/${RUNDIR}/PARAM.in

test_uniform_1d_run:
	make test_uniform_1d_run_res RES=200
	make test_uniform_1d_run_res RES=400
	make test_uniform_1d_run_res RES=800
	make test_uniform_1d_run_res RES=1600
	rm -rf output/test_uniform_1d_results
	mv ${DIR}/${RUNDIR}/RESULTS output/test_uniform_1d_results

test_uniform_1d_run_res:
	cd ${DIR}/${RUNDIR}; \
		perl -pi -e '$$a=${RES}/100; s/\S+(\s*nRootBlockX)/$$a$$1/' PARAM.in
	cd ${DIR}/${RUNDIR}; \
		${MPIRUN} ./BATSRUS.exe > runlog; \
		PostProc.pl -M RESULTS/${RES}

test_uniform_1d_check:
	cd output; idl test_uniform_1d.pro; \
		rm -f test_uniform_1d_results/*.eps
	-(diff  output/test_uniform_1d_results/error.dat \
		output/test_uniform_1d.ref \
		> output/test_uniform_1d.diff)
	ls -l output/test_uniform_1d.diff


### Heat conduction test in 2D with uniform diffusion coefficient ###

test_uniform_2d:
	@echo "test_uniform_2d_compile..." > output/test_uniform_2d.diff
	make test_uniform_2d_compile
	@echo "test_uniform_2d_rundir..." >> output/test_uniform_2d.diff
	make test_uniform_2d_rundir
	@echo "test_uniform_2d_run..." >> output/test_uniform_2d.diff
	make test_uniform_2d_run
	@echo "test_uniform_2d_check..." >> output/test_uniform_2d.diff
	make test_uniform_2d_check

test_uniform_2d_compile:
	cd ${DIR}; ./Config.pl -u=HeatConduction -e=HdEos -g=20,20,2,800,800
	cd ${DIR}; make BATSRUS PIDL

test_uniform_2d_rundir: test_rundir
	cp input/PARAM.in.uniform_2d ${DIR}/${RUNDIR}/PARAM.in

test_uniform_2d_run:
	make test_uniform_2d_run_res RES=100
	make test_uniform_2d_run_res RES=200
	make test_uniform_2d_run_res RES=400
	#make test_uniform_2d_run_res RES=800
	rm -rf output/test_uniform_2d_results
	mv ${DIR}/${RUNDIR}/RESULTS output/test_uniform_2d_results

test_uniform_2d_run_res:
	cd ${DIR}/${RUNDIR}; \
		perl -pi -e '$$a=${RES}/20; s/\S+(\s*nRootBlockX)/$$a$$1/' PARAM.in;\
		perl -pi -e '$$a=${RES}/20; s/\S+(\s*nRootBlockY)/$$a$$1/' PARAM.in
	cd ${DIR}/${RUNDIR}; \
		${MPIRUN} ./BATSRUS.exe > runlog; \
		PostProc.pl -M RESULTS/${RES}

test_uniform_2d_check:
	cd output; idl test_uniform_2d.pro; \
		rm -f test_uniform_2d_results/*.eps
	-(diff  output/test_uniform_2d_results/error.dat \
		output/test_uniform_2d.ref \
		> output/test_uniform_2d.diff)
	ls -l output/test_uniform_2d.diff


### Heat conduction test in 2D with AMR and uniform diffusion coefficient ###

test_uniform_2d_amr:
	@echo "test_uniform_2d_amr_compile..." > output/test_uniform_2d_amr.diff
	make test_uniform_2d_amr_compile
	@echo "test_uniform_2d_amr_rundir..." >> output/test_uniform_2d_amr.diff
	make test_uniform_2d_amr_rundir
	@echo "test_uniform_2d_amr_run..." >> output/test_uniform_2d_amr.diff
	make test_uniform_2d_amr_run
	@echo "test_uniform_2d_amr_check..." >> output/test_uniform_2d_amr.diff
	make test_uniform_2d_amr_check

test_uniform_2d_amr_compile:
	cd ${DIR}; ./Config.pl -u=HeatConduction -e=HdEos -g=30,30,4,256,256
	cd ${DIR}; make BATSRUS PIDL

test_uniform_2d_amr_rundir: test_rundir
	cp input/PARAM.in.uniform_2d_amr ${DIR}/${RUNDIR}/PARAM.in

test_uniform_2d_amr_run:
	make test_uniform_2d_amr_run_res RES=90
	make test_uniform_2d_amr_run_res RES=180
	make test_uniform_2d_amr_run_res RES=360
	rm -rf output/test_uniform_2d_amr_results
	mv ${DIR}/${RUNDIR}/RESULTS output/test_uniform_2d_amr_results

test_uniform_2d_amr_run_res:
	cd ${DIR}/${RUNDIR}; \
		perl -pi -e '$$a=${RES}/30; s/\S+(\s*nRootBlockX)/$$a$$1/' PARAM.in;\
		perl -pi -e '$$a=${RES}/30; s/\S+(\s*nRootBlockY)/$$a$$1/' PARAM.in
	cd ${DIR}/${RUNDIR}; \
		${MPIRUN} ./BATSRUS.exe > runlog; \
		PostProc.pl -M RESULTS/${RES}

test_uniform_2d_amr_check:
	cd output; idl test_uniform_2d_amr.pro; \
		rm -f test_uniform_2d_amr_results/*.eps
	-(diff  output/test_uniform_2d_amr_results/error.dat \
		output/test_uniform_2d_amr.ref \
		> output/test_uniform_2d_amr.diff)
	ls -l output/test_uniform_2d_amr.diff


### Reinicke Meyer-ter Vehn test ###

test_rmtv:
	@echo "test_rmtv_compile..." > output/test_rmtv.diff
	make test_rmtv_compile
	@echo "test_rmtv_rundir..." >> output/test_rmtv.diff
	make test_rmtv_rundir
	@echo "test_rmtv_run..." >> output/test_rmtv.diff
	make test_rmtv_run
	@echo "test_rmtv_check..." >> output/test_rmtv.diff
	make test_rmtv_check

test_rmtv_compile:
	cd ${DIR}; ./Config.pl -u=HeatConduction -e=HdEos -g=20,20,2,400,400
	cd ${DIR}; make BATSRUS PIDL

test_rmtv_rundir: test_rundir
	cp input/rmtv_initial.out ${DIR}/${RUNDIR}/
	cp input/rmtv_final.out ${DIR}/${RUNDIR}/
	cp input/PARAM.in.rmtv ${DIR}/${RUNDIR}/PARAM.in

test_rmtv_run:
	make test_rmtv_run_res RES=100
	make test_rmtv_run_res RES=200
	make test_rmtv_run_res RES=400
	#make test_rmtv_run_res RES=800
	rm -rf output/test_rmtv_results
	mv ${DIR}/${RUNDIR}/RESULTS output/test_rmtv_results

test_rmtv_run_res:
	cd ${DIR}/${RUNDIR}; \
		perl -pi -e '$$a=${RES}/20; s/\S+(\s*nRootBlockX)/$$a$$1/' PARAM.in;\
		perl -pi -e '$$a=${RES}/20; s/\S+(\s*nRootBlockY)/$$a$$1/' PARAM.in
	cd ${DIR}/${RUNDIR}; \
		${MPIRUN} ./BATSRUS.exe > runlog; \
		PostProc.pl -M RESULTS/${RES}

test_rmtv_check:
	cd output; idl test_rmtv.pro; \
		rm -f test_rmtv_results/*.eps
	-(diff  output/test_rmtv_results/error.dat \
		output/test_rmtv.ref \
		> output/test_rmtv.diff)
	ls -l output/test_rmtv.diff


### Lowrie's 3 radiation test modified for heat conduction ###

test_lowrie3:
	@echo "test_lowrie3_compile..." > output/test_lowrie3.diff
	make test_lowrie3_compile
	@echo "test_lowrie3_rundir..." >> output/test_lowrie3.diff
	make test_lowrie3_rundir
	@echo "test_lowrie3_run..." >> output/test_lowrie3.diff
	make test_lowrie3_run
	@echo "test_lowrie3_check..." >> output/test_lowrie3.diff
	make test_lowrie3_check

test_lowrie3_compile:
	cd ${DIR}; ./Config.pl -u=HeatConduction -e=Crash -g=32,4,4,256,256
	cd ${DIR}; make BATSRUS PIDL

test_lowrie3_rundir: test_rundir
	cp input/PARAM.in.lowrie3 ${DIR}/${RUNDIR}/PARAM.in
	cp input/lowrie3.out  ${DIR}/${RUNDIR}/

test_lowrie3_run:
	for RES in 96 192 384; do \
	 for FLUX in Linde Godunov; do \
	  make test_lowrie3_run1 RES=$${RES} FLUX=$${FLUX} SOLVER=cond; \
	 done; \
	 make test_lowrie3_run1 RES=$${RES} FLUX=Linde   SOLVER=radcond; \
	done
	rm -rf output/test_lowrie3_results
	mv ${DIR}/${RUNDIR}/RESULTS output/test_lowrie3_results

test_lowrie3_run1:
	cd ${DIR}/${RUNDIR}; \
	perl -pi -e 's/\S+(\s*TypeFlux)/${FLUX}$$1/; \
		$$a=${RES}/32; s/\S+(\s*nRootBlockX)/$$a$$1/; \
		$$a=${RES}/32; s/\S+(\s*nRootBlockY)/$$a$$1/' PARAM.in; \
	perl -pi -e 's/\S+(\s*TypeSemiImplicit)/${SOLVER}$$1/' PARAM.in
	cd ${DIR}/${RUNDIR}; \
		${MPIRUN} ./BATSRUS.exe > runlog; \
		PostProc.pl -M RESULTS/${FLUX}_${SOLVER}_${RES}

test_lowrie3_check:
	cd output; idl test_lowrie3.pro; \
		rm -f test_lowrie3_results/*.eps
	-(diff  output/test_lowrie3_results/error.dat \
		output/test_lowrie3.ref \
		> output/test_lowrie3.diff)
	ls -l output/test_lowrie3.diff


clean:
	rm -f *~ input/*~ output/*~
	cd output; rm -rf *.diff *_results

distclean: clean
