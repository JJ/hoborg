#!/usr/bin/env perl

use strict;
use warnings;

use v5.20;

use JSON;
use Git;
use File::Slurp::Tiny qw(write_file);

my $status = `travis show`;

my ($num_builds) = ($status =~ /Build\s+\#(\d+)/s);

my %commits;
for my $i (1..$num_builds) {
  my $this_status = `travis show $i`;
  my ($state,$commit) = ($this_status =~ /State:\s+(\w+).+\.\.\.(\w+)/s);
  if ( $state ne 'errored' ) {
    $commits{$i} = $commit;
  }
}

for my $c ( sort {$a <=> $b } %commits ) {
  say "$c $commits{$c}";
}

