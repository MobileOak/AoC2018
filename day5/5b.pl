#!/usr/bin/perl -w

use strict;

my $filename = "input.txt";

my @inputLines;

open (my $FILE, "<", $filename) or die "Can't open $filename\n";
chomp(@inputLines= <$FILE>);
close $FILE;

for my $remove ('a' .. 'z') {
  my $line = $inputLines[0];

  $line =~ s/$remove//g;
  my $ucRemove = uc($remove);
  $line =~ s/$ucRemove//g;

  for(my $i = 0; $i < length($line) - 1; $i++) {
    my $char = substr($line, $i, 1);
    my $nextChar = substr($line, $i+1, 1);
    if ((uc($char) eq $nextChar && uc($char) ne $char) ||
	(lc($char) eq $nextChar && lc($char) ne $char)) {
      # need to remove 
      my $beforeLength = $i;
      my $afterLength = length($line) - ($i + 1);
      $afterLength = 0 if $afterLength < 0;
      if($beforeLength > 0 && $afterLength > 0) {
	$line = substr($line, 0, $beforeLength) . substr($line, $i+2, $afterLength);
      } else {
	$line = substr($line, $i+2, $afterLength);
      }
      $i -= 2;
      $i = -1 if $i < 0;
    }
  }

  print "For $remove, the answer is " . length($line) . "\n";

}

