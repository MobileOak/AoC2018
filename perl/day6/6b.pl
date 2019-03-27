#!/usr/bin/perl -w

use strict;

my $filename = "input.txt";

my @inputLines;

open (my $FILE, "<", $filename) or die "Can't open $filename\n";
chomp(@inputLines = <$FILE>);
close $FILE;

my $maxX = 0;
my $maxY = 0;
my $maxDistance = 10000;
my $area = 0;

# first find outer bounds
foreach my $coord (@inputLines) {
  my @split = split(/ /, $coord);
  my $x = $split[0];
  my $y = $split[1];

  $maxX = $x if($x > $maxX);
  $maxY = $y if($y > $maxY);
}

for(my $x = 0; $x <= $maxX; $x++) {
  for(my $y = 0; $y <= $maxY; $y++) {
    my $coordinate = "$x $y";
    my $minId;
    my $distanceSum = 0;
    foreach my $coord (@inputLines) {
      my @split = split(/ /, $coord);
      my $coordX = $split[0];
      my $coordY = $split[1];
      my $distance = abs($x - $coordX) + abs($y - $coordY);
      $distanceSum += $distance;
    }
    if ($distanceSum < $maxDistance) {
      $area++;
    }
  }
}




print "area is $area\n";


