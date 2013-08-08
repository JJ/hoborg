#!perl

use v5.14;
use Text::Markdown 'markdown';
use File::Slurp 'read_file';

my $text_file = shift || "../../text/text.md";
my $header_file = shift || "../../resources/header.html";

my $text = read_file($text_file);
my $header = read_file( $header_file);
if ( $text && $header ) {
  my $html = $header.(markdown($text))."\n\t</body>\n</html>";
  say $html;
} else {
  die "Something went wrong, either no $text_file or no $header_file";
}

=head1 NAME

convert.pl - convert from markdown to HTML adding my own headers

=head2 SYNOPSIS

First you need to install C<Text::Markdown> and C<File::Slurp>. I use say, so you will need perl > 5.10.

Default usage
    % perl convert.pl 

Change source file
    % perl convert.pl my_file.md

Change source and header file
    % perl convert.pl this_file.md my_header.html
    
=head1 LICENSE

This is released under the Artistic 
License. See L<perlartistic>.

=head2 AUTHOR

JJ Merelo, L<jj@merelo.net>

