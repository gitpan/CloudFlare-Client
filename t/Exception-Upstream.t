#!perl -T
use Modern::Perl '2014';

use Test::More;
use Test::Moose;
use Try::Tiny;

use CloudFlare::Client::Exception::Upstream;
use Readonly;

plan tests => 12;

# Test for superclass
Readonly my $CLASS => 'CloudFlare::Client::Exception::Upstream';
isa_ok($CLASS, 'Throwable::Error',
    'Class superclass');

# Test for errorCode accessor
can_ok($CLASS, 'errorCode');

# Tests for moose
meta_ok($CLASS);
has_attribute_ok($CLASS, 'errorCode',
    'errorCode attribute');

# Construction
# Valid error code
Readonly my $MSG => 'Doesn\'t Matter';
try {
    new_ok($CLASS => [
               message   => $MSG,
               errorCode => 'E_MAXAPI' ],
           "construction with valid EC"
        );
} finally {
    Readonly my $ee => shift;
    is($ee, undef,"construction with valid EC no exception");
};
# No error code
try {
    new_ok($CLASS => [ message => $MSG ],
           "construction with no EC"
        );
} finally {
    Readonly my $ee => shift;
    is($ee, undef,"construction with no EC no exception");
};
# Invalid error code
try {
    new $CLASS(
        message   => $MSG,
        errorCode => 'E_NOTSPECD'
        );
} finally {
    Readonly my $ee => shift;
    isa_ok($ee, 'Moose::Exception::ValidationFailedForInlineTypeConstraint',
           'construction with invalid EC exception');
};
# Missing message
try {
    new $CLASS;
} finally {
    Readonly my $e => shift;
    isa_ok($e, 'Moose::Exception::AttributeIsRequired',
           "construction with missing message attribute exception");
};
# Extra attr
try { new $CLASS(message => $MSG, extra => 'arg') }
finally {
    Readonly my $e => shift;
    isa_ok($e, 'Moose::Exception::Legacy',
           'construction with extra attribute exception');
};

# More moose tests
my $e = try {
    new $CLASS(
        message => $MSG
        );
};
meta_ok($e);
