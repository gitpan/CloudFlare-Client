use Modern::Perl '2014';
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME             => 'CloudFlare::Client',
    AUTHOR           => q{Peter Roberts <me+dev@peter-r.co.uk>},
    VERSION          => '0.01',
    ABSTRACT_FROM    => 'lib/CloudFlare/Client.pm',
    LICENSE          => 'MIT',
    PL_FILES         => {},
    MIN_PERL_VERSION => v5.18,
    CONFIGURE_REQUIRES => {
        'ExtUtils::MakeMaker' => 0,
    },
    BUILD_REQUIRES => {
        'Test::More'          => 0.98,
	'Test::Moose'         => 2.1210,
	'Try::Tiny'           => 0.22,
	'Test::CheckManifest' => 0.9,
	'Test::Pod::Coverage' => 1.08,
	'Pod::Coverage'       => 0.18,
	'Test::Pod'           => 1.22,
	'Test::TypeTiny'      => 0.044
    },
    PREREQ_PM => {
	# Client.pm
	'strict'                    => 1.07,
	'warnings'                  => 1.18,
	'Modern::Perl'              => 1.20140107,
	'autodie'                   => 2.25,
	'Readonly'                  => 2.0,
	'namespace::autoclean'      => 0.19,
	'Carp'                      => 1.29,
	'Moose'                     => 2.1210,
	'MooseX::StrictConstructor' => 0.19,
	'Method::Signatures'        => 20140224,
	'LWP::UserAgent'            => 6.06,
	'JSON::Any'                 => 1.34,
	# Client/Types.pm
	'MooseX::Types'             => 0.44,
	'MooseX::Types::Moose'      => 0.44,
    },
    dist  => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean => { FILES => 'CloudFlare-Client-*' },
);
