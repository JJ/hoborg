
use lib qw(../lib lib);

use Test::More;

use  Excel::KDP::Royalties;

my $test_file = 'kdp-report-7-2013.xls';

if (! -e $test_file ) {
  $test_file = "t/$test_file";
}

my $royalties = new Excel::KDP::Royalties $test_file;

is( $royalties->unit_sales('Amazon.com.br'), 0, "No sales");
is( $royalties->unit_sales('Amazon.es'), 416, "Sales in amazon.es");
is( $royalties->unit_sales(), 457, "Total sales ");

is( $royalties->sales_by_product("B00CLOF224"), 212, "Sales HLN" );
is( $royalties->sales_by_product("ABCD"), 0, "Sales non-product" );

done_testing()
