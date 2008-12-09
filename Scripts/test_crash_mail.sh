#!/bin/csh
/usr/bin/mail -s "$*" gtoth@umich.edu <<EOF
This is an automated message from the CRASH verification test suite.
The CRASHTEST suite failed. For the current test results see

http://herot.engin.umich.edu/~gtoth/CRASH/CRASHTEST

For the previous test see

http://herot.engin.umich.edu/~gtoth/CRASH_OLD/CRASHTEST

Best regards,

CRASHTEST

EOF
