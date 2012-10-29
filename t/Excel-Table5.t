#!/usr/bin/perl
#
# Excel-Table5.t - test harness for Excel::Table object.
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published
# by the Free Software Foundation; either version 2 of the License,
# or any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
#
#
# History:
# $Log: Excel-Table5.t,v $
# Revision 1.2  2012/10/23 19:54:34  tomby
# removed Logfer references.
#
# Revision 1.1  2012/10/23 19:51:08  tomby
# Initial revision
#
=head1 NAME

Excel-Table5.t - test harness for Excel::Table object.

=head1 SYNOPSIS

perl Excel-Table5.t
[-h, --help]
[-m, --manual]

=head1 OPTIONS

=over 8

=item B<--help>

Prints a brief help message and exits.

=item B<--manual>

Prints the manual page and exits.

=back

=cut

use strict;

use Data::Dumper;

# ---- logging ---- 
use Log::Log4perl qw/ :easy /;
Log::Log4perl->easy_init($ERROR);

my $log = get_logger(__FILE__);

# ---- globals ---- 
my $c_this = 'Excel::Table';
my $c_wbook = 'Spreadsheet::ParseExcel::Workbook';
my @s_books = qw/ Excel-Table0.xls Excel-Table1.xlsx /;
my $s_sheet = 'Sheet1';


# ---- tests begin here ----
use Test::More tests => 43;
my $cycle = 0;
my $xt;

BEGIN { use_ok('Excel::Table') };

for my $s_book (@s_books) {

	my $xt = Excel::Table->new('trim' => 1);

	isa_ok( $xt, $c_this,			"new cycle $cycle");
	isa_ok( $xt->open($s_book), $c_wbook,	"open cycle $cycle");

	my @d_hash = $xt->extract_hash($s_sheet);

	is( scalar(@d_hash), 10,	"x hash rowcount");

	ok( exists($d_hash[0]->{'title_0_0'}),	"x hash first title");
	ok( exists($d_hash[0]->{'title_0_9'}),	"x hash last title");
	ok( exists($d_hash[0]->{'dup_title0'}),	"x hash dup title");

	is( $d_hash[0]->{'title_0_1'}, 'row_0_1',	"x value check a");
	is( $d_hash[0]->{'dup_title'}, 'row_0_5',	"x value check b");
	is( $d_hash[0]->{'dup_title0'}, 'row_0_6',	"x value check c");
	is( $d_hash[1]->{'dup_title0'}, 'row_1_6',	"x value check d");
	is( $d_hash[9]->{'dup_title0'}, 'lastrow_09_06',	"x value check e");

	@d_hash = $xt->select_hash($s_sheet, "title_0_2,dup_title");

	is( scalar(@d_hash), 10,	"s hash rowcount");

	ok( exists($d_hash[0]->{'title_0_2'}),	"s hash first title");
	ok( exists($d_hash[0]->{'dup_title'}),	"s hash second title");

	# cannot retrieve a duplicate title via a select; only one match
	ok( ! exists($d_hash[0]->{'dup_title0'}),	"s no dup title");

	is( $d_hash[0]->{'title_0_2'}, 'row_0_2',	"s value check a");
	is( $d_hash[0]->{'dup_title'}, 'row_0_5',	"s value check b");
	is( $d_hash[1]->{'title_0_2'}, 'row_1_2',	"s value check c");
	is( $d_hash[1]->{'dup_title'}, 'row_1_5',	"s value check c");
	is( $d_hash[9]->{'title_0_2'}, 'lastrow_09_02a',	"s value check d");
	is( $d_hash[9]->{'dup_title'}, 'lastrow_09_05',	"s value check d");

	$log->debug(sprintf '@d_hash [%s]', Dumper(\@d_hash));

	$xt = ();
	$cycle++;
}

__END__

=head1 DESCRIPTION

Test harness for the B<Excel::Table.pm> class.
Hash extraction and select.

=head1 VERSION

$Revision: 1.2 $

=head1 AUTHOR

Copyright (C) 2012  B<Tom McMeekin> tmcmeeki@cpan.org

This code is distributed under the same terms as Perl.

=head1 SEE ALSO

L<perl>.

=cut

