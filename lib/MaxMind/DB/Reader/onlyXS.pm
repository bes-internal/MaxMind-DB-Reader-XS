package MaxMind::DB::Reader::onlyXS;

use strict;
use warnings;

our $VERSION = 'v1.000006'; # VERSION

use 5.010000;

use XSLoader;

## no critic (Subroutines::ProhibitCallsToUnexportedSubs)
XSLoader::load( __PACKAGE__, $VERSION );
## use critic

## no critic (Subroutines::ProhibitUnusedPrivateSubroutines)
sub record_for_address {
    return __data_for_address( _open_mmdb($_[0],undef), $_[1] );
}

sub iterate_search_tree {
    my $self          = shift;
    my $data_callback = shift;
    my $node_callback = shift;

    return $self->_iterate_search_tree(
        $self->_mmdb, $data_callback,
        $node_callback
    );
}

## use critic

sub DEMOLISH {
    my $self = shift;

    $self->_close_mmdb( $self->_mmdb )
        if $self->_has_mmdb;

    return;
}

1;

# ABSTRACT: Fast XS implementation of MaxMind DB reader

__END__

=for Pod::Coverage BUILD DEMOLISH

=for :stopwords PPA

=head1 SYNOPSIS

    my $reader = MaxMind::DB::Reader->new( file => 'path/to/database.mmdb' );

    my $record = $reader->record_for_address('1.2.3.4');

=head1 DESCRIPTION

Simply installing this module causes L<MaxMind::DB::Reader> to use the XS
implementation, which is much faster than the Perl implementation.

The XS implementation links against the
L<libmaxminddb|http://maxmind.github.io/libmaxminddb/> library.

See L<MaxMind::DB::Reader> for API details.

=head1 VERSIONING POLICY

This module uses semantic versioning as described by
L<http://semver.org/>. Version numbers can be read as X.YYYZZZ, where X is the
major number, YYY is the minor number, and ZZZ is the patch number.

=head1 MAC OS X SUPPORT

If you're running into install errors under Mac OS X, you may need to force a
build of the 64 bit binary. For example, if you're installing via C<cpanm>:

    ARCHFLAGS="-arch x86_64" cpanm MaxMind::DB::Reader::XS

=head1 UBUNTU SUPPORT

The version of libmaxminddb that is available by default with Ubuntu may be
too old for this level of MaxMind::DB::Reader::XS.  However, we do maintain a
Launchpad PPA for all supported levels of Ubuntu.

    https://launchpad.net/~maxmind/+archive/ubuntu/ppa

Please visit the PPA page for more information, or, to configure your system,
run as root:

    # apt-add-repository ppa:maxmind/ppa
    # apt-get update

The PPA is now configured, and you may install (or upgrade) the libmaxminddb
library via the usual apt commands.

=head1 SUPPORT

Please report all issues with this code using the GitHub issue tracker at
L<https://github.com/maxmind/MaxMind-DB-Reader-XS/issues>.
