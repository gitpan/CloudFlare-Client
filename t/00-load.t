#!perl -T
use 5.006;
use strict;
use warnings FATAL => 'all';
use Test::More;

plan tests => 4;

BEGIN {
    use_ok( 'CloudFlare::Client' )
	|| print "Bail out!\n";
    use_ok( 'CloudFlare::Client::Types' )
	|| print "Bail out!\n";
    use_ok( 'CloudFlare::Client::Exception::Upstream' )
	|| print "Bail out!\n";
    use_ok( 'CloudFlare::Client::Exception::Connection' )
	|| print "Bail out!\n";
}

diag( "Testing CloudFlare::Client $CloudFlare::Client::VERSION," .
      " Perl $], $^X" );
diag( "Testing CloudFlare::Client::Types" .
      " $CloudFlare::Client::Types::VERSION, Perl $], $^X" );
diag( "Testing CloudFlare::Client::Exception::Upstream" .
      " $CloudFlare::Client::Exception::Upstream::VERSION," .
      " Perl $], $^X" );
diag( "Testing CloudFlare::Client::Exception::Connection" .
      " $CloudFlare::Client::Exception::Connection::VERSION," . 
      " Perl $], $^X" );
