#!/usr/bin/perl -w

use strict;

my $filename = "2_input.txt";

my @inputLines;

my $twoCount = 0;
my $threeCount = 0;

open (my $FILE, "<", $filename) or die "Can't open $filename\n";
chomp(@inputLines= <$FILE>);
close $FILE;

foreach my $line (@inputLines) {
  my %hash;
  for my $c (split //, $line) {
    if (defined $hash{$c}) {
      $hash{$c} = $hash{$c} + 1;
    } else {
      $hash{$c} = 1;
    }
  }

  my $twoFound = 0;
  my $threeFound = 0;
  for my $c (keys %hash) {
    if ($hash{$c} == 2) {
      print "In $line, $c appears twice\n";
      $twoFound = 1;
    } elsif ($hash{$c} == 3) {
      print "In $line, $c appears three times\n";
      $threeFound = 1;
    }
  }
  $twoCount += $twoFound;
  $threeCount += $threeFound;
}

my $result = $twoCount * $threeCount;
print "Result is $twoCount * $threeCount = $result\n";
