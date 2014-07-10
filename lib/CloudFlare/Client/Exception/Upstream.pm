package CloudFlare::Client::Exception::Upstream;

use Modern::Perl '2014';
use autodie ':all';

use Readonly;
use namespace::autoclean;
use Moose;
use MooseX::StrictConstructor;
use CloudFlare::Client::Types ':all';

Readonly our $VERSION => 0.01;

extends 'Throwable::Error';

has errorCode => (
    is       => 'ro',
    isa      => ErrorCode
    );

__PACKAGE__->meta->make_immutable;
1; # End of CloudFlare::Client::Exception::Upstream

__END__

=head1 NAME

CloudFlare::Client::Exception::Upstream - Upstream CloudFlare API Exception

=head1 VERSION

Version 0.01

=head1 SYNOPSIS

Exception class that propagates errors from the CloudFlare API

    use CloudFlare::Client::Exception::Upstream;

    throw CloudFlare::Client::Exception::Upstream(
        message   => 'Bad things occured',
        errorCode => 'E_MAXAPI'
    );

    my $e = new CloudFlare::Client::Exception::Upstream(
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

    throw CloudFlare::Client::Exception::Upstream(
        message   => 'Bad things occured',
        errorCode => 'E_MAXAPI'
    );
    ...
    
On an instance, throw that exception
  
    $e->throw;

=head2 new

Construct a new exception

    my $e = new CloudFlare::Client::Exception::Upstream(
        message   => 'Bad things happened',
        errorcode => 'E_MAXAPI'
    );

=head1 INHERITED ATTRIBUTES AND METHODS

See L<Throwable::Error>

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

    perldoc CloudFlare::Client::Exception::Upstream

You can also look for information at:

=over 4

=item * DDFlare

L<https://bitbucket.org/pwr22/ddflare>

=item * CloudFlare Client API

L<https://www.cloudflare.com/docs/client-api.html>

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
