#!perl -T
use Modern::Perl '2012';

use Test::More;
use Test::Moose;
use Test::Exception;
use Try::Tiny;
use Readonly;

use CloudFlare::Client::Exception::Connection;

plan tests => 9;
Readonly my $MSG => 'Doesn\'t Matter';

# Test for superclass
Readonly my $CLASS => 'CloudFlare::Client::Exception::Connection';
isa_ok($CLASS, 'Throwable::Error', 'Class superclass');
# Test for status accessor
can_ok($CLASS, 'status');
# Tests for moose
meta_ok($CLASS);
has_attribute_ok($CLASS, 'status', 'status attribute');
my $e = try { $CLASS->new( message => $MSG)};
meta_ok($e);

# Construction
# with status
lives_and { new_ok($CLASS => [ message   => $MSG, status => 404])}
    "construction works with status attr";
# No status
lives_and { new_ok($CLASS => [ message => $MSG])}
    "construction works without status attr";
# Missing message
throws_ok { $CLASS->new } 'Moose::Exception::AttributeIsRequired',
    "construction with missing message attr throws exception";
# Extra attr
throws_ok { $CLASS->new(message => $MSG, extra => 'arg')}
    'Moose::Exception::Legacy',
    'construction with extra attr throws exception';
