#^CFG FILE TESTING

### RADHYDRO TESTS FOR IDEAL GAS WITH GREY DIFFUSION ###

test: 
	@rm -f output/*.diff
	-@(make test_advection_2d)
	@ls -l output/*.diff

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
	@echo "    test_advection_1d          (run advection test in 1D)"
	@echo "    test_advection_2d          (run advection test in 2D)"

test_rundir:
	cd ${DIR}; \
		rm -rf ${RUNDIR}; \
		make rundir RUNDIR=${RUNDIR} STANDALONE=YES GMDIR=`pwd`; \
			DEFAULT_EXE=CRASH.exe

clean:
	rm -f *~ input/*~ output/*~
	cd output; rm -rf *.diff *.err *.eps *_results

distclean: clean

### Advection on 1D grid ###

test_advection_1d:
	@echo "test_advection_1d_compile..." > output/test_advection_1d.diff
	make test_advection_1d_compile
	@echo "test_advection_1d_rundir..." >> output/test_advection_1d.diff
	make test_advection_1d_rundir
	@echo "test_advection_1d_run..." >> output/test_advection_1d.diff
	make test_advection_1d_run
	@echo "test_advection_1d_check..." >> output/test_advection_1d.diff
	make test_advection_1d_check

test_advection_1d_compile:
	cd ${DIR}; ./Config.pl -e=HdCrash -u=Crash -g=10,2,2,1000,1
	cd ${DIR}; make CRASH PIDL

test_advection_1d_rundir: test_rundir
	cp input/PARAM.in.advection_1d ${DIR}/${RUNDIR}/PARAM.in

# These commands are switched off by default
COMMANDS = LOOKUP|MIXED|LIMITER|NONCONSERVATIVE|CYLINDRICAL

test_advection_1d_run:
	for RES in 40 80 160; do \
	 for ON in \
	    "" NONCONS LIMIT LIMIT_LOOKUP LIMIT_MIXED LIMIT_MIXED_LOOKUP; do \
	  for FLUX in Linde Godunov; do \
	   make test_advection_1d_run1 RES=$${RES} FLUX=$${FLUX} ON=$${ON};\
	  done \
         done \
	done
	rm -rf output/test_advection_1d_results
	mv ${DIR}/${RUNDIR}/RESULTS output/test_advection_1d_results

# Set solver and resolution, then first switch off all optional commands, 
# and then switch on the commands listed in ${ON}
test_advection_1d_run1:
	cd ${DIR}/${RUNDIR}; \
	perl -pi -e 's/\S+(\s*TypeFlux)/${FLUX}$$1/' PARAM.in; \
	perl -pi -e '$$a=${RES}/10; s/\S+(\s*nRootBlockX)/$$a$$1/' PARAM.in;\
	perl -pi -e 's/^#(${COMMANDS})/$$1/' PARAM.in; \
	perl -pi -e '$$a="${ON}"; $$a=~s/_/|/g; s/^($$a)/#$$1/ if $$a' PARAM.in
	cd ${DIR}/${RUNDIR}; \
	${MPIRUN} ./CRASH.exe > runlog; \
	PostProc.pl -M RESULTS/${FLUX}_${RES}_${ON}

test_advection_1d_check:
	cd output; idl test_advection_1d.pro
	-(diff  output/test_advection_1d_results/error.dat \
		output/test_advection_1d.ref\
		> output/test_advection_1d.diff)
	ls -l output/test_advection_1d.diff

### Advection on 2D grid ###

test_advection_2d:
	@echo "test_advection_2d_compile..." > output/test_advection_2d.diff
	make test_advection_2d_compile
	@echo "test_advection_2d_rundir..." >> output/test_advection_2d.diff
	make test_advection_2d_rundir
	@echo "test_advection_2d_run..." >> output/test_advection_2d.diff
	make test_advection_2d_run
	@echo "test_advection_2d_check..." >> output/test_advection_2d.diff
	make test_advection_2d_check

test_advection_2d_compile:
	cd ${DIR}; ./Config.pl -e=HdCrash -u=Crash -g=4,4,2,1000,1
	cd ${DIR}; make CRASH PIDL

test_advection_2d_rundir: test_rundir
	cp input/PARAM.in.advection_2d ${DIR}/${RUNDIR}/PARAM.in

test_advection_2d_run:
	for RES in 40 80 160; do \
	 for ON in \
	    "" NONCONS LIMIT LIMIT_LOOKUP LIMIT_MIXED LIMIT_MIXED_LOOKUP; do \
	  for FLUX in Linde Godunov; do \
	   make test_advection_2d_run1 RES=$${RES} FLUX=$${FLUX} ON=$${ON};\
	  done \
         done \
	done
	rm -rf output/test_advection_2d_results
	mv ${DIR}/${RUNDIR}/RESULTS output/test_advection_2d_results

# Set solver and resolution, then fist switch off all optional commands, and
# finally switch on the commands listed in ${ON}
test_advection_2d_run1:
	cd ${DIR}/${RUNDIR}; \
	perl -pi -e 's/\S+(\s*TypeFlux)/${FLUX}$$1/' PARAM.in; \
	perl -pi -e '$$a=${RES}/4; s/\S+(\s*nRootBlockX)/$$a$$1/' PARAM.in;\
	perl -pi -e '$$a=${RES}/8; s/\S+(\s*nRootBlockY)/$$a$$1/' PARAM.in; \
	perl -pi -e 's/^#(${COMMANDS})/$$1/' PARAM.in; \
	perl -pi -e '$$a="${ON}"; $$a=~s/_/|/g; s/^($$a)/#$$1/ if $$a' PARAM.in
	cd ${DIR}/${RUNDIR}; \
	${MPIRUN} ./CRASH.exe > runlog; \
	PostProc.pl -M RESULTS/${FLUX}_${RES}_${ON}

test_advection_2d_check:
	cd output; idl test_advection_2d.pro
	-(diff  output/test_advection_2d_results/error.dat \
		output/test_advection_2d.ref\
		> output/test_advection_2d.diff)
	ls -l output/test_advection_2d.diff

