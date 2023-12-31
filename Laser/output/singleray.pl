#!/usr/bin/perl -i
use strict;

my $NameFile;
my $RES;
my @PosXhold;
my @TurningPoint;
my @SumLaserHeating;
my @SumLaserHeatingRef;
my $i;
my $Test = $ARGV[0];

foreach $i (0, 1, 2, 3)
{
    $RES = 2**$i;

    $NameFile = $Test."_results/".$RES."/runlog" || die("Cannot Open File");
    open(FILE, $NameFile);
    while(<FILE>){
	@PosXhold[$i]=$1           if /\bmaximum X position of ray\s*=\s*([-+]?[0-9]*\.?[0-9]+([eE][-+]?[0-9]+)?)/i;
	@TurningPoint[$i]=$1       if /\bAnalytical turning point\s*=\s*([-+]?[0-9]*\.?[0-9]+([eE][-+]?[0-9]+)?)/i;
	@SumLaserHeating[$i]=$1    if /\bsum laser heating\s*=\s*([-+]?[0-9]*\.?[0-9]+([eE][-+]?[0-9]+)?)/i;
	@SumLaserHeatingRef[$i]=$1 if /\bAnalytical fractional absorption\s*=\s*([-+]?[0-9]*\.?[0-9]+([eE][-+]?[0-9]+)?)/i;
    }
    close FILE;
}

$NameFile = ">".$Test."_results/error.dat";

open(FILE, $NameFile);
print FILE "single ray test\n";
print FILE "resolution turning_point_error energy_deposition_error\n";
foreach $i (0, 1, 2, 3)
{
    $RES = 2**$i;
    print FILE $RES," ",abs(@PosXhold[$i] - @TurningPoint[$i])," ",abs(@SumLaserHeating[$i] - @SumLaserHeatingRef[$i]),"\n";
}
close FILE;
