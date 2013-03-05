#!perl -T

use Test::More tests => 1;

BEGIN {
    use_ok( 'WebService::Desk' ) || print "Bail out!\n";
}

diag( "Testing WebService::Desk $WebService::Desk::VERSION, Perl $], $^X" );
