package CloudFlare::Client;
# ABSTRACT: Object Orientated Interface to CloudFlare client API

use Modern::Perl '2012';
use autodie ':all';

use Readonly;
use namespace::autoclean;
use Carp;
use Moose;
use MooseX::StrictConstructor;
use Method::Signatures;

use CloudFlare::Client::Exception::Connection;
use CloudFlare::Client::Exception::Upstream;
use LWP::UserAgent;
use JSON::Any;

our $VERSION = '0.03'; # VERSION

# Read only attributes
# Cloudflare credentials
has '_user' => (
    is       => 'ro',
    isa      => 'Str',
    required => 1,
    init_arg => 'user');
has '_key' => (
    is       => 'ro',
    isa      => 'Str',
    required => 1,
    init_arg => 'apikey');
Readonly my $UA_STRING =>
    "CloudFlare::Client/$CloudFlare::Client::VERSION";
has '_ua' => (
    is       => 'ro',
    default  => sub { Readonly my $ua => LWP::UserAgent::->new;
                      $ua->agent($UA_STRING);
                      $ua},
    init_arg => undef);

# private methods
Readonly my $CF_URL =>
    'https://www.cloudflare.com/api_json.html';
method _apiCall($act is ro, %args is ro) {
    # query cloudflare
    Readonly my $res => $self->_ua->post($CF_URL, {
        %args,
        # global args
        # override user specified
        tkn   => $self->_key,
        email => $self->_user,
        a     => $act});
    CloudFlare::Client::Exception::Connection::->throw(
        status  => $res->status_line,
        message => 'HTTPS request failed')
        unless $res->is_success;
    Readonly my $info =>
        JSON::Any::->jsonToObj($res->decoded_content);
    CloudFlare::Client::Exception::Upstream::->throw(
        errorCode => $info->{err_code},
        message   => $info->{msg})
        unless $info->{result} eq 'success';

    $info->{response}}

# Methods
method stats($zone  is ro, $itrvl is ro) {
    $self->_apiCall('stats', z => $zone, interval => $itrvl)}

method zoneLoadMulti {
    $self->_apiCall('zone_load_multi')}

method recLoadAll($zone is ro) {
    $self->_apiCall('rec_load_all', z => $zone)}

# Requires at least one zone, but can take any number
method zoneCheck($fZone is ro, @rZones is ro) {
    $self->_apiCall('zone_check', zones => join ',', $fZone, @rZones)}

method zoneIps($zone is ro, %args is ro) {
    $self->_apiCall('zone_ips', %args,
                    # Override user specified
                    z     => $zone)}

method ipLkup($ip is ro) {
    $self->_apiCall('ip_lkup', ip => $ip)}

method zoneSettings($zone is ro) {
    $self->_apiCall('zone_settings', z => $zone)}

method secLvl($zone is ro, $secLvl is ro) {
    $self->_apiCall('sec_lvl', z => $zone, v => $secLvl);
}

method cacheLvl($zone is ro, $cchLvl is ro) {
    $self->_apiCall('cache_lvl', z => $zone, v => $cchLvl)}

method devMode($zone is ro, $val is ro) {
    $self->_apiCall('devmode', z => $zone, v => $val)}

method fpurgeTs($zone is ro, $val is ro) {
    $self->_apiCall('fpurge_ts', z => $zone, v => $val)}

method zoneFilePurge($zone is ro, $url is ro) {
    $self->_apiCall('zone_file_purge', z => $zone, url => $url)}

method zoneGrab($zId is ro) {
    $self->_apiCall('zone_grab', zid => $zId)}

method _wlBanNul($act is ro, $ip is ro) {
    $self->_apiCall($act, key => $ip)}

method wl($ip is ro) {
    $self->_wlBanNul('wl', $ip)}

method ban($ip is ro) {
    $self->_wlBanNul('ban', $ip)}

method nul($ip is ro) {
    $self->_wlBanNul('nul', $ip)}

method ipv46($zone is ro, $val is ro) {
    $self->_apiCall('ipv46', z => $zone, v => $val)}

method async($zone is ro, $val is ro) {
    $self->_apiCall('async', z => $zone, v => $val)}

method minify($zone is ro, $val is ro) {
    $self->_apiCall('async', z => $zone, v => $val)}

method mirage2($zone is ro, $val is ro) {
    $self->_apiCall('mirage2', z => $zone, v => $val)}

method recNew($zone is ro, $type is ro, $name is ro, $cntnt is ro,
              $ttl is ro, %args is ro) {
    $self->_apiCall('rec_new',
                    %args,
                    # Override user specified
                    z => $zone, type => $type, name => $name,
                    content => $cntnt, ttl => $ttl)}

