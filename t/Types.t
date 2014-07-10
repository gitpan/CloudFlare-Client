#!perl -T
use Modern::Perl '2014';

use Test::More;
use Try::Tiny;
use Test::TypeTiny;

use CloudFlare::Client::Types qw( CFCode ErrorCode );
use Readonly;

plan tests => 9;

Readonly my @CF_CODES => qw( E_UNAUTH E_INVLDINPUT E_MAXAPI );
Readonly my @ERR_CODES => (undef, @CF_CODES);

# Test CFCode
for my $code ( @CF_CODES ) {
    should_pass($code, CFCode, "$code is a CFCode");
}
should_fail('E_NTSPCD', CFCode, 'E_NTSPCD is not a CFCode');

# Test ErrorCode
for my $code ( @ERR_CODES ) {
    should_pass($code, ErrorCode, "$code is a ErrorCode");
}
should_fail('E_NTSPCD', ErrorCode, 'E_NTSPCD is not an ErrorCode');
