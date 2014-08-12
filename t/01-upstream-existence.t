#!perl -T

use Modern::Perl '2012';
use autodie ':all';
use Readonly;

use Test::More;
use Test::Exception;
use LWP::Simple;
use CloudFlare::Client;

# A HTTPS URL that is always alive
Readonly my $REF_URL => 'https://www.cloudflare.com';

# CPAN tests cannot do this
plan skip_all => 'No net connectivity detected' unless get($REF_URL);
plan tests => 1;

# Check we can hit the service and it fails our call
throws_ok { Readonly my $api => CloudFlare::Client::->new( user   => 'user',
                                                           apikey => 'KEY');
          # Picked because takes no args
          $api->zoneLoadMulti } 'CloudFlare::Client::Exception::Upstream',
          'Upstream service exists and responds'
