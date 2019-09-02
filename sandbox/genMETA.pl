#!/pro/bin/perl

use strict;
use warnings;

use Getopt::Long qw(:config bundling nopermute);
my $check = 0;
my $opt_v = 0;
GetOptions (
    "c|check"		=> \$check,
    "v|verbose:1"	=> \$opt_v,
    ) or die "usage: $0 [--check]\n";

use lib "sandbox";
use genMETA;
my $meta = genMETA->new (
    from    => "ccdiff",
    verbose => $opt_v,
    );

$meta->from_data (<DATA>);
$meta->gen_cpanfile ();

if ($check) {
    $meta->check_encoding ();
    $meta->check_required ();
    $meta->check_minimum ();
    $meta->done_testing ();
    }
elsif ($opt_v) {
    $meta->print_yaml ();
    }
else {
    $meta->fix_meta ();
    }

__END__
--- #YAML:1.0
name:                    App-ccdiff
version:                 VERSION
abstract:                Colored Character Diff
license:                 artistic_2
author:
    - H.Merijn Brand <h.m.brand@xs4all.nl>
generated_by:            Author
distribution_type:       module
provides:
    App::ccdiff:
        file:            lib/App/ccdiff.pm
        version:         VERSION
requires:
    perl:                5.014000
    charnames:           0
    Algorithm::Diff:     1.1901
    Term::ANSIColor:     0
    Getopt::Long:        0
recommends:
    Algorithm::Diff:     1.1903
configure_requires:
    ExtUtils::MakeMaker: 0
build_requires:
    Config:              0
test_requires:
    Test::More:          0
    Capture::Tiny:       0
resources:
    license:             http://dev.perl.org/licenses/
    repository:          https://github.com/Tux/App-ccdiff
    homepage:            https://metacpan.org/pod/App::ccdiff
    bugtracker:          https://github.com/Tux/App-ccdiff/issues
    IRC:                 irc://irc.perl.org/#csv
meta-spec:
    version:             1.4
    url:                 http://module-build.sourceforge.net/META-spec-v1.4.html
