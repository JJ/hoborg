#!/usr/bin/env perl

use strict;
use warnings;

use File::Slurp qw(read_file);

#Eliminates all revision and write marks from the text.

my @marks = ( "write", "revise and write", "revise");

my $file_name = shift || "text/text.md";

my $text = read_file( $file_name ) ;

die "Can't open file $file_name" if $!;

for my $m (@marks) {
    $text =~ s/\*$m\*//g;
}

print $text;
