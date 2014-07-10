#!perl -T
use Modern::Perl '2014';

use Readonly;
use Try::Tiny;
use Test::More;
use Test::Moose;

use CloudFlare::Client;

plan tests => 43;

# Tests for moose
Readonly my $CLASS => 'CloudFlare::Client';
meta_ok($CLASS);
for my $attr (qw/ _user _key _ua/) {
    has_attribute_ok($CLASS, $attr);
}

# Construction
# Valid arguments 
Readonly my $USER => 'blah';
Readonly my $KEY  => 'blah';
try {
    new_ok($CLASS, [
	       user    => $USER,
	       apikey  => $KEY
	   ],
	   'construction with valid credentials');
} finally {
    Readonly my $e => shift;
    is($e, undef, "construction with valid credentials no exception");
};

# Check an exception is the expected class
sub _checkEType {
    Readonly my $e        => shift;
    Readonly my $eClass   => shift;
    Readonly my $tstName  => shift;
    diag($e) unless isa_ok($e, $eClass, $tstName)
}
# Missing user
Readonly my $MISS_ARG_E => 
    'Moose::Exception::AttributeIsRequired';
try { new $CLASS(apikey => $KEY) } finally {
    _checkEType(shift, $MISS_ARG_E,
	   "construction with missing user attribute exception")};
# Missing apikey
try { new $CLASS(user => $USER) } finally {
    _checkEType(shift, $MISS_ARG_E,
	   "construction with missing apikey attribute exception")};
# Extra attr
try { new $CLASS(user   => $USER,
		 apikey => $KEY,
		 extra  => 'arg') } finally {
		     _checkEType(shift, 'Moose::Exception::Legacy',
				 "construction with extra attribute exception")};

# More moose tests
Readonly my $api => try { new $CLASS(
			      user    => $USER,
			      apikey  => $KEY)};
meta_ok($api);

# methods - check for failure upstream
# stats
Readonly my $UPSTRM_E =>
    'CloudFlare::Client::Exception::Upstream';
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

# method => [[ args1 ], ...]
Readonly my %tstSpec => (
    stats         => [[ $ZONE, $ITRVL ]],
    zoneLoadMulti => [[]],
    recLoadAll    => [[ $ZONE ]],
    zoneCheck     => [[ $ZONE ], [ $ZONE, $ZONE ]],
    zoneIps       => [[ $ZONE ],
		      [ $ZONE, hours => $HOURS ],
		      [ $ZONE, class => $REC_CLASS ],
		      [ $ZONE, geo => $GEO ]],
    ipLkup        => [[ $IP ]],
    zoneSettings  => [[ $ZONE ]],
    secLvl        => [[ $ZONE, $SEC_LVL ]],
    cacheLvl      => [[ $ZONE, $CCH_LVL ]],
    devMode       => [[ $ZONE, $DEV_MODE ]],
    fpurgeTs      => [[ $ZONE, $PRG_CCH ]],
    zoneFilePurge => [[ $ZONE, $PRG_URL ]],
    zoneGrab      => [[ $ZONE_ID ]],
    wl            => [[ $IP ]],
    ban           => [[ $IP ]],
    nul           => [[ $IP ]],
    ipv46         => [[ $ZONE, $IP_VAL ]],
    async         => [[ $ZONE, $MINI_VAL ]],
    mirage2       => [[ $ZONE, $MIR_VAL ]],
    recNew        => [[ $ZONE, 'A', $REC_NAME, $IP, $TTL ],
		      [ $ZONE, 'CNAME', $REC_NAME, $ZONE, $TTL ],
		      [ $ZONE, 'MX', $REC_NAME, $ZONE, $TTL, 
			prio => $PRIO ],
		      [ $ZONE, 'TXT', $REC_NAME, $ZONE, $TTL ],
		      [ $ZONE, 'SPF', $REC_NAME, $ZONE, $TTL ],
		      [ $ZONE, 'AAAA', $REC_NAME, $IP6, $TTL ],
		      [ $ZONE, 'NS', $REC_NAME, $IP, $TTL ],
		      [ $ZONE, 'SRV', $REC_NAME, $IP, $TTL,
			prio => $PRIO,
			srvname => $SRVC_NAME,
			protocol => $PROTO,
			weight => $WGHT,
			port => $PORT,
			target => $TRGT ],
		      [ $ZONE, 'LOC', $REC_NAME, $IP, $TTL ]],
    recDelete     => [[ $ZONE, $REC_ID ]]
);
for my $method ( sort keys %tstSpec ) {
    for my $args (@{ $tstSpec{$method} }) {
	try { $api->$method(@$args) } finally {
	    _checkEType(shift, $UPSTRM_E, $method)}}}

