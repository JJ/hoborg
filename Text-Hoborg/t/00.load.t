use lib qw( ../lib ); # -*- cperl -*- 

use Test::More;
use File::Slurp 'read_file';

use Text::Hunspell;

BEGIN {
use_ok( 'Text::Hoborg' );
}

my $dict_dir;

if ( -e "/usr/share/hunspell/en_US.aff" ) {
  $dict_dir =  "/usr/share/hunspell";
} elsif  ( -e "data/en_US.aff" ) {
  $dict_dir = "data";
} else {
  $dict_dir = "../data";
}

# You can use relative or absolute paths.
my $speller = Text::Hunspell->new(
				  "$dict_dir/en_US.aff",    # Hunspell affix file
				  "$dict_dir/en_US.dic"     # Hunspell dictionary file
				 );
die unless $speller;

my $hoborg = new Text::Hoborg;
my $dir = $hoborg->dir();

diag( "Testing Text::Hoborg $Text::Hoborg::VERSION in $dir" );

$speller->add_dic("$dir/words.dic");

my @words = split /\s+/, $hoborg->text;

for my $w (@words) {
  my ($stripped_word) = ( $w =~ /([\w\'áéíóúÁÉÍÓÚñÑ]+)/ );
  ok( $speller->check( $stripped_word), "Checking $stripped_word in text")   if ( $stripped_word ) ;
}

for my $a (keys %{$hoborg->appendices()}) {
  @words = split /\s+/, $hoborg->appendices()->{$a};
  for my $w (@words) {
    ($stripped_word) = ( $w =~ /([\w\'áéíóúÁÉÍÓÚñÑ]+)/ );
    ok( $speller->check( $stripped_word), "Checking $stripped_word in $a") if ( $stripped_word ) ;
  }
}

done_testing();

