package CloudFlare::Client::Types;

use Modern::Perl '2014';
use autodie ':all';

use namespace::autoclean;
use MooseX::Types -declare => [ qw( CFCode ErrorCode ) ];
use MooseX::Types::Moose qw( Undef );
use Readonly;

Readonly our $VERSION => '0.01';

enum CFCode, [ qw( E_UNAUTH E_INVLDINPUT E_MAXAPI ) ];
union ErrorCode, [ Undef, CFCode ];

1; # End of CloudFlare::Client::Types

__END__

=head1 NAME

CloudFlare::Client::Types - Types for CloudFlare::Client

=head1 VERSION

Version 0.01

=head1 SYNOPSIS

Provides types used in CloudFlare::Client

    use CloudFlare::Client::Types qw( ErrorCode );

=head1 AUTHOR

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

=item * DDFlare

L<https://bitbucket.org/pwr22/ddflare>  

=item * RT: CPAN's request tracker (report bugs here)

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=CloudFlare-Client>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/CloudFlare-Client>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/CloudFlare-Client>

=item * Search CPAN

L<http://search.cpan.org/dist/CloudFlare-Client/>

=back

=head1 LICENSE AND COPYRIGHT

Copyright 2014 Peter Roberts.

This program is distributed under the MIT (X11) License:
L<http://www.opensource.org/licenses/mit-license.php>

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.

=cut
