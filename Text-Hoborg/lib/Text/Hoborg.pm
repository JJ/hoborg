package Text::Hoborg;

use warnings;
use strict;
use Carp;
use File::Slurp 'read_file';

use version; our $VERSION = qv('0.0.4');

our @appendices = qw(characters.md geography.md); #auxiliary and additional files

# Module implementation here
sub new {
  my $class = shift;
  my $dir = shift;
  if ( ! $dir ) {
      $dir = -d "../text" ? "../text": "../../text";
      $dir = -d $dir ? $dir : "t";
  }
  my $text_file = "$dir/text.md";
  my $text = read_file($text_file);
  my $self = { 
      _dir => $dir,
      _text => $text,
      _text_file => $text_file,
      _appendices => {} 
  };
  for my $a (@appendices ) {
      $text_file = "$dir/$a";
      $text = read_file($text_file);
      $self->{'_appendices'}{$a} = $text;
  }
  bless  $self, $class;
  return $self;
}

sub dir {
    my $self = shift;
    return $self->{'_dir'};
}

sub text {
  my $self = shift;
  return $self->{'_text'};
}

sub text_file {
  my $self = shift;
  return $self->{'_text_file'};
}

sub appendices {
    my $self = shift;
    return $self->{'_appendices'};
}


"All over, all out, all over and out"; # Magic circus phrase

__END__

=head1 NAME

Text::Hoborg - Just a placeholder for spell checking. Might have more stuff


=head1 VERSION

This document describes Text::Hoborg version 0.0.1


=head1 SYNOPSIS

    use Text::Hoborg;
    
=head1 DESCRIPTION

This module loads the novel so that transformation can be done on
it. It should know where the text is placed. 

=head1 INTERFACE

=head2 new [$dir]

Creates an object with the novel text inside

=head2 text 

Returns the text in original format

=head2 text_file

Returns the name of the text file




=head1 DEPENDENCIES

Text::Hoborg requires L<Text::Hunspell>. And the Hoborg novel L<http://jj.github.io/hoborg> should be somewhere

=head1 AUTHOR

JJ Merelo  C<< <jj@merelo.net> >>


=head1 LICENCE AND COPYRIGHT

Copyright (c) 2013, JJ Merelo C<< <jj@merelo.net> >>. All rights reserved.

This module is free software; you can redistribute it and/or
modify it under the same terms as Perl itself. See L<perlartistic>.


=head1 DISCLAIMER OF WARRANTY

BECAUSE THIS SOFTWARE IS LICENSED FREE OF CHARGE, THERE IS NO WARRANTY
FOR THE SOFTWARE, TO THE EXTENT PERMITTED BY APPLICABLE LAW. EXCEPT WHEN
OTHERWISE STATED IN WRITING THE COPYRIGHT HOLDERS AND/OR OTHER PARTIES
PROVIDE THE SOFTWARE "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER
EXPRESSED OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE. THE
ENTIRE RISK AS TO THE QUALITY AND PERFORMANCE OF THE SOFTWARE IS WITH
YOU. SHOULD THE SOFTWARE PROVE DEFECTIVE, YOU ASSUME THE COST OF ALL
NECESSARY SERVICING, REPAIR, OR CORRECTION.

IN NO EVENT UNLESS REQUIRED BY APPLICABLE LAW OR AGREED TO IN WRITING
WILL ANY COPYRIGHT HOLDER, OR ANY OTHER PARTY WHO MAY MODIFY AND/OR
REDISTRIBUTE THE SOFTWARE AS PERMITTED BY THE ABOVE LICENCE, BE
LIABLE TO YOU FOR DAMAGES, INCLUDING ANY GENERAL, SPECIAL, INCIDENTAL,
OR CONSEQUENTIAL DAMAGES ARISING OUT OF THE USE OR INABILITY TO USE
THE SOFTWARE (INCLUDING BUT NOT LIMITED TO LOSS OF DATA OR DATA BEING
RENDERED INACCURATE OR LOSSES SUSTAINED BY YOU OR THIRD PARTIES OR A
FAILURE OF THE SOFTWARE TO OPERATE WITH ANY OTHER SOFTWARE), EVEN IF
SUCH HOLDER OR OTHER PARTY HAS BEEN ADVISED OF THE POSSIBILITY OF
SUCH DAMAGES.
