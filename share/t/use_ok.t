use Test::More;
use File::Find;

# Module::Package example for find
my @modules = ();
File::Find::find(sub {
    return unless -f $_ and $_ =~ /\.pm$/;
    my $module = $File::Find::name;
    $module =~ s!lib[\/\\](.*)\.pm$!$1!;
    $module =~ s!/+!::!g;
    push @modules, $module;
}, 'lib');

plan tests => scalar(@modules);

for my $module (sort @modules) {
    use_ok $module;
}
