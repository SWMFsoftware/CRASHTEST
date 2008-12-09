#!/bin/csh
cd ${HOME}/Sites
# remove old test
rm -rf CRASH_OLD
# store current test as old
mv CRASH CRASH_OLD
# checkout BATSRUS code and rename it as CRASH
cvs co BATSRUS
mv BATSRUS CRASH
# do not allow people to look at the whole code
chmod -R go-r CRASH
# Install CRASH
cd CRASH
Config.pl -install -mpi=openmpi
# Checkout the CRASHTEST repository
cvs co CRASHTEST
# Allow people to look at CRASH/CRASHTEST while test is running
cd CRASHTEST
chmod -R go+r .
# Execute all tests. The < /dev/null is needed so that IDL runs even if the
# user is not logged in.
make test MPIRUN='mpirun -np 6' >& test.log < /dev/null
# Allow people to look at final results
chmod -R go+r .
