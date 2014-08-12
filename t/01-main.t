#!perl -T

# Aims to test basic usage of CloudFlare::Client
use Modern::Perl '2012';
use autodie ':all';

use Readonly;
use Test::More;
use Test::Moose;
use Test::Exception;
use Try::Tiny;

use CloudFlare::Client;

plan tests => 42;
Readonly my $USER => 'blah';
Readonly my $KEY  => 'blah';

# Construction
Readonly my $CLASS => 'CloudFlare::Client';
lives_and {
    new_ok($CLASS, [ user => $USER, apikey  => $KEY])}
    "construction with valid credentials works";
# Missing message attr
throws_ok { $CLASS->new(apikey => $KEY) }
    qr/^Missing required arguments: user/,
    'Construction with missing user attr dies';
# Missing apikey attr
throws_ok { $CLASS->new(user => $USER) }
qr/^Missing required arguments: apikey/,
    'Construction with missing apikey attr dies';
# Extra attr
throws_ok { $CLASS->new(user => $USER, apikey => $KEY, extra => 'arg')}
    qr/^Found unknown attribute\(s\)/,
    'construction with extra attr throws exception';

# This matches exceptions from Kavorka
Readonly my $ARGS_E => qr{^Expected (?:at least )?\d+ parameters?};
# Catch potential failure
Readonly my $API => try { $CLASS->new( user => $USER, apikey => $KEY)}
    catch { diag $_ };
# Valid values
Readonly my $ZONE         => 'zone.co.uk';
Readonly my $ITRVL        => 20;
Readonly my $HOURS        => 48;
Readonly my $REC_CLASS    => 'r';
Readonly my $GEO          => 1;
Readonly my $IP           => '0.0.0.0';
Readonly my $SEC_LVL      => 'med';
Readonly my $CCH_LVL      => 'agg';
Readonly my $DEV_MODE     => 1;
Readonly my $PRG_CCH      => 1;
Readonly my $PRG_URL      => "http://$ZONE/file.txt";
Readonly my $ZONE_ID      => 1;
Readonly my $IP_VAL       => 0;
Readonly my $MINI_VAL     => 'a';
Readonly my $MIR_VAL      => 0;
Readonly my $REC_NAME     => 'hostname';
Readonly my $TTL          => 1;
Readonly my $PRIO         => 10;
Readonly my $SRVC         => 'dunno';
Readonly my $SRVC_NAME     => 'dunno';
Readonly my $PROTO        => '_tcp';
Readonly my $WGHT         => 10;
Readonly my $PORT         => 8080;
Readonly my $TRGT         => 'dunno';
Readonly my $IP6          => '::1';
Readonly my $REC_ID       => 1;
Readonly my $REC_TYPE      => 'A';
Readonly my $EXTRA        => 'An extra arg';
# Tests with too few args
# method => [[ args1 ], ...]
Readonly my %tstTFSpec => (
    stats         => [[ $ZONE ]],
    recLoadAll    => [[]],
    zoneCheck     => [[]],
    zoneIps       => [[]],
    ipLkup        => [[]],
    zoneSettings  => [[]],
    secLvl        => [[ $ZONE ]],
    cacheLvl      => [[ $ZONE ]],
    devMode       => [[ $ZONE ]],
    fpurgeTs      => [[ $ZONE ]],
    zoneFilePurge => [[ $ZONE ]],
    zoneGrab      => [[]],
    wl            => [[]],
    ban           => [[]],
    nul           => [[]],
    ipv46         => [[ $ZONE ]],
    async         => [[ $ZONE ]],
    mirage2       => [[ $ZONE ]],
    recNew        => [[ $ZONE, $REC_TYPE, $REC_NAME, $IP ]],
    recDelete     => [[ $ZONE ]]);
for my $method ( sort keys %tstTFSpec ) {
    for my $args (@{ $tstTFSpec{$method} }) {
        throws_ok { $API->$method(@$args) }
            $ARGS_E,
            "too few args to $method throws exception"}}
# Tests with too many args
Readonly my %tstTMSpec => (
    # Too few args
    stats         => [[ $ZONE, $ITRVL, $EXTRA ]],
    zoneLoadMulti => [[ $EXTRA ]],
    recLoadAll    => [[ $ZONE, $EXTRA ]],
    ipLkup        => [[ $IP, $EXTRA ]],
    zoneSettings  => [[ $ZONE, $EXTRA ]],
    secLvl        => [[ $ZONE, $SEC_LVL, $EXTRA ]],
    cacheLvl      => [[ $ZONE, $CCH_LVL, $EXTRA ]],
    devMode       => [[ $ZONE, $DEV_MODE, $EXTRA ]],
    fpurgeTs      => [[ $ZONE, $PRG_CCH, $EXTRA ]],
    zoneFilePurge => [[ $ZONE, $PRG_URL, $EXTRA ]],
    zoneGrab      => [[ $ZONE_ID, $EXTRA ]],
    wl            => [[ $IP, $EXTRA ]],
    ban           => [[ $IP, $EXTRA ]],
    nul           => [[ $IP, $EXTRA ]],
    ipv46         => [[ $ZONE, $IP_VAL, $EXTRA ]],
    async         => [[ $ZONE, $MINI_VAL, $EXTRA ]],
    mirage2       => [[ $ZONE, $MIR_VAL, $EXTRA ]],
    recDelete     => [[ $ZONE, $REC_ID, $EXTRA ]]);
for my $method ( sort keys %tstTMSpec ) {
    for my $args (@{ $tstTMSpec{$method} }) {
        throws_ok { $API->$method(@$args) }
            $ARGS_E,
            "too many args to $method throws exception"}}
