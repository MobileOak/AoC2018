#!/usr/bin/perl -w

use strict;

my $filename = "3_mod.txt";

my @inputLines;

open (my $FILE, "<", $filename) or die "Can't open $filename\n";
chomp(@inputLines= <$FILE>);
close $FILE;

my @matrix;

# Initialize
for(my $i = 0; $i < 1000; $i++) {
  for (my $j = 0; $j < 1000; $j++) {
    $matrix[$i][$j] = ".";
  }
}

foreach my $line (@inputLines) {
  my @inputs = split(/-/, $line);
  my $claim = $inputs[0];
  my $startX = $inputs[1];
  my $startY = $inputs[2];
  my $lengthX = $inputs[3];
  my $lengthY = $inputs[4];

  for (my $i = $startX; $i < $startX + $lengthX; $i++) {
    for( my $j = $startY; $j < $startY + $lengthY; $j++) {
      if ($matrix[$i][$j] eq ".") {
        $matrix[$i][$j] = $claim;
      } else {
        $matrix[$i][$j] = "X";
      }
    }
  }
}

LINE: foreach my $line (@inputLines) {
  my @inputs = split(/-/, $line);
  my $claim = $inputs[0];
  my $startX = $inputs[1];
  my $startY = $inputs[2];
  my $lengthX = $inputs[3];
  my $lengthY = $inputs[4];

  for (my $i = $startX; $i < $startX + $lengthX; $i++) {
    for( my $j = $startY; $j < $startY + $lengthY; $j++) {
      next LINE if ($matrix[$i][$j] eq "X");
    }
  }
  print "It appears that claim $claim is the answer\n";
}

