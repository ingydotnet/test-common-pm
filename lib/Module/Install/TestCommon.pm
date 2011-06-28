##
# name:      Module::Install::TestCommon
# abstract:  Test::Common support for Module::Install
# author:    Ingy döt Net <ingy@cpan.org>
# license:   perl
# copyright: 2011

use 5.008003;
package Module::Install::ManifestSkip;
use strict;
use warnings;

use base 'Module::Install::Base';

our $VERSION = '0.01';
our $AUTHOR_ONLY = 1;

my $skip_file = "MANIFEST.SKIP";

sub use_test_common {
    my $self = shift;
    return unless $self->is_admin;
    require Test::Common;
    Test::Common::update();
}

1;
