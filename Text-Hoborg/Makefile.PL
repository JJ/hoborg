use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'Text::Hoborg',
    AUTHOR              => 'JJ Merelo <jj@merelo.net>',
    VERSION_FROM        => 'lib/Text/Hoborg.pm',
    ABSTRACT_FROM       => 'lib/Text/Hoborg.pm',
    PL_FILES            => {},
    PREREQ_PM => {
        'Test::More' => 0,
        'version'    => 0,
	'File::Slurp' => 0,
	'Text::Hunspell' => 2.08,
	'Lingua::EN::Fathom' => 0.250
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'Text-Hoborg-*' },
);
