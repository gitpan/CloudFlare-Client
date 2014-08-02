#!perl -T
use Modern::Perl '2012';

use Test::More;
use Test::Moose;
use Test::Exception;
use Try::Tiny;

use CloudFlare::Client::Exception::Upstream;
use Readonly;

plan tests => 10;
Readonly my $MSG => 'Doesn\'t Matter';

# Test for superclass
Readonly my $CLASS => 'CloudFlare::Client::Exception::Upstream';
isa_ok($CLASS, 'Throwable::Error', 'Class superclass correct');
# Test for errorCode accessor
can_ok($CLASS, 'errorCode');
# Tests for moose
meta_ok($CLASS);
has_attribute_ok($CLASS, 'errorCode', 'errorCode attribute exists');
my $e = try { $CLASS->new( message => $MSG)};
meta_ok($e);

# Construction
# Valid error code
lives_and { new_ok($CLASS => [ message => $MSG, errorCode => 'E_MAXAPI'])}
    "construction with valid EC works";
# No error code
lives_and { new_ok($CLASS => [ message => $MSG])}
    "construction with no EC works";
# Work around Moose versions
if($Moose::VERSION >= 2.1101) {
    # Invalid error code
    throws_ok { $CLASS->new( message => $MSG, errorCode => 'E_NOTSPECD')}
        'Moose::Exception::ValidationFailedForInlineTypeConstraint',
        'construction with invalid EC fails';
    # Missing message attr
    throws_ok { $CLASS->new } 'Moose::Exception::AttributeIsRequired',
        "construction with missing message attr throws exception";
    # Extra attr
    throws_ok { $CLASS->new(message => $MSG, extra => 'arg')}
        'Moose::Exception::Legacy',
        'construction with extra attr throws exception'}
else { # Invalid error code
       throws_ok { $CLASS->new( message => $MSG, errorCode => 'E_NOTSPECD')}
           qr/^Attribute (errorCode) does not pass the type constraint/,
           'construction with invalid EC fails';
       # Missing message attr
       throws_ok { $CLASS->new } qr/^Attribute (message) is required/,
           'Construction with missing message attr dies';
       # Extra attr
       throws_ok { $CLASS->new(message => $MSG, extra => 'arg')}
           qr/^Found unknown attribute(s)/,
           'construction with extra attr throws exception'}
