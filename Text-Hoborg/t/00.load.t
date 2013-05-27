use lib qw( ../lib );

use Test::More;
use File::Slurp 'read_file';

use Text::Hunspell;

BEGIN {
use_ok( 'Text::Hoborg' );
}

diag( "Testing Text::Hoborg $Text::Hoborg::VERSION" );

# You can use relative or absolute paths.
my $speller = Text::Hunspell->new(
				  "/usr/share/hunspell/en_US.aff",    # Hunspell affix file
				  "/usr/share/hunspell/en_US.dic"     # Hunspell dictionary file
				 );

my $dir = -d "../text" ? "../text": "../../text";
$speller->add_dic("$dir/words.dic");

my $text_file = "$dir/text.md";
my $text = read_file($text_file);

my @words = split /\s+/, $text;

for my $w (@words) {
  my ($stripped_word) = ( $w =~ /([\w\'áéíóúÁÉÍÓÚñÑ]+)/ );
  ok( $speller->check( $stripped_word), "$stripped_word OK")   if ( $stripped_word ) ;
}
done_testing();

