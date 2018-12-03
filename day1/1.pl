#!/usr/bin/perl -w

use strict;

my $filename = "1_input.txt";

my @changes;

my $result = 0;

open (my $FILE, "<", $filename) or die "Can't open $filename\n";
chomp(my @changes = <$FILE>);
close $FILE;

foreach my $change (@changes) {
  print "Change is $change\n";
  $result += $change;
}

print "Result is $result\n";
