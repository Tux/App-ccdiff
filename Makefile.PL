use 5.12.1;
use warnings;

use ExtUtils::MakeMaker;

my %wmf = (
    NAME               => "App::ccdiff",
    DISTNAME           => "App-ccdiff",
    ABSTRACT           => "Colored Character Diff",
    AUTHOR             => "H.Merijn Brand",
    EXE_FILES          => [ "ccdiff" ],
    VERSION_FROM       => "lib/App/ccdiff.pm",
    MIN_PERL_VERSION   => "5.012001",
    PREREQ_PM          => {
	charnames		=> 0,
	"Algorithm::Diff"	=> 0,
	"Term::ANSIColor"	=> 0,
	"Getopt::Long"		=> 0,
	},
    LICENSE            => "perl",
    CONFIGURE_REQUIRES => { "ExtUtils::MakeMaker" => 0 },
    TEST_REQUIRES      => { "Test::More"          => 0 },
    macro              => { TARFLAGS => "--format=ustar -c -v -f", },
    );

eval { ExtUtils::MakeMaker->VERSION (6.63_03) } or
    delete $wmf{TEST_REQUIRES};

my $rv = WriteMakefile (%wmf);

package MY;

sub postamble {
    my $mpm = (-d ".git" && -x "2lib")
        ? "lib/App/ccdiff.pm: ccdiff\n\tperl ./2lib\n"
        : "";
    join "\n" =>
        'spellcheck:',
        '	pod-spell-check --aspell --ispell ccdiff',
        '',
        'tgzdist: lib/App/ccdiff.pm spellcheck distmeta $(DISTVNAME).tar.gz distcheck',
        '	-@mv -f $(DISTVNAME).tar.gz $(DISTVNAME).tgz',
        '	-@cpants_lint.pl $(DISTVNAME).tgz',
        '	-@rm -f Debian_CPANTS.txt',
        '',
        $mpm;
    } # postamble

1;
