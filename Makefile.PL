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
    MIN_PERL_VERSION   => "5.014000",
    PREREQ_PM          => {
	charnames		=> 0,
	"Algorithm::Diff"	=> 0,
	"Term::ANSIColor"	=> 0,
	"Getopt::Long"		=> 0,
	},
    LICENSE            => "artistic_2",
    CONFIGURE_REQUIRES => { "ExtUtils::MakeMaker" => 0 },
    TEST_REQUIRES      => { "Test::More"          => 0 },
    macro              => { TARFLAGS => "--format=ustar -c -v -f", },
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
        'META.json META.yml:	ccdiff',
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
