#!/bin/csh
# crontab entry for hera (Pacific time) for execution on Fridays 19:00EDT
# 00 16 * * 5 ${HOME}/bin/test_crash_scaling.sh

set path = (~/bin /usr/local/bin ${path} .)

# This script checks out the latest version of the CRASH and CRASHTEST
# executes some tests in CRASHTEST on various number of processors
# and scp-s back the results to herot.engin.umich.edu
#
# To run the CRASH scaling test periodically use a crontab entry

# Update CRASH_data/input
cd ${HOME}/CRASH_data/input
cvs update

# Go to Tmp (a link to the /p/lscratchb/ disk)
cd ${HOME}/Tmp

# remove old test and move last test to old one
rm -rf CRASH_OLD
mv CRASH CRASH_OLD

# checkout BATSRUS code and rename it as CRASH
cvs co BATSRUS
mv BATSRUS CRASH

# Install CRASH
cd CRASH
./Config.pl -install > test.log 

# Do the scaling tests
Scripts/Scaling.pl -v -n=128,256 -radhydro -compile -rundir -submit \
    >> test.log
