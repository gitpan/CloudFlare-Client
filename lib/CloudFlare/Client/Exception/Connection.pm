package CloudFlare::Client::Exception::Connection;
# ABSTRACT: CloudFlare API Connection Exception

use Modern::Perl '2012';
use autodie ':all';

use Readonly;
use namespace::autoclean;
use Moose;
use MooseX::StrictConstructor;
use MooseX::Types::Moose qw( Str );

our $VERSION = '0.02'; # VERSION

extends 'Throwable::Error';

has status => (
    is       => 'ro',
    isa      => Str
    );

__PACKAGE__->meta->make_immutable;
1; # End of CloudFlare::Client::Exception::Connection

__END__

=pod

=encoding UTF-8

=head1 NAME

CloudFlare::Client::Exception::Connection - CloudFlare API Connection Exception

=head1 VERSION

version 0.02

=head1 SYNOPSIS

Exception class for failures in the CloudFlare API connection

    use CloudFlare::Client::Exception::Connection;

    throw CloudFlare::Client::Exception::Upstream(
        message   => 'HTTPS connection failure',
        status => '404'
    );

    my $e = new CloudFlare::Client::Exception::Connection(
        message   => 'HTTPS connection failure',
        status => '404'
    );
    $e->throw;

=head1 ATTRIBUTES

=head2 message

The error message thrown upstream, readonly.

=head2 status

The status code for the connection failure

=head1 METHODS

=head2 throw

On the class, throw a new exception

    throw CloudFlare::Client::Exception::Connection(
        message   => 'HTTPS connection failure',
        status => '404'
    );
    ...

On an instance, throw that exception

    $e->throw;

=head2 new

Construct a new exception

    my $e = new CloudFlare::Client::Exception::Connection(
        message   => 'HTTPS connection failure',
        errorcode => '404'
    );

=head1 INHERITED ATTRIBUTES AND METHODS

See L<Throwable::Error>

=head1 BUGS

Please report any bugs or feature requests to C<bug-cloudflare-client
at rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=CloudFlare-Client>.
I will be notified, and then you'll automatically be notified of
progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc CloudFlare::Client::Exception::Upstream

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

=head1 AUTHOR

Peter Roberts <me+dev@peter-r.co.uk>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2014 by Peter Roberts.

This is free software, licensed under:

  The MIT (X11) License

=cut
