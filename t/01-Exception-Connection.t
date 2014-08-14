#!perl -T
use Modern::Perl '2012';
use autodie ':all';

use Moo;
use MooX::StrictConstructor;

use Test::More;
use Test::Exception;
use Readonly;

use CloudFlare::Client::Exception::Connection;

plan tests => 6;

# Test for superclass
Readonly my $CLASS => 'CloudFlare::Client::Exception::Connection';
isa_ok($CLASS, 'Throwable::Error', 'Class superclass');
# Test for status accessor
can_ok($CLASS, 'status');

# Construction
# with status
Readonly my $MSG => 'Doesn\'t Matter';
Readonly my $STATUS => '404';
lives_and { new_ok($CLASS => [ message   => $MSG, status => $STATUS])}
          "construction works with status attr";
# Missing message attr
throws_ok { $CLASS->new( status => $STATUS)}
          qr/^Missing required arguments: message/,
          'Construction with missing message attr dies';
# Missing status attr
throws_ok { $CLASS->new( message => $MSG)}
          qr/^Missing required arguments: status/,
          'Construction with missing status attr dies';
# Extra attr
throws_ok { $CLASS->new( message => $MSG, status => $STATUS, extra => 'arg')}
          qr/^Found unknown attribute\(s\)/,
          'construction with extra attr throws exception'
