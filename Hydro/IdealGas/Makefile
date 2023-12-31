#^CFG FILE TESTING

### RADHYDRO TESTS FOR IDEAL GAS WITH GREY DIFFUSION ###

test: 
	@rm -f output/*.diff
	-@(make test_wave_1d)
	-@(make test_shu_osher_1d)
	-@(make test_wave_amr)
	-@(make test_shu_osher_amr)
	-@(make test_double_rarefaction)
	@ls -l output/*.diff

# Path to this test directory from the main directory
TESTDIR = CRASHTEST/Hydro/IdealGas

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
	@echo "    test_shu_osher_1d          (run Shu-Osher test in 1D)"
	@echo "    test_shu_osher_2d          (run Shu-Osher test in 2D)"
	@echo "    test_shu_osher_amr         (run Shu-Osher test with 2D AMR)"
	@echo "    test_wave_1d               (run wave test in 1D)"
	@echo "    test_wave_2d               (run wave test in 2D)"
	@echo "    test_wave_amr              (run wave test with 2D AMR)"
	@echo "    test_double_rarefaction    (run double rarefaction test)"

test_rundir:
	cd ${DIR}; \
		rm -rf ${RUNDIR}; \
		make rundir RUNDIR=${RUNDIR} STANDALONE=YES GMDIR=`pwd`; \
			DEFAULT_EXE=BATSRUS.exe

clean:
	rm -f *~ input/*~ output/*~
	cd output; rm -rf *.diff *.err *.eps *_results

distclean: clean

### Sound wave test on 1D grid ###

test_wave_1d:
	@echo "test_wave_1d_compile..." > output/test_wave_1d.diff
	make test_wave_1d_compile
	@echo "test_wave_1d_rundir..." >> output/test_wave_1d.diff
	make test_wave_1d_rundir
	@echo "test_wave_1d_run..." >> output/test_wave_1d.diff
	make test_wave_1d_run
	@echo "test_wave_1d_check..." >> output/test_wave_1d.diff
	make test_wave_1d_check

test_wave_1d_compile:
	cd ${DIR}; ./Config.pl -e=Hd -u=Waves -g=10,1,1,1000,1 -ng=5
	cd ${DIR}; make BATSRUS PIDL
	cd ${DIR}; ./Config.pl -ng=2

test_wave_1d_rundir: test_rundir
	cp input/PARAM.in.wave_1d ${DIR}/${RUNDIR}/PARAM.in

test_wave_1d_run:
	for RES in 30 50 100 200 400; do \
	 for ON in "" NONCONS; do \
	  for FLUX in Rusanov Godunov; do \
           make test_wave_1d_run1 RES=$${RES} FLUX=$${FLUX} NGHOST=2 ON=$${ON}; \
	  done \
	 done \
	done
	for RES in 30 50 100 200 400; do \
	 for ON in "" NONCONS; do \
	  for FLUX in Rusanov Godunov; do \
           make test_wave_1d_run1 RES=$${RES} FLUX=$${FLUX} NGHOST=3 ON=$${ON}; \
	  done \
         done \
	done
	for RES in 30 50 100 200 400; do \
	 for ON in "" NONCONS; do \
	  for NGHOST in 4 5 MP5RK3 MP5RK4 CWENO5RK3 CWENO5RK4 FDCWENO5RK4; do \
           make test_wave_1d_run1 RES=$${RES} FLUX=Rusanov NGHOST=$${NGHOST} ON=$${ON}; \
	  done \
         done \
	done
	rm -rf output/test_wave_1d_results
	mv ${DIR}/${RUNDIR}/RESULTS output/test_wave_1d_results

test_wave_1d_run1:
	cd ${DIR}/${RUNDIR}; \
	perl -pi -e 's/\S+(\s*TypeFlux)/${FLUX}$$1/; \
		     s/^\#(SCHEME[45]?|RK|LIMITFLUX)/$$1/; \
		     s/^((SCHEME[45]?|RK|LIMITFLUX)\s+${NGHOST})/\#$$1/;\
		     $$a="${ON}"; s/^#(NONCONS)/$$1/; s/^($$a)/#$$1/ if $$a;\
		     $$a=${RES}/10; s/\S+(\s*nRootBlockX)/$$a$$1/; \
		     ' PARAM.in
	cd ${DIR}/${RUNDIR}; \
		${MPIRUN} ./BATSRUS.exe > runlog; \
		PostProc.pl -M RESULTS/${FLUX}${NGHOST}_${RES}_${ON}

test_wave_1d_check:
	cd output; idl test_wave_1d.pro; \
		rm -f test_wave_1d_results/*.eps
	-(${SCRIPTDIR}/DiffNum.pl \
		output/test_wave_1d_results/error.dat \
		output/test_wave_1d.ref \
		> output/test_wave_1d.diff)
	ls -l output/test_wave_1d.diff

### Sound wave test on 2D grid ###

test_wave_2d:
	@echo "test_wave_2d_compile..." > output/test_wave_2d.diff
	make test_wave_2d_compile
	@echo "test_wave_2d_rundir..." >> output/test_wave_2d.diff
	make test_wave_2d_rundir
	@echo "test_wave_2d_run..." >> output/test_wave_2d.diff
	make test_wave_2d_run
	@echo "test_wave_2d_check..." >> output/test_wave_2d.diff
	make test_wave_2d_check

test_wave_2d_compile:
	cd ${DIR}; ./Config.pl -e=Hd -u=Waves -f -g=100,2,1,100,1
	cd ${DIR}; make BATSRUS PIDL

test_wave_2d_rundir: test_rundir
	cp input/PARAM.in.wave_2d ${DIR}/${RUNDIR}/PARAM.in

test_wave_2d_run:
	for RES in 100 200 400; do \
	 for ON in "" NONCONS; do \
	  for FLUX in Linde Godunov; do \
           make test_wave_2d_run1 RES=$${RES} FLUX=$${FLUX} ON=$${ON}; \
	  done \
	 done \
	done
	rm -rf output/test_wave_2d_results
	mv ${DIR}/${RUNDIR}/RESULTS output/test_wave_2d_results

test_wave_2d_run1:
	cd ${DIR}/${RUNDIR}; \
	perl -pi -e 's/\S+(\s*TypeFlux)/${FLUX}$$1/; \
		     $$a="${ON}"; s/^#(NONCONS)/$$1/; s/^($$a)/#$$1/ if $$a;\
		     $$a=${RES}/100; s/\S+(\s*nRootBlockX)/$$a$$1/; \
		     s/\/\d+(\s*y(Min|Max))/\/$$a$$1/' PARAM.in
	cd ${DIR}/${RUNDIR}; \
		${MPIRUN} ./BATSRUS.exe > runlog; \
		PostProc.pl -M RESULTS/${FLUX}_${RES}_${ON}

test_wave_2d_check:
	cd output; idl test_wave_2d.pro; \
		rm -f test_wave_2d_results/*.eps
	-(${SCRIPTDIR}/DiffNum.pl \
		output/test_wave_2d_results/error.dat \
		output/test_wave_2d.ref \
		> output/test_wave_2d.diff)
	ls -l output/test_wave_2d.diff

### Sound wave test on 2D AMR grid ###

test_wave_amr:
	@echo "test_wave_amr_compile..." > output/test_wave_amr.diff
	make test_wave_amr_compile
	@echo "test_wave_amr_rundir..." >> output/test_wave_amr.diff
	make test_wave_amr_rundir
	@echo "test_wave_amr_run..." >> output/test_wave_amr.diff
	make test_wave_amr_run
	@echo "test_wave_amr_check..." >> output/test_wave_amr.diff
	make test_wave_amr_check

test_wave_amr_compile:
	cd ${DIR}; ./Config.pl -e=Hd -u=Waves -g=10,4,1,1000,1
	cd ${DIR}; make BATSRUS PIDL

test_wave_amr_rundir: test_rundir
	cp input/PARAM.in.wave_amr ${DIR}/${RUNDIR}/PARAM.in

test_wave_amr_run:
	for RES in 100 200 400; do \
	 for ON in "" NONCONS; do \
	  for FLUX in Linde Godunov; do \
           make test_wave_amr_run1 RES=$${RES} FLUX=$${FLUX} ON=$${ON}; \
	  done \
	 done \
	done
	rm -rf output/test_wave_amr_results
	mv ${DIR}/${RUNDIR}/RESULTS output/test_wave_amr_results

test_wave_amr_run1:
	cd ${DIR}/${RUNDIR}; \
	perl -pi -e 's/\S+(\s*TypeFlux)/${FLUX}$$1/; \
		     $$a="${ON}"; s/^#(NONCONS)/$$1/; s/^($$a)/#$$1/ if $$a;\
		     $$a=${RES}/10; s/\S+(\s*nRootBlockX)/$$a$$1/; \
		     $$a=3*${RES}/100; s/\S+(\s*nRootBlockY)/$$a$$1/' PARAM.in
	cd ${DIR}/${RUNDIR}; \
		${MPIRUN} ./BATSRUS.exe > runlog; \
		PostProc.pl -M RESULTS/${FLUX}_${RES}_${ON}

test_wave_amr_check:
	cd output; idl test_wave_amr.pro; \
		rm -f test_wave_amr_results/*.eps
	-(${SCRIPTDIR}/DiffNum.pl \
		output/test_wave_amr_results/error.dat \
		output/test_wave_amr.ref \
		> output/test_wave_amr.diff)
	ls -l output/test_wave_amr.diff

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
	cd ${DIR}; ./Config.pl -e=Hd -u=Waves -g=10,1,1,1000,1 -ng=5
	cd ${DIR}; make BATSRUS PIDL
	cd ${DIR}; ./Config.pl -ng=2

test_shu_osher_1d_rundir: test_rundir
	cp input/PARAM.in.shu_osher_1d ${DIR}/${RUNDIR}/PARAM.in

test_shu_osher_1d_run:
	for RES in 200 400 800; do \
	 for FLUX in Rusanov Linde Godunov; do \
	  for NGHOST in 2 3 4 5 MP5 CWENO5; do \
	   make test_shu_osher_1d_run1 RES=$${RES} NGHOST=$${NGHOST} FLUX=$${FLUX}; \
	  done \
         done \
        done
	for RES in 200 400 800; do \
	 for NGHOST in MP5_InterpolateFlux CWENO5_InterpolateFlux; do \
	  make test_shu_osher_1d_run1 RES=$${RES} NGHOST=$${NGHOST} FLUX=Rusanov; \
	 done \
        done
	rm -rf output/test_shu_osher_1d_results
	mv ${DIR}/${RUNDIR}/RESULTS output/test_shu_osher_1d_results

test_shu_osher_1d_run1:
	cd ${DIR}/${RUNDIR}; \
		perl -pi -e '$$a=${RES}/10; s/\S+(\s*nRootBlockX)/$$a$$1/; \
			     s/^\#(SCHEME[45]?)/$$1/; \
			     s/^(SCHEME[45]?\s+${NGHOST}\s+)/\#$$1/;\
		             s/\S+(\s*TypeFlux)/${FLUX}$$1/' PARAM.in
	cd ${DIR}/${RUNDIR}; \
		${MPIRUN} ./BATSRUS.exe > runlog; \
		PostProc.pl -M RESULTS/${FLUX}${NGHOST}_${RES}

test_shu_osher_1d_check:
	${DIR}/Scripts/IDL/FixEndian.pl -e=machine -i \
		output/test_shu_osher_1d_ref.out
	cd output; idl test_shu_osher_1d.pro; \
		rm -f test_shu_osher_1d_results/*.eps
	-(${SCRIPTDIR}/DiffNum.pl \
		output/test_shu_osher_1d_results/error.dat \
		output/test_shu_osher_1d.ref \
		> output/test_shu_osher_1d.diff)
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
	cd ${DIR}; ./Config.pl -e=Hd -u=Waves -f -g=100,2,1,100,1
	cd ${DIR}; make BATSRUS PIDL

test_shu_osher_2d_rundir: test_rundir
	cp input/PARAM.in.shu_osher_2d ${DIR}/${RUNDIR}/PARAM.in

test_shu_osher_2d_run:
	for RES in 200 400 800 1600; do \
	 for FLUX in Rusanov Linde Godunov; do \
	  make test_shu_osher_2d_run1 RES=$${RES} FLUX=$${FLUX}; \
         done \
        done
	rm -rf output/test_shu_osher_2d_results
	mv ${DIR}/${RUNDIR}/RESULTS output/test_shu_osher_2d_results

test_shu_osher_2d_run1:
	cd ${DIR}/${RUNDIR}; \
	perl -pi -e '$$a=${RES}/100; s/\S+(\s*nRootBlockX)/$$a$$1/; \
		     s/\/\d+(\s*y(Min|Max))/\/$$a$$1/; \
		     s/\S+(\s*TypeFlux)/${FLUX}$$1/' PARAM.in
	cd ${DIR}/${RUNDIR}; \
		${MPIRUN} ./BATSRUS.exe > runlog; \
		PostProc.pl -M RESULTS/${FLUX}_${RES}

test_shu_osher_2d_check:
	${DIR}/Scripts/IDL/FixEndian.pl -e=machine -i \
		output/test_shu_osher_1d_ref.out
	cd output; idl test_shu_osher_2d.pro; \
		rm -f test_shu_osher_2d_results/*.eps
	-(${SCRIPTDIR}/DiffNum.pl \
		output/test_shu_osher_2d_results/error.dat \
		output/test_shu_osher_2d.ref\
		> output/test_shu_osher_2d.diff)
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
	cd ${DIR}; ./Config.pl -e=Hd -u=Waves -g=10,4,1,1000,1
	cd ${DIR}; make BATSRUS PIDL

test_shu_osher_amr_rundir: test_rundir
	cp input/PARAM.in.shu_osher_amr ${DIR}/${RUNDIR}/PARAM.in

test_shu_osher_amr_run:
	for RES in 200 400 800; do \
	 for FLUX in Rusanov Linde Godunov; do \
	  make test_shu_osher_amr_run1 RES=$${RES} FLUX=$${FLUX}; \
         done \
        done
	rm -rf output/test_shu_osher_amr_results
	mv ${DIR}/${RUNDIR}/RESULTS output/test_shu_osher_amr_results

test_shu_osher_amr_run1:
	cd ${DIR}/${RUNDIR}; \
	perl -pi -e '$$a=${RES}/10; s/\S+(\s*nRootBlockX)/$$a$$1/; \
		     $$a=3*${RES}/200; s/\S+(\s*nRootBlockY)/$$a$$1/; \
		     s/\S+(\s*TypeFlux)/${FLUX}$$1/' PARAM.in
	cd ${DIR}/${RUNDIR}; \
		${MPIRUN} ./BATSRUS.exe > runlog; \
		PostProc.pl -M RESULTS/${FLUX}_${RES}

test_shu_osher_amr_check:
	${DIR}/Scripts/IDL/FixEndian.pl -e=machine -i \
		output/test_shu_osher_1d_ref.out
	cd output; idl test_shu_osher_amr.pro; \
		rm -f test_shu_osher_amr_results/*.eps
	-(${SCRIPTDIR}/DiffNum.pl -r=1e-4 \
		output/test_shu_osher_amr_results/error.dat \
		output/test_shu_osher_amr.ref \
		> output/test_shu_osher_amr.diff)
	ls -l output/test_shu_osher_amr.diff

### double rarefaction test ###

test_double_rarefaction:
	@echo "test_double_rarefaction_compile..." > output/test_double_rarefaction.diff
	make test_double_rarefaction_compile
	@echo "test_double_rarefaction_rundir..." >> output/test_double_rarefaction.diff
	make test_double_rarefaction_rundir
	@echo "test_double_rarefaction_run..." >> output/test_double_rarefaction.diff
	make test_double_rarefaction_run
	@echo "test_double_rarefaction_check..." >> output/test_double_rarefaction.diff
	make test_double_rarefaction_check

test_double_rarefaction_compile:
	cd ${DIR}; ./Config.pl -e=Hd -u=Waves -g=10,1,1,1000,1
	cd ${DIR}; make BATSRUS PIDL

test_double_rarefaction_rundir: test_rundir
	cp input/PARAM.in.double_rarefaction ${DIR}/${RUNDIR}/PARAM.in

test_double_rarefaction_run:
	for RES in 200 400 800 3200; do \
	 for FLUX in HLLDW Linde Godunov; do \
	  make test_double_rarefaction_run1 RES=$${RES} FLUX=$${FLUX}; \
         done \
        done
	rm -rf output/test_double_rarefaction_results
	mv ${DIR}/${RUNDIR}/RESULTS output/test_double_rarefaction_results

test_double_rarefaction_run1:
	cd ${DIR}/${RUNDIR}; \
	perl -pi -e '$$a=${RES}/10; s/\S+(\s*nRootBlockX)/$$a$$1/; \
		     s/\S+(\s*TypeFlux)/${FLUX}$$1/' PARAM.in
	cd ${DIR}/${RUNDIR}; \
		${MPIRUN} ./BATSRUS.exe > runlog; \
		PostProc.pl -M RESULTS/${FLUX}_${RES}

test_double_rarefaction_check:
	cd output; idl test_double_rarefaction.pro; \
		rm -f test_double_rarefaction_results/*.eps
	-(${SCRIPTDIR}/DiffNum.pl \
		output/test_double_rarefaction_results/error.dat \
		output/test_double_rarefaction.ref \
		> output/test_double_rarefaction.diff)
	ls -l output/test_double_rarefaction.diff
