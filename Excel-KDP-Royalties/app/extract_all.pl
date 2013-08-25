#!/usr/bin/env perl

use lib qw(../lib lib);

use  Excel::KDP::Royalties;

my $dir = shift || "."; 

my @files = glob("$dir/kdp-report*.xls");

my $royalties = new Excel::KDP::Royalties $files[0];
my $csv = $royalties->to_csv( 1 ); #with header
for ( my $f = 1; $f <= $#files;  $f++) {
  $royalties = new Excel::KDP::Royalties $files[$f];
  $csv .= $royalties->to_csv;
}
 print $csv;
