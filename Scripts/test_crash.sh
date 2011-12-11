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

# Checkout HYPRE
cd CRASH/util
cvs co HYPRE
cd ..

# Install CRASH
Config.pl -install -hypre

# Checkout the CRASHTEST repository
cvs co CRASHTEST

# Execute all tests. The < /dev/null is needed so that IDL runs even if the
# user is not logged in.

cd CRASHTEST
make test MPIRUN='mpirun -np 16' >& test.log < /dev/null

# Store result by yesterday's date
scp test_results.txt herot:Sites/CRASH_RESULTS/`date -v-1d +%Y.%m.%d`

# Copy results to a web site
rsync -a ~/CRASHTEST/CRASH/CRASHTEST/ herot:Sites/CRASH/CRASHTEST/ < /dev/null
