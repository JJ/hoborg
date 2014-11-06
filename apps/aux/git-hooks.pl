#!/usr/bin/env perl

use strict;
use warnings;
use v5.14;
use Git::Hooks;

POST_COMMIT {
  my ($git) = @_;
  my $branch =  $git->command(qw/rev-parse --abbrev-ref HEAD/);
  if ( $branch =~ /master/ ) {
      if ( $git->command(qw/show --name-status/) =~ /testeando.ad/ ) {
	  #Now change branch and process
	  #Inspired by http://stackoverflow.com/questions/15214762/how-can-i-sync-documentation-with-github-pages
	  $git->command(qw/checkout gh-pages/);
	  $git->command( 'checkout', 'master', '--', 'testeando.ad' );
	  `asciidoc --backend deckjs testeando.ad -o index.html`;
	  $git->command('commit','-a', '-m', "Generando diapos en gh-pages");
      }
      $git->command(qw/checkout master/); #back to original
  }
};

run_hook($0, @ARGV);

=head1 NAME

git-hooks.pl - Genera diapos en otra rama. 

=head2 SYNOPSIS

First you need to install C<Git::Hooks> and C<File::Slurp>. I use say,
so you will need perl > 5.10. Besides, you need to locate Git.pm and
copy it where the file can find it. That depends on the OS and perl
installation you're using (I use perlbrew), In my case it was:

  bash% cp /usr/share/perl5/Git.pm ~/perl5/perlbrew/perls/perl-5.16.1/lib/site_perl/5.16.1/

Then copy git-hooks.pl to .git/hooks, make it runnable (chmod +x
    git-hooks) and then

  bash% ln -s git-hooks.pl post-commit

Any trouble, just check the L<Git::Hooks> manual.

=head2 DESCRIPTION

Inpired by
L<http://stackoverflow.com/questions/15214762/how-can-i-sync-documentation-with-github-pages>
this answer by Cory Gross in StackOverflow, the ever helpful site. It
was adapted to Perl instead of bash.

Besides including Jekyll YAML headers in the files, it eliminates
C<.md> suffixes to convert them to the correct URL in Github Pages. 

=head1 LICENSE

This is released under the Artistic 
License. See L<perlartistic>.

=head2 AUTHOR

JJ Merelo, L<jj@merelo.net>
