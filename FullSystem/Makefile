#^CFG FILE TESTING

### FULL SYSTEM TESTS FOR CRASH VERSION 2 ###

test: 
	@rm -f output/*.diff
	-@(make test_laser_rz)
	-@(make test_laser_3dcont)
	-@(make test_3dlaser_rz)
	@ls -l output/*.diff

# Main BATSRUS/CRASH directory
DIR = ../../..

SCRIPTDIR = ${DIR}/share/Scripts

# All tests are done in this directory:
RUNDIR = run_test

# Tests are done either parallel or serial. Default:
MPIRUN = mpirun -np 16

help:
	@echo "    test                          (run all tests with ${MPIRUN})"
	@echo "    test MPIRUN=                  (run all tests serially)"
	@echo "    test MPIRUN='mpirun -np 3'    (run test with mpirun -np 3)"
	@echo "    test MPIRUN='mprun -np 2'     (run test with mprun -np 2)"
	@echo "    test_laser_rz              (run laser package in rz with rz-beams)"
	@echo "    test_laser_3dcont          (continue test_laser_rz run with 3D)"
	@echo "    test_3dlaser_rz            (run laser package in rz with 3d-beams)"
	@echo "    test_3dlaser_rz_nlte       (run laser package in rz with 3d-beams in NLTE"
	@echo "    test_laser_3d              (run laser package in 3d)"

test_rundir:
	cd ${DIR}; \
		rm -rf ${RUNDIR}; \
		make rundir RUNDIR=${RUNDIR} STANDALONE=YES GMDIR=`pwd` \
			DEFAULT_EXE=CRASH.exe;
	cd ${DIR}/${RUNDIR}; ln -s ../dataCRASH/LookupTables Tables

clean:
	rm -f *~ input/*~ output/*~
	cd output; rm -rf *.diff *_results

distclean: clean


### laser package with rz-beams

test_laser_rz:
	@echo "test_laser_rz_compile..." \
		> output/test_laser_rz.diff
	make test_laser_rz_compile
	@echo "test_laser_rz_rundir..." \
		>> output/test_laser_rz.diff
	make test_laser_rz_rundir
	@echo "test_laser_rz_run..." \
		>> output/test_laser_rz.diff
	make test_laser_rz_run
	@echo "test_laser_rz_check..." \
		>> output/test_laser_rz.diff
	make test_laser_rz_check

test_laser_rz_compile:
	cd ${DIR}; ./Config.pl -e=Crash -u=Crash \
		-g=8,8,1,1000,1000 -nWave=30 -nMaterial=5
	cd ${DIR}; make CRASH PIDL

test_laser_rz_rundir: test_rundir
	cp input/PARAM.in.laser_rz ${DIR}/${RUNDIR}/PARAM.in

test_laser_rz_run:
	make test_laser_rz_run1
	rm -rf output/test_laser_rz_results
	mv ${DIR}/${RUNDIR}/RESULTS output/test_laser_rz_results

test_laser_rz_run1:
	cd ${DIR}/${RUNDIR}; \
	perl -pi -e 's/1.3e-8/1.3e-9/g; \
		$$a=300; s/\S+(\s*nRayPerBeam)/$$a$$1/; \
		$$a=40; s/\S+(\s*nRootBlockX)/$$a$$1/; \
		$$a=4; s/\S+(\s*nRootBlockY)/$$a$$1/; \
		s/AMR\d\.in/AMR1.in/' PARAM.in; \
	${MPIRUN} ./CRASH.exe > runlog; \
	PostProc.pl -M RESULTS/Linde

test_laser_rz_check:
	cd output/test_laser_rz_results/; \
		tail -n 1 */GM/log*.log > log.dat
	cd output; idl test_laser_rz.pro; \
		rm -f test_laser_rz_results/*.eps
	-(${SCRIPTDIR}/DiffNum.pl \
		output/test_laser_rz_results/log.dat \
		output/test_laser_rz.ref \
		> output/test_laser_rz.diff)
	ls -l output/test_laser_rz.diff

### continue 2D run in 3D ####

CRASH2D = output/test_laser_rz_results/Linde/GM/z=0_all_2_n0_772.outs

${CRASH2D}:
	make test_laser_rz

test_laser_3dcont: ${CRASH2D}
	@echo "test_laser_3dcont_compile..." \
		> output/test_laser_3dcont.diff
	make test_laser_3dcont_compile
	@echo "test_laser_3dcont_rundir..." \
		>> output/test_laser_3dcont.diff
	make test_laser_3dcont_rundir
	@echo "test_laser_3dcont_run..." \
		>> output/test_laser_3dcont.diff
	make test_laser_3dcont_run
	@echo "test_laser_3dcont_check..." \
		>> output/test_laser_3dcont.diff
	make test_laser_3dcont_check

test_laser_3dcont_compile:
	cd ${DIR}; ./Config.pl -e=Crash -u=Crash \
		-g=4,4,4,1000,1000 -nWave=30 -nMaterial=5
	cd ${DIR}; make CRASH PIDL

test_laser_3dcont_rundir: test_rundir
	cp input/PARAM.in.laser_3dcont ${DIR}/${RUNDIR}/PARAM.in
	cp output/test_laser_rz_results/Linde/GM/z=0_all* \
		${DIR}/${RUNDIR}/z=0_all.out

test_laser_3dcont_run:
	make test_laser_3dcont_run1
	rm -rf output/test_laser_3dcont_results
	mv ${DIR}/${RUNDIR}/RESULTS output/test_laser_3dcont_results

test_laser_3dcont_run1:
	cd ${DIR}/${RUNDIR}; \
	perl -pi -e 's/1.3e-8/2e-9/g' PARAM.in; \
	${MPIRUN} ./CRASH.exe > runlog; \
	PostProc.pl -M RESULTS/Linde

test_laser_3dcont_check:
	cd output/test_laser_3dcont_results/; \
		tail -n 1 */GM/log*.log > log.dat
	cd output; idl test_laser_3dcont.pro; \
		rm -f test_laser_3dcont_results/*.eps
	-(${SCRIPTDIR}/DiffNum.pl \
		output/test_laser_3dcont_results/log.dat \
		output/test_laser_3dcont.ref \
		> output/test_laser_3dcont.diff)
	ls -l output/test_laser_3dcont.diff

### laser package in rz with 3d-beams and nlte

test_3dlaser_rz_nlte:
	@echo "test_3dlaser_rz_nlte_compile..." \
		> output/test_3dlaser_rz_nlte.diff
	make test_3dlaser_rz_nlte_compile
	@echo "test_3dlaser_rz_nlte_rundir..." \
		>> output/test_3dlaser_rz_nlte.diff
	make test_3dlaser_rz_nlte_rundir
	@echo "test_3dlaser_rz_nlte_run..." \
		>> output/test_3dlaser_rz_nlte.diff
	make test_3dlaser_rz_nlte_run
	@echo "test_3dlaser_rz_nlte_check..." \
		>> output/test_3dlaser_rz_nlte.diff
	make test_3dlaser_rz_nlte_check

test_3dlaser_rz_nlte_compile:
	cd ${DIR}; ./Config.pl -e=CrashTe -u=Crash \
		-g=8,8,1,1000,1000 -nWave=30 -nMaterial=5 -hypre
	cd ${DIR}; make CRASH PIDL

test_3dlaser_rz_nlte_rundir: test_rundir
	cp input/PARAM.in.3dlaser_rz_nlte ${DIR}/${RUNDIR}/PARAM.in

test_3dlaser_rz_nlte_run:
	make test_3dlaser_rz_nlte_run1
	rm -rf output/test_3dlaser_rz_nlte_results
	mv ${DIR}/${RUNDIR}/RESULTS output/test_3dlaser_rz_nlte_results

test_3dlaser_rz_nlte_run1:
	cd ${DIR}/${RUNDIR}; \
	perl -pi -e 's/1.3e-8/1.3e-9/g; \
		$$a=300; s/\S+(\s*nRayR)/$$a$$1/; \
		$$a=3; s/\S+(\s*nRayPhi)/$$a$$1/; \
		$$a=40; s/\S+(\s*nRootBlockX)/$$a$$1/; \
		$$a=4; s/\S+(\s*nRootBlockY)/$$a$$1/; \
		s/AMR\d\.in/AMR1.in/' PARAM.in; \
	${MPIRUN} ./CRASH.exe > runlog; \
	PostProc.pl -M RESULTS/Linde

test_3dlaser_rz_nlte_check:
	cd output/test_3dlaser_rz_nlte_results/; \
		tail -n 1 */GM/log*.log > log.dat
	cd output; idl test_3dlaser_rz.pro; \
		rm -f test_3dlaser_rz_results/*.eps
	-(${SCRIPTDIR}/DiffNum.pl \
		output/test_3dlaser_rz_nlte_results/log.dat \
		output/test_3dlaser_rz_nlte.ref \
		> output/test_3dlaser_rz_nlte.diff)
	ls -l output/test_3dlaser_rz_nlte.diff

### laser package in rz with 3d-beams

test_3dlaser_rz:
	@echo "test_3dlaser_rz_compile..." \
		> output/test_3dlaser_rz.diff
	make test_3dlaser_rz_compile
	@echo "test_3dlaser_rz_rundir..." \
		>> output/test_3dlaser_rz.diff
	make test_3dlaser_rz_rundir
	@echo "test_3dlaser_rz_run..." \
		>> output/test_3dlaser_rz.diff
	make test_3dlaser_rz_run
	@echo "test_3dlaser_rz_check..." \
		>> output/test_3dlaser_rz.diff
	make test_3dlaser_rz_check

test_3dlaser_rz_compile:
	cd ${DIR}; ./Config.pl -e=Crash -u=Crash \
		-g=8,8,1,1000,1000 -nWave=30 -nMaterial=5 -hypre
	cd ${DIR}; make CRASH PIDL

test_3dlaser_rz_rundir: test_rundir
	cp input/PARAM.in.3dlaser_rz ${DIR}/${RUNDIR}/PARAM.in

test_3dlaser_rz_run:
	make test_3dlaser_rz_run1
	rm -rf output/test_3dlaser_rz_results
	mv ${DIR}/${RUNDIR}/RESULTS output/test_3dlaser_rz_results

test_3dlaser_rz_run1:
	cd ${DIR}/${RUNDIR}; \
	perl -pi -e 's/1.3e-8/1.3e-9/g; \
		$$a=300; s/\S+(\s*nRayR)/$$a$$1/; \
		$$a=3; s/\S+(\s*nRayPhi)/$$a$$1/; \
		$$a=40; s/\S+(\s*nRootBlockX)/$$a$$1/; \
		$$a=4; s/\S+(\s*nRootBlockY)/$$a$$1/; \
		s/AMR\d\.in/AMR1.in/' PARAM.in; \
	${MPIRUN} ./CRASH.exe > runlog; \
	PostProc.pl -M RESULTS/Linde

test_3dlaser_rz_check:
	cd output/test_3dlaser_rz_results/; \
		tail -n 1 */GM/log*.log > log.dat
	cd output; idl test_3dlaser_rz.pro; \
		rm -f test_3dlaser_rz_results/*.eps
	-(${SCRIPTDIR}/DiffNum.pl \
		output/test_3dlaser_rz_results/log.dat \
		output/test_3dlaser_rz.ref \
		> output/test_3dlaser_rz.diff)
	ls -l output/test_3dlaser_rz.diff

### laser package in 3D

test_laser_3d:
	@echo "test_laser_3d_compile..." \
		> output/test_laser_3d.diff
	make test_laser_3d_compile
	@echo "test_laser_3d_rundir..." \
		>> output/test_laser_3d.diff
	make test_laser_3d_rundir
	@echo "test_laser_3d_run..." \
		>> output/test_laser_3d.diff
	make test_laser_3d_run
	@echo "test_laser_3d_check..." \
		>> output/test_laser_3d.diff
	make test_laser_3d_check

test_laser_3d_compile:
	cd ${DIR}; ./Config.pl -e=Crash -u=Crash \
		-g=4,4,4,1000,1000 -nWave=30 -nMaterial=5
	cd ${DIR}; make CRASH PIDL

test_laser_3d_rundir: test_rundir
	cp input/PARAM.in.laser_3d ${DIR}/${RUNDIR}/PARAM.in

test_laser_3d_run:
	make test_laser_3d_run1
	rm -rf output/test_laser_3d_results
	mv ${DIR}/${RUNDIR}/RESULTS output/test_laser_3d_results

test_laser_3d_run1:
	cd ${DIR}/${RUNDIR}; \
	perl -pi -e 's/1.3e-8/1.3e-9/g' PARAM.in; \
	${MPIRUN} ./CRASH.exe > runlog; \
	PostProc.pl -M RESULTS/Linde

test_laser_3d_check:
	cd output/test_laser_3d_results/; \
		tail -n 1 */GM/log*.log > log.dat
	cd output; idl test_laser_3d.pro; \
		rm -f test_laser_3d_results/*.eps
	-(${SCRIPTDIR}/DiffNum.pl \
		output/test_laser_3d_results/log.dat \
		output/test_laser_3d.ref \
		> output/test_laser_3d.diff)
	ls -l output/test_laser_3d.diff
