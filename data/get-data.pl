#!/usr/bin/env perl

use strict;
use warnings;

use File::Slurp qw(read_file);
use v5.14;

my @logs = glob("log*.log");

my @data;
my @tests;
for my $l ( @logs ) {
  my ($number) = ( $l =~ /(\d+)/);
  my $file_content = read_file ($l );
  if ( $file_content =~ /Tests=(\d+)/ ) {
    $tests[$number] = $1;
    my ($fog, $kincaid, $flesch) = ( $file_content =~ /Fog = (\d+\.\d+).+Kincaid = (\d+\.\d+).+Flesch = (\d+\.\d+)/s);
    $data[$number] = [$fog, $kincaid, $flesch];
  }
}


say ",Tests,Fog,Kincaid,Flesch";
for (my $i = 0; $i <=$#tests; $i ++ ) {
  if ( $tests[$i] and $data[$i][0]) {
    say $tests[$i], ",",join(",",@{$data[$i]});
  }
}
  
