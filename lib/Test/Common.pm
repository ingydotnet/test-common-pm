##
# name:      Test::Common
# abstract:  Simple, Reusable Module Tests
# author:    Ingy döt Net <ingy@cpan.org>
# license:   perl
# copyright: 2011

use 5.008003;
package Test::Common;
use strict;
use warnings;

our $VERSION = '0.01';

use YAML::XS 0.35;
use File::Share 0.01;
use File::Copy 2.14;

#------------------------------------------------------------------------------#
package Test::Common::Command;
use App::Cmd::Setup -command;
use Mouse;
extends qw[MouseX::App::Cmd::Command];

#------------------------------------------------------------------------------#
package Test::Common;
use App::Cmd::Setup -app;
use Mouse;
extends 'MouseX::App::Cmd';

sub update {
    Test::Common::Command::update->execute;
}

#------------------------------------------------------------------------------#
package Test::Common::Command::config;
use Mouse;
Test::Common->import( -command );
extends 'Test::Common::Command';
use constant abstract => 'Create new Test::Common config files';

sub execute {
    my ($self) = @_;
    my $share = $self->share;
    if (-d 't') {
        $self->copy("$share/t/common.yaml", "t/common.yaml");
    }
#     if (-d 'xt') {
#         $self->copy("$share/xt/common.yaml", "xt/common.yaml");
#     }
}

#------------------------------------------------------------------------------#
package Test::Common::Command::update;
use Mouse;
Test::Common->import( -command );
extends 'Test::Common::Command';
use constant abstract => 'Update Test::Common test files';

sub execute {
    my ($self) = @_;
    my $share = $self->share;
    my $file = 't/common.yaml';
    if (-e $file) {
        my $list = $self->load_file($file);
        for my $elem (@$list) {
            my $name = $elem->{name} or die;
            $self->copy("share/t/$name", "t/$name");
        }
    }
}

#------------------------------------------------------------------------------#
package Test::Common::Command;

use YAML::XS;
use File::Share;
use File::Copy ();

sub share {
    return File::Share::dist_dir('Test-Common');
}

sub load_file {
    my ($self, $file) = @_;
    return YAML::XS::LoadFile($file);
}

sub copy {
    my ($self, $from, $to) = @_;
    File::Copy::copy($from, $to);
}

1;
