#!/usr/bin/perl -w

use strict;

my $filename = "2_input.txt";

my @inputLines;

open (my $FILE, "<", $filename) or die "Can't open $filename\n";
chomp(@inputLines= <$FILE>);
close $FILE;

foreach my $line (@inputLines) {
SECLINE:  foreach my $secondLine (@inputLines) {
    next if ($line eq $secondLine);
    my @lineChars = $line =~ /./sg;
    my @secChars = $secondLine =~ /./sg;
    my $foundDiff = 0;
    for(my $i = 0; $i < scalar @lineChars; $i++) {
      if ($lineChars[$i] ne $secChars[$i]) {
	next SECLINE if ($foundDiff > 0);
	$foundDiff++;
      }
    }
    print "I think that $line is similar to $secondLine\n";
  }
}

