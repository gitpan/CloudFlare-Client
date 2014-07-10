#!perl -T
use Modern::Perl '2014';

use Test::More;
use Test::Moose;
use Try::Tiny;
use Readonly;

use CloudFlare::Client::Exception::Connection;

plan tests => 11;

# Test for superclass
Readonly my $CLASS => 'CloudFlare::Client::Exception::Connection';
isa_ok($CLASS, 'Throwable::Error',
    'Class superclass');

# Test for status accessor
can_ok($CLASS, 'status');

# Tests for moose
meta_ok($CLASS);
has_attribute_ok($CLASS, 'status',
    'status attribute');

# Construction
# with status
Readonly my $MSG => 'Doesn\'t Matter';
try {
    new_ok($CLASS => [
	       message   => $MSG,
	       status => 404 ],
	   "construction with status"
	);
} finally {
    Readonly my $ee => shift;
    is($ee, undef,"construction with status no exception");
};
# No status
try {
    new_ok($CLASS => [ message => $MSG ],
	   "construction with no status"
	);
} finally {
    Readonly my $ee => shift;
    is($ee, undef,"construction with no status no exception");
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
	)};
meta_ok($e);
