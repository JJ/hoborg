package Excel::KDP::Royalties;

use warnings;
use strict;
use Carp;

use version; our $VERSION = qv('0.0.3');

# Other recommended modules (uncomment to use):
#  use IO::Prompt;
#  use Perl6::Export;
#  use Perl6::Slurp;
#  use Perl6::Say;

use Spreadsheet::ParseExcel;


our @columns_13 = qw( title author ASIN transaction sales returned sold_or_lent lending_rate avg_list_price avg_sale_price file_size shipping royalties );
our @columns_12 = qw( title ASIN transaction sales returned sold_or_lent lending_rate avg_list_price avg_sale_price file_size shipping royalties );

# Module implementation here

sub new {
  my $class = shift;
  my $file_name = shift || croak "No file name";
  my $parser = Spreadsheet::ParseExcel->new();
  my $sheet = $parser->parse($file_name);
  my ($month,$year ) = ( $file_name =~ /report-(\d+)-(\d+).xls/);
  if ( !defined $sheet ) {
    croak $parser->error(), ".\n";
  }
  my $self = { _sheet => $sheet,
	       _month => $month,
	       _year => $year};
  bless $self, $class;
  
  $self->_process(); #Process sheet 
  return $self;
}

sub _process {
  my $self = shift;
  my $sheet = $self->{'_sheet'}->worksheet(0); # single sheet
  my ($row_min, $row_max) = $sheet->row_range();
  my ($col_min, $col_max) = $sheet->col_range();
  if ( $col_max == 12 ) {
    $self->{'_columns'} = \@columns_13;
  } else {
    $self->{'_columns'} = \@columns_12;
  }

  my @shops;
  my $shop_index = 0;
  my $empty_row = 0;
  my @columns = @{$self->{'_columns'}};
  for (my $r  = $row_min; $r <= $row_max; $r++) {

    my $first_cell_value = $sheet->get_cell( $r, 0 );
    if ( !$first_cell_value ) {
      if ( $empty_row ) { #previous row is empty
	$empty_row = 0;
	$shop_index++;
      } else {
	$empty_row = 1;
      }
    } else {
      $empty_row = 0;
      my @column_data;
      for (my $c = $col_min; $c <= $col_max; $c++) {
	push @column_data, $sheet->get_cell($r, $c );
      }
      push @{$shops[$shop_index]}, \@column_data;
    }
  }
  
  $self->{'_shops'} = \@shops;

  #Now process shop data
  my @data;
  for my $s (@shops ) {
    if ( $s->[3][1] ) { #Some sales
      my ($shop ) = ( $s->[2][0]->value() =~ /(Amazon\.\S+)/ );
      for (my $r = 3; $r < @$s -1 ; $r++ ) {
	my $month_sales = { shop => $shop,
			    month => $self->{'_month'},
			    year => $self->{'_year'}};
	for (my $c = $col_min; $c <=$col_max; $c ++ ) {
	  $month_sales->{$columns[$c]} = $s->[$r][$c]->value();
	}
	push @data, $month_sales;
      }
    }
  }
  $self->{'_data'} = \@data;
}

sub unit_sales {
  my $self = shift;
  my $shop = shift;

  my $sales = 0;
  for my $d (@{$self->{'_data'}}  ) {
    if ( $shop ) {
      next if $shop ne $d->{'shop'};
    }
    $sales += $d->{'sold_or_lent'};

  }
  return $sales;
}

sub sales_by_product {
  my $self = shift;
  my $ASIN = shift || croak "Need a product ASIN"; 

  my $sales = 0;
  for my $d (@{$self->{'_data'}}  ) {
    if ( $ASIN ) {
      next if $ASIN ne $d->{'ASIN'};
    }
    $sales += $d->{'sold_or_lent'};

  }
  return $sales;
}

sub to_csv {
  my $self = shift;
  my $header = shift;
  my @columns = ( 'shop', 'year', 'month', @columns_13 );
  my $csv;
  if ( $header ) {
    $csv .= join(";", @columns )."\n";
  }
  for my $d ( @{$self->{'_data'}} ) {
    my @row;
    for ( my $c = 0; $c < $#columns; $c++ ) {
      if ( $d->{$columns[$c]} ) {
	$csv .= $d->{$columns[$c]}.";";
      } else {
	$csv .=";";
      }
    }
    $csv .= $d->{$columns[$#columns]}."\n";
  }
  return $csv;
}

1; # Magic true value required at end of module
__END__

=head1 NAME

Excel::KDP::Royalties - Parses KDP royalties file and aggregates stuff.


=head1 VERSION

This document describes Excel::KDP::Royalties version 0.0.1


=head1 SYNOPSIS

    use Excel::KDP::Royalties;

=for author to fill in:
    Brief code example(s) here showing commonest usage(s).
    This section will be as far as many users bother reading
    so make it as educational and exeplary as possible.
  
  
=head1 DESCRIPTION

=for author to fill in:
    Write a full description of the module and its features here.
    Use subsections (=head2, =head3) as appropriate.


=head1 INTERFACE 

=head2 new( $file_name )

Reads a single Excel file from KDP.

=head2 _process( )

Process the file into a number of sales data per shop

=head1 DIAGNOSTICS

=for author to fill in:
    List every single error and warning message that the module can
    generate (even the ones that will "never happen"), with a full
    explanation of each problem, one or more likely causes, and any
    suggested remedies.

=over

=item C<< Error message here, perhaps with %s placeholders >>

[Description of error here]

=item C<< Another error message here >>

[Description of error here]

[Et cetera, et cetera]

=back


=head1 CONFIGURATION AND ENVIRONMENT

=for author to fill in:
    A full explanation of any configuration system(s) used by the
    module, including the names and locations of any configuration
    files, and the meaning of any environment variables or properties
    that can be set. These descriptions must also include details of any
    configuration language used.
  
Excel::KDP::Royalties requires no configuration files or environment variables.


=head1 DEPENDENCIES

=for author to fill in:
    A list of all the other modules that this module relies upon,
    including any restrictions on versions, and an indication whether
    the module is part of the standard Perl distribution, part of the
    module's distribution, or must be installed separately. ]

None.


=head1 INCOMPATIBILITIES

=for author to fill in:
    A list of any modules that this module cannot be used in conjunction
    with. This may be due to name conflicts in the interface, or
    competition for system or program resources, or due to internal
    limitations of Perl (for example, many modules that use source code
    filters are mutually incompatible).

None reported.


=head1 BUGS AND LIMITATIONS

=for author to fill in:
    A list of known problems with the module, together with some
    indication Whether they are likely to be fixed in an upcoming
    release. Also a list of restrictions on the features the module
    does provide: data types that cannot be handled, performance issues
    and the circumstances in which they may arise, practical
    limitations on the size of data sets, special cases that are not
    (yet) handled, etc.

No bugs have been reported.

Please report any bugs or feature requests to
C<bug-excel-kdp-royalties@rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org>.


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
