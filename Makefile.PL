use 5.014000;
use warnings;

use ExtUtils::MakeMaker;

my $VERSION;
open my $fh, "<", "ccdiff";
while (<$fh>) {
    m/VERSION\s*=\s*["']?([0-9.]+)/ or next;
    $VERSION = $1;
    last;
    }
close $fh;

my %wmf = (
    NAME			=> "App::ccdiff",
    DISTNAME			=> "App-ccdiff",
    ABSTRACT			=> "Colored Character Diff",
    AUTHOR			=> "H.Merijn Brand",
    EXE_FILES			=> [ "ccdiff" ],
    VERSION			=> $VERSION,
    MIN_PERL_VERSION		=> "5.014000",
    PREREQ_PM			=> {
	charnames		=> 0,
	"Algorithm::Diff"	=> "1.1901",
	"List::Util"		=> 0,
	"Term::ANSIColor"	=> 0,
	"Getopt::Long"		=> 0,
	},
    CONFIGURE_REQUIRES		=> {
	"ExtUtils::MakeMaker"	=> 0,
	},
    TEST_REQUIRES		=> {
	"Test::More"		=> 0,
	"Capture::Tiny"		=> 0,
	},
    LICENSE			=> "artistic_2",
    macro			=> { TARFLAGS => "--format=ustar -c -v -f", },

    META_MERGE			=> {
	"meta-spec"		=> { version => 2 },
	licence			=> "artistic_2",
	resources		=> {
	    type		=> "git",
	    url			=> "git://github.com/Tux/App-ccdiff.git",
	    web			=> "https://github.com/Tux/App-ccdiff",
	    IRC			=> "irc://irc.perl.org/#csv",
	    },
	provides		=> {
	    "App::ccdiff"	=> {
		file		=> "ccdiff",
		version		=> $VERSION,
		},
	    },
	},
    );

eval { ExtUtils::MakeMaker->VERSION (6.63_03) } or
    delete $wmf{TEST_REQUIRES};

my $rv = WriteMakefile (%wmf);

package MY;

sub postamble {
    my @mpm = (-d ".git" && -x "2lib")
        ? ( '','lib/App/ccdiff.pm:	ccdiff',
		'	perl ./2lib',
		'',
		'all::			lib/App/ccdiff.pm doc spellcheck cpanfile',
		)
        : ();
    -d "xt" && ($ENV{AUTOMATED_TESTING} || 0) != 1 and
	push @mpm =>
	    '',
	    'test ::',
	    '	-@env TEST_FILES="xt/*.t" make -e test_dynamic';
    join "\n" =>
        'cpanfile:',
        '	perl sandbox/genMETA.pl',
        '',
        'spellcheck:',
        '	pod-spell-check --aspell --ispell ccdiff',
        '',
	'checkmeta:	spellcheck',
	'	perl sandbox/genMETA.pl -c',
	'',
	'fixmeta:	distmeta',
	'	perl sandbox/genMETA.pl',
	'',
        'tgzdist: lib/App/ccdiff.pm doc checkmeta fixmeta $(DISTVNAME).tar.gz distcheck',
        '	-@mv -f $(DISTVNAME).tar.gz $(DISTVNAME).tgz',
        '	-@cpants_lint.pl $(DISTVNAME).tgz',
        '	-@rm -f Debian_CPANTS.txt',
        '',
	'doc docs:		doc/ccdiff.md doc/ccdiff.html doc/ccdiff.man doc/README.md',
	'doc/ccdiff.md:		ccdiff',
	'	pod2markdown  < $? > $@',
	'doc/ccdiff.html:	ccdiff',
	'	pod2html      < $? 2>&1 | grep -v "^Cannot find" > $@',
	'doc/ccdiff.3:		ccdiff',
	'	pod2man	      < $? > $@',
	'doc/ccdiff.man:	doc/ccdiff.3',
	'	nroff2man     < $? > $@',
	'doc/README.md:		README.md',
	'	cp -p $? $@',
        @mpm;
    } # postamble

1;
