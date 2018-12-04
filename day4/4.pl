#!/usr/bin/perl -w

use strict;

my $filename = "4_sorted.txt";

my @inputLines;

open (my $FILE, "<", $filename) or die "Can't open $filename\n";
chomp(@inputLines= <$FILE>);
close $FILE;

my %guardsMinutes;

my $currentGuard;
my $sleepingMinutes = 0;
my $startedSleepMinute;

foreach my $line (@inputLines) {
  my @bits = split(/ /, $line);
  my $date = $bits[0];
  my $timeBlock = $bits[1];
  my $log = $bits[2];

  my @times = split(/:/, $timeBlock);

  if ($log eq "w") {
    print "Guard $currentGuard started sleeping at $startedSleepMinute and ended at " . $times[1] . "\n";
    $sleepingMinutes += $times[1] - $startedSleepMinute;
  } elsif ($log eq "s") {
    $startedSleepMinute = $times[1];
  } else {
    if( defined $currentGuard ) {
      $guardsMinutes{ $currentGuard } += $sleepingMinutes;
    }
    $currentGuard = $log;
    $sleepingMinutes = 0;
  }  
}

my $max = 0;
my $maxGuard;
foreach my $guard (keys %guardsMinutes) {
  if ($guardsMinutes{ $guard } > $max) {
    $max = $guardsMinutes{ $guard };
    $maxGuard = $guard;
  }
}

print "Guard #$maxGuard had the most sleeping minutes at $max\n";

my %mostMinutesHash;

foreach my $line (@inputLines) {
  my @bits = split(/ /, $line);
  my $date = $bits[0];
  my $timeBlock = $bits[1];
  my $log = $bits[2];

  my @times = split(/:/, $timeBlock);

  if ($log eq "w") {
    if ($currentGuard eq $maxGuard) {
      for(my $i = $startedSleepMinute; $i < $times[1]; $i++) {
        if (defined $mostMinutesHash{ $i }) {
	  $mostMinutesHash{ $i } += 1;
        } else {
          $mostMinutesHash{ $i } = 1;
        }
      }
    }
  } elsif ($log eq "s") {
    $startedSleepMinute = $times[1];
  } else {
    $currentGuard = $log;
    $sleepingMinutes = 0;
  }  
}

$max = 0;
my $result = -1;
foreach my $minute (keys %mostMinutesHash) {
  if ($mostMinutesHash{ $minute } > $max) {
    $max = $mostMinutesHash{ $minute };
    $result = $minute;
  }
}

print "Result is $maxGuard * $result = " . ($maxGuard * $result) . "\n";
