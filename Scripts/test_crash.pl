#!/usr/bin/perl
# This script should be executed after CRASHTEST is supposed to be finished
# but still the same day!

my $file = "CRASH/CRASHTEST/test.results";
exec("test_crash_mail.sh $file is missing") unless -s $file; 

# Check the date and size
my $date = `date`;
my $check = "gtoth  hpcc  0 ".substr($date,4,6);
exec("test_crash_mail.sh Some CRASHTEST tests failed") 
    if `grep -v '$check' $file`;

print "CRASHTEST tests seem to have succeeded\n";
