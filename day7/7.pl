#!/usr/bin/perl -w

use strict;

my $filename = "input2.txt";

my @inputLines;

open (my $FILE, "<", $filename) or die "Can't open $filename\n";
chomp(@inputLines = <$FILE>);
close $FILE;

my %deps;

foreach my $condition (@inputLines) {
  my @split = split(/ /, $condition);
  my $depends = $split[0];
  my $base = $split[1];

  if (defined $deps{ $base }) {
    push( @{ $deps{ $base }}, $depends);
  } else {
    $deps{ $base } = [ $depends ];
  }
  if (!defined $deps{ $depends }) {
    $deps{ $depends } = [ ];
  }
}

foreach my $key (keys %deps) {
  foreach my $letter (@{$deps{ $key }}) {
    print " $letter,";
  }
  print "\n";
}

my $ret = "";

while(keys %deps) {
  my $added = 0;
  foreach my $key (sort keys %deps) {
    if (!$added) {
      my @dependsList = @{$deps{$key}};
      my $allDone = 1;
      foreach my $item (@dependsList) {
	if(defined ($deps{$item})) {
	  $allDone = 0;
	}
      }
      if ($allDone) {
	$ret .= $key;
        $added = 1;
	delete($deps { $key });
      }
    }
  }
}

print "Answer: $ret\n";
