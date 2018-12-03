#!/usr/bin/perl -w

use strict;

my $filename = "1_input.txt";

my @changes;

my $result = 0;

my %hash;

open (my $FILE, "<", $filename) or die "Can't open $filename\n";
chomp(@changes = <$FILE>);
close $FILE;

while (1) {
        print "Starting list\n";
	foreach my $change (@changes) {
		$result += $change;
		if (defined $hash{$result}) {
			print "Found at $result\n";
			exit;
		}
		print "Result is $result\n";
		$hash{$result} = 1;
	}
}

