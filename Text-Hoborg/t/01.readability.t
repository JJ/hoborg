use lib qw( ../lib ); # -*- cperl -*- 

use strict;
use warnings; 

use Test::More;
use Lingua::EN::Fathom;
use Text::Hoborg;

diag( "Testing Text::Hoborg $Text::Hoborg::VERSION" );

# You can use relative or absolute paths.
my $text = new Lingua::EN::Fathom;

my $hoborg = new Text::Hoborg;
$text->analyse_file($hoborg->text_file);
my $fog = $text->fog;
my $kincaid = $text->kincaid;
my $flesch = $text->flesch;

diag( "Fog = $fog\nKincaid = $kincaid\nFlesch = $flesch\n");
cmp_ok( $fog, ">", 6, "Fog value $fog better than 6" );
cmp_ok( $fog, "<", 14, "Fog value $fog lower than 14" );
cmp_ok( $kincaid, ">", 6, "Kincaid value $kincaid better than 6" );
cmp_ok( $kincaid, "<", 9, "Kincaid value $kincaid better than 9" );
cmp_ok( $flesch, ">", 60, "Flesch better $flesch better than 60" );
cmp_ok( $flesch, "<", 80, "Flesch better $flesch better than 80" );

done_testing();

