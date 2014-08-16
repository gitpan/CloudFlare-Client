package CloudFlare::Client::Exception::Upstream;
# ABSTRACT: Upstream CloudFlare API Exception

use Modern::Perl qw( 2012);
use autodie      qw( :all);
use namespace::autoclean;

use Readonly;
use Moo; use MooX::StrictConstructor;
use CloudFlare::Client::Types qw( ErrorCode);

our $VERSION = '0.03_7'; # TRIAL VERSION

extends 'Throwable::Error';

has errorCode => (
    is       => 'ro',
    isa      => ErrorCode);

1; # End of CloudFlare::Client::Exception::Upstream

__END__

=pod

=encoding UTF-8

=head1 NAME

CloudFlare::Client::Exception::Upstream - Upstream CloudFlare API Exception

=head1 VERSION

version 0.03_7

=head1 SYNOPSIS

Exception class that propagates errors from the CloudFlare API

    use CloudFlare::Client::Exception::Upstream;

    CloudFlare::Client::Exception::Upstream::->throw(
        message   => 'Bad things occured',
        errorCode => 'E_MAXAPI'
    );

    my $e = CloudFlare::Client::Exception::Upstream::->new(
        message   => 'Bad things happened',
        errorcode => 'E_MAXAPI'
    );
    $e->throw;

=head1 ATTRIBUTES

=head2 message

The error message thrown upstream, readonly.

=head2 errorCode

The error code thrown upstream, readonly. Valid values are undef,
E_UNAUTH, E_INVLDINPUT or E_MAXAPI.

=head1 METHODS

=head2 throw

On the class, throw a new exception

    CloudFlare::Client::Exception::Upstream::->throw(
        message   => 'Bad things occured',
        errorCode => 'E_MAXAPI'
    );
    ...

On an instance, throw that exception

    $e->throw;

=head2 new

Construct a new exception

    my $e = CloudFlare::Client::Exception::Upstream::->new(
        message   => 'Bad things happened',
        errorcode => 'E_MAXAPI'
    );

=head1 INHERITANCE

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
