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

my @minutesGuards;
my $maxMinutes = 0;
my $maxMinuteValue = -1;
my $maxGuard;

foreach my $line (@inputLines) {
  my @bits = split(/ /, $line);
  my $date = $bits[0];
  my $timeBlock = $bits[1];
  my $log = $bits[2];

  my @times = split(/:/, $timeBlock);

  if ($log eq "w") {
    print "Guard $currentGuard started sleeping at $startedSleepMinute and ended at " . $times[1] . "\n";
    for (my $i = $startedSleepMinute; $i < $times[1]; $i++) {
      if (defined $minutesGuards[$i][$currentGuard]) {
        $minutesGuards[$i][$currentGuard]++;
      } else {
        $minutesGuards[$i][$currentGuard] = 1;
      }
      print "value is " . $minutesGuards[$i][$currentGuard] . " for $i and max is $maxMinutes\n";
      if ($minutesGuards[$i][$currentGuard] > $maxMinutes) {
        print "It's greater so setting max minutes\n";
        $maxMinutes = $minutesGuards[$i][$currentGuard];
        $maxGuard = $currentGuard;
        $maxMinuteValue = $i;
      }
    }
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

print "Guard is $maxGuard and minute is $maxMinuteValue. Multiplied = " . ($maxGuard * $maxMinuteValue) . "\n";

