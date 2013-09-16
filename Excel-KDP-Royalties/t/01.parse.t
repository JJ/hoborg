
use lib qw(../lib lib);

use Test::More;

use  Excel::KDP::Royalties;

my $test_file = 'kdp-report-7-2013.xls';
my $another_test_file = 'kdp-report-9-2012.xls';
my $and_another_test_file = 'kdp-report-8-2013.xls';

if (! -e $test_file ) {
  $test_file = "t/$test_file";
  $another_test_file = "t/$another_test_file";
  $and_another_test_file = "t/$and_another_test_file";
}

my $royalties = new Excel::KDP::Royalties $test_file;

is( $royalties->unit_sales('Amazon.com.br'), 0, "No sales");
is( $royalties->unit_sales('Amazon.es'), 418, "Sales in amazon.es");
is( $royalties->unit_sales(), 464, "Total sales ");

is( $royalties->sales_by_product("B00CLOF224"), 215, "Sales HLN" );
is( $royalties->sales_by_product("ABCD"), 0, "Sales non-product" );

$royalties = new Excel::KDP::Royalties $another_test_file;
is( $royalties->unit_sales('Amazon.co.uk'), 2, "Sales in amazon.co.uk");

$royalties = new Excel::KDP::Royalties $and_another_test_file;
is( $royalties->unit_sales('Amazon IN'), 3, "Sales in amazon IN");

done_testing()
