#!/usr/bin/perl -w

use strict;

my $filename = "input.txt";

my @inputLines;

open (my $FILE, "<", $filename) or die "Can't open $filename\n";
chomp(@inputLines = <$FILE>);
close $FILE;

my $maxX = 0;
my $maxY = 0;

my %coordsHash;
my %sizeHash;
my @toProcess;
my @nextProcess;

# first find outer bounds
foreach my $coord (@inputLines) {
  my @split = split(/ /, $coord);
  my $x = $split[0];
  my $y = $split[1];

  $maxX = $x if($x > $maxX);
  $maxY = $y if($y > $maxY);
  $sizeHash{$coord} = 0;
}

for(my $x = 0; $x <= $maxX; $x++) {
  for(my $y = 0; $y <= $maxY; $y++) {
    my $minDist = $maxX + $maxY;
    my $minId;
    foreach my $coord (@inputLines) {
      my @split = split(/ /, $coord);
      my $coordX = $split[0];
      my $coordY = $split[1];
      my $distance = abs($x - $coordX) + abs($y - $coordY);
      if ($distance < $minDist) {
        $minDist = $distance;
        $minId = $coord;
      } elsif ($distance == $minDist) {
        $minId = "-1 -1";
      }
    }
    my $coordinate = "$x $y";
    $coordsHash{ $coordinate } = $minId;
    if ($minId ne "-1 -1") {
      my $size = $sizeHash{ $minId };
      $sizeHash{ $minId } = $size + 1;
    }
  }
}

my %boundaryItems;
for(my $x = 0; $x <= $maxX; $x++) {
  my $left = "$x 0";
  my $right = "$x $maxY";
  my $value = $coordsHash{ $left };
  $boundaryItems{ $value } = 1;
  $value = $coordsHash{ $right };
  $boundaryItems{ $value } = 1;
}

for(my $y = 0; $y <= $maxY; $y++) {
  my $top = "0 $y";
  my $bottom = "$maxX $y";
  my $value = $coordsHash{ $top };
  $boundaryItems{ $value } = 1;
  $value = $coordsHash{ $bottom };
  $boundaryItems{ $value } = 1;
}

my $maxArea = 0;

foreach my $area (keys %sizeHash) {
  if (!defined $boundaryItems{ $area }) {
    if ($sizeHash{ $area } > $maxArea) {
      $maxArea = $sizeHash{ $area };
    }
  }
}

print "Max area is $maxArea\n";


#printGrid();

sub printGrid {
  print "\t0\t1\t2\t3\t4\t5\t6\t7\t8\n";
  for(my $y = 0; $y <= $maxY; $y++) {
    print "$y";
    for(my $x = 0; $x <= $maxX; $x++) {
      my $coord = "$x $y";
      if (defined $coordsHash{ $coord }) {
	my $value = $coordsHash{ $coord };
	print "\t$value";
      } else {
        print "\t..";
      }
    }
    print "\n";
  }
}

