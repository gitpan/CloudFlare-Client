package CloudFlare::Client::Types;
# ABSTRACT: Types for Cloudflare::Client

use Modern::Perl '2012';
use autodie ':all';

use namespace::autoclean;
use MooseX::Types -declare => [ qw( CFCode ErrorCode ) ];
use MooseX::Types::Moose qw( Undef );
use Readonly;

our $VERSION = '0.03'; # VERSION

enum CFCode, [ qw( E_UNAUTH E_INVLDINPUT E_MAXAPI ) ];
union ErrorCode, [ Undef, CFCode ];

1; # End of CloudFlare::Client::Types

__END__

=pod

=encoding UTF-8

=head1 NAME

CloudFlare::Client::Types - Types for Cloudflare::Client

=head1 VERSION

version 0.03

=head1 SYNOPSIS

Provides types used in CloudFlare::Client

    use CloudFlare::Client::Types 'ErrorCode';

Peter Roberts, C<< <me+dev at peter-r.co.uk> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-cloudflare-client
at rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=CloudFlare-Client>.
I will be notified, and then you'll automatically be notified of
progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc CloudFlare::Client::Types

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
