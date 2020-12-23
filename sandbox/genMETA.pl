#!/pro/bin/perl

use 5.12.2;
use warnings;

our $VERSION = "2.00 - 2020-12-23";
our $CMD = $0 =~ s{.*/}{}r;

sub usage {
    my $err = shift and select STDERR;
    say "usage: $CMD [--check || --yaml || --json]";
    exit $err;
    } # usage

use Getopt::Long qw(:config bundling nopermute);
GetOptions (
    "help|?"		=> sub { usage (0) },
    "V|version"		=> sub { say "$CMD [$VERSION]"; exit 0; },

    "c|check!"		=> \ my $check,
    "y|yaml!"		=> \ my $opt_y,
    "j|json!"		=> \ my $opt_j,

    "v|verbose:1"	=> \(my $opt_v = 0),
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
elsif ($opt_y) {
    $meta->print_yaml ();
    }
elsif ($opt_j) {
    $meta->print_json ();
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
    - H.Merijn Brand <perl5@tux.freedom.nl>
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
    List::Util:          0
recommends:
    Algorithm::Diff::XS: 0.04
    Algorithm::Diff:     1.201
configure_requires:
    ExtUtils::MakeMaker: 0
build_requires:
    Config:              0
test_requires:
    Test::More:          0
    Capture::Tiny:       0
resources:
    license:             http://dev.perl.org/licenses/
    homepage:            https://metacpan.org/pod/App::ccdiff
    repository:          https://github.com/Tux/App-ccdiff
    bugtracker:          https://github.com/Tux/App-ccdiff/issues
    IRC:                 irc://irc.perl.org/#csv
meta-spec:
    version:             1.4
    url:                 http://module-build.sourceforge.net/META-spec-v1.4.html