method recEdit($zone is ro, $type is ro, $id is ro, $name is ro, $cntnt is ro,
               $ttl is ro, %args  is ro) {
    $self->_apiCall('rec_edit',
                    %args,
                    # override user specified
                    z => $zone, type => $type, id => $id, name => $name,
                    content => $cntnt, ttl => $ttl)}

method recDelete($zone is ro, $id is ro) {
    $self->_apiCall('rec_delete', z => $zone, id => $id)}

__PACKAGE__->meta->make_immutable;
1; # End of CloudFlare::Client

__END__

=pod

=encoding UTF-8

=head1 NAME

CloudFlare::Client - Object Orientated Interface to CloudFlare client API

=head1 VERSION

version 0.03

=head1 SYNOPSIS

Provides an object orientated interface to the CloudFlare client API

    use CloudFlare::Client;

    my $api = CloudFlare::Client::->new(
        user   => $CF_USER,
        apikey => $CF_KEY);
    $api->stats;
    ...

Please see the documentation at
L<https://www.cloudflare.com/docs/client-api.html> for information the
CloudFlare client API and its arguments. Optional arguments are passed
in as a hash with keys as given in the docs

Successful API calls return the response section from the upstream JSON API. Failures for whatever reason throw exceptions under the CloudFlare::Client::Exception:: namespace

=head1 ATTRIBUTES

=head2 _user

CF user name (email) used to access the API. Set using the
user argument to the constructor. Readonly.

=head2 _key

CF API key, set using the apikey argument to the constructor.
Readonly

=head2 _ua

UserAgent object used to make API calls, set internally. Readonly

=head1 METHODS

=head2 new

Construct a new CloudFlare::Client API object

    my $api = CloudFlare::Client::->new(
        user   => $CF_USER,
        apikey => $CF_KEY)

=head2 stats

    $api->stats($zone, $interval)

=head2 zoneLoadMulti

    $api->zoneLoadMulti

=head2 recLoadAll

    $api->recLoadAll($zone);

=head2 zoneCheck

    $api->zoneCheck(@zones);

=head2 zoneIps

    $api->zoneIps($zone, %optionalArgs);

=head2 ipLkup

    $api->ipLkup($ip)

=head2 zoneSettings

    $api->zoneSettings($zone)

=head2 secLvl

    $api->secLvl($zone, $securityLvl)

=head2 cacheLvl

    $api->cacheLvl($zone, $cacheLevel)

=head2 devMode

    $api->devMode($zone, $value)

=head2 fpurgeTs

    $api->fpurgeTs($zone, $value)

=head2 zoneFilePurge

    $api->zoneFilePurge($zone, $url)

=head2 zoneGrab

    $api->zoneGrab($zoneId)

=head2 wl

    $api->wl($ip)

=head2 ban

    $api->ban($ip)

=head2 nul

    $api->nul($ip)

=head2 ipv46

    $api->ipv46($zone, $value)

=head2 async

    $api->async($zone, $value)

=head2 minify

    $api->minify($zone, $value)

=head2 mirage2

    $api->mirage2($zone, $value)

=head2 recNew

    $api->recNew($zone, $type, $name
                 $content, $ttl, %optionalArgs)

=head2 recEdit

    $api->recEdit($zone, $type, $recordId, $name
                  $content, $ttl, %optionalArgs)

=head2 recDelete

    $api->recDelete($zone, $recordId)

=head2 _apiCall

Makes a call through to the CF API, via HTTPS POST

    $api->_makeCall($action, %args)

If the HTTPS connection fails this can throw a
L<CloudFlare::Client::Exception::Connection>. If the CF API itself
gives an error then it can throw a
L<CloudFlare::Client::Exception::Upstream>

=head2 _wlBanNul

Used to aggregrate a number of CF calls with a single signature into
one function

=for test_synopsis my ($CF_USER, $CF_KEY);

=head1 BUGS

Please report any bugs or feature requests to C<bug-cloudflare-client
at rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=CloudFlare-Client>.
I will be notified, and then you'll automatically be notified of
progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc CloudFlare::Client

You can also look for information at:

=over 4

=item *

DDFlare

L<https://bitbucket.org/pwr22/ddflare>

=item *

RT: CPAN's request tracker (report bugs here)

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=CloudFlare-Client>

=item *

AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/CloudFlare-Client>

=item *

CPAN Ratings

L<http://cpanratings.perl.org/d/CloudFlare-Client>

=item *

Search CPAN

L<http://search.cpan.org/dist/CloudFlare-Client/>

=back

=head1 ACKNOWLEDGEMENTS

Thanks to CloudFlare providing an awesome free service with an API.

=head1 AUTHOR

Peter Roberts <me+dev@peter-r.co.uk>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2014 by Peter Roberts.

This is free software, licensed under:

  The MIT (X11) License

=cut
