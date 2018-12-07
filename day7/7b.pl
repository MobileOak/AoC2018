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

my $lastWorker = "E";
my $taskTime = 61;

foreach my $key (sort keys %deps) {
  print "$key(" . (ord($key) - ord('A') + $taskTime) . ") depends on ";
  foreach my $letter (@{$deps{ $key }}) {
    print " $letter,";
  }
  print "\n";
}

my $ret = "";

my %workerTimes;
my %workerTasks;

$workerTimes{ "A" } = 0;
$workerTimes{ "B" } = 0;
$workerTimes{ "C" } = 0;
$workerTimes{ "D" } = 0;
$workerTimes{ "E" } = 0;
$workerTasks{ "A" } = "";
$workerTasks{ "B" } = "";
$workerTasks{ "C" } = "";
$workerTasks{ "D" } = "";
$workerTasks{ "E" } = "";

my $tick = 0;

while(%deps) {
  print "Tick $tick\n";
  $tick++;
  for my $worker ('A' .. $lastWorker) {
    if ($workerTimes{ $worker } > 0) {
      $workerTimes{$worker} = $workerTimes{$worker} - 1;
      print "Reducing worker $worker task of " . $workerTasks{$worker} . " to " . $workerTimes{$worker} . "\n";
      if ($workerTimes{ $worker } == 0) {
	my $task = $workerTasks{ $worker };
        print "Work is done on $task.\n";
        $workerTasks{ $worker } = "";
	$ret .= $task;
	delete($deps{$task});
      }
    }
    if ($workerTimes{ $worker } == 0) {
      print "$worker is ready for work: ";
      my $nextTask = getNextTask();
      if ($nextTask ne "") {
	$workerTasks{$worker} = $nextTask;
	$workerTimes{$worker} = (ord($nextTask) - ord('A') + $taskTime);
	print "Assigning $nextTask to $worker with time of " . $workerTimes{$worker} . "\n";
      } else {
        print "No work to assign\n";
      }
    }
  }
}

my $jobsNotDone = 1;
while($jobsNotDone) {
  print "Tick $tick\n";
  $tick++;
  for my $worker ('A' .. $lastWorker) {
    if ($workerTimes{ $worker } > 0) {
      $workerTimes{$worker} = $workerTimes{$worker} - 1;
      print "Reducing worker $worker task of " . $workerTasks{$worker} . " to " . $workerTimes{$worker} . "\n";
      if ($workerTimes{ $worker } == 0) {
	my $task = $workerTasks{ $worker };
        print "Work is done on $task\n";
        $workerTasks{ $worker } = "";
	$ret .= $task;
	delete($deps{$task});
      }
    }
  }
  my $finishedAllWork = 1;
  for my $worker ('A' .. $lastWorker) {
    if ($workerTasks{$worker} ne "") {
      $finishedAllWork = 0;
    }
  }
  if ($finishedAllWork) {
    $jobsNotDone = 0;
  }

}

$tick--;
print "Final tick is $tick\n";


sub getNextTask {
  foreach my $key (sort keys %deps) {
    my @dependsList = @{$deps{$key}};
    my $allDone = 1;
    foreach my $item (@dependsList) {
      if(defined ($deps{$item})) {
	$allDone = 0;
      }
      foreach my $inProgress (keys %workerTasks) {
        my $workTask = $workerTasks{$inProgress};
        if($item eq $workTask) {
          $allDone = 0;
        }
      }
    }
    if ($allDone) {
      delete($deps { $key });
      return $key;
    }
  }
  return "";
}

print "Answer: $ret\n";
