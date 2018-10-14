use 5.12.1;
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
	"Algorithm::Diff"	=> 0,
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
	resources		=> {
	    type		=> "git",
	    url			=> "git://github.com/Tux/App-ccdiff.git",
	    web			=> "https://github.com/Tux/App-ccdiff",
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
		'all::			lib/App/ccdiff.pm doc spellcheck',
		)
        : ();
    join "\n" =>
        'spellcheck:',
        '	pod-spell-check --aspell --ispell ccdiff',
        '',
        'meta:			META.json META.yml',
        'META.json META.yml:	ccdiff Makefile.PL',
        '	-@make metafile',
        '	-@mv $(DISTVNAME)/META.* .',
        '	-@rm -rf $(DISTVNAME)',
        '',
        'tgzdist: lib/App/ccdiff.pm META.json spellcheck $(DISTVNAME).tar.gz distcheck',
        '	-@mv -f $(DISTVNAME).tar.gz $(DISTVNAME).tgz',
        '	-@cpants_lint.pl $(DISTVNAME).tgz',
        '	-@rm -f Debian_CPANTS.txt',
        '',
	'doc:			doc/ccdiff.md doc/ccdiff.html doc/ccdiff.man doc/README.md',
	'doc/ccdiff.md:		ccdiff',
	'	pod2markdown  < $? > $@',
	'doc/ccdiff.html:	ccdiff',
	'	pod2html      < $? 2>&1 | grep -v "^Cannot find" > $@',
	'doc/ccdiff.3:		ccdiff',
	'	pod2man	      < $? > $@',
	'doc/ccdiff.man:	doc/ccdiff.3',
	'	nroff -mandoc < $? > $@',
	'doc/README.md:		README.md',
	'	cp -p $? $@',
        @mpm;
    } # postamble

1;
