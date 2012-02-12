#!/bin/csh
cd ${HOME}/CRASHTEST

# remove old test and move last test to old one
rm -rf CRASH_OLD
mv CRASH CRASH_OLD

# checkout BATSRUS code and rename it as CRASH
cvs co BATSRUS
mv BATSRUS CRASH

# Checkout HYPRE
cd CRASH/util
cvs co HYPRE
cd ..

# Install CRASH
Config.pl -install -hypre

# Set current date of check-out
setenv CHECKOUTDATE `date +%Y.%m.%d`

# Checkout the CRASHTEST repository
cvs co CRASHTEST

# Execute all tests. The < /dev/null is needed so that IDL runs even if the
# user is not logged in.
cd CRASHTEST
make test MPIRUN='mpirun -np 16' >& test.log < /dev/null

# do this on herot too for the webpage
ssh herot "cd Sites; rm -rf CRASH_OLD; mv CRASH CRASH_OLD; mkdir CRASH"

# Store result by yesterday's date
scp test_results.txt herot:Sites/CRASH_RESULTS/${CHECKOUTDATE}

# Copy results to a web site
rsync -az --delete ~/CRASHTEST/CRASH/CRASHTEST/ herot:Sites/CRASH/CRASHTEST/ < /dev/null
