#!/bin/csh
cd ${HOME}/CRASHTEST

# remove old test and move last test to old one
rm -rf CRASH_OLD
mv CRASH CRASH_OLD

# do this on herot too for the webpage
ssh herot "cd Sites; rm -rf CRASH_OLD; mv CRASH CRASH_OLD; mkdir CRASH"

# checkout BATSRUS code and rename it as CRASH
cvs co BATSRUS
mv BATSRUS CRASH

# Install CRASH
cd CRASH
Config.pl -install -mpi=openmpi

# Checkout the CRASHTEST repository
cvs co CRASHTEST

# Execute all tests. The < /dev/null is needed so that IDL runs even if the
# user is not logged in.
cd CRASHTEST
make test MPIRUN='mpirun -np 16' >& test.log < /dev/null

# Copy results to a web site
rsync -az --delete ~/CRASHTEST/CRASH/CRASHTEST/ herot:Sites/CRASH/CRASHTEST/ \
    >& test.log < /dev/null

# Store result by yesterday's date
scp CRASH/CRASHTEST/test_results.html \
    herot:Sites/CRASH_RESULTS/`date -v-1d +%Y.%m.%d`
