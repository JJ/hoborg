#!perl

use v5.14;
use Markdown::Pod ;
use File::Slurp 'read_file';

my $text_file = shift || "../../text/text.md";


my $text = read_file($text_file);

 my $m2p = Markdown::Pod->new;
my $pod = $m2p->markdown_to_pod(
    markdown => $text,
    );

say $pod;


=head1 NAME

to_pod.pl - convert from markdown to POD 

=head2 SYNOPSIS

First you need to install C<Markdown::Pod> and C<File::Slurp>. I use say, so you will need perl > 5.10.

Default usage
    % perl to_pod.pl 

Change source file
    % perl to_pod.pl my_file.md
    
=head1 LICENSE

This is released under the Artistic 
License. See L<perlartistic>.

=head2 AUTHOR

JJ Merelo, L<jj@merelo.net>

