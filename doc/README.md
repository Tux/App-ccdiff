# App-ccdiff

A colored diff that also colors inside changed lines

# Synopsis
```
usage: ccdiff [options] file1 [file2]
       ccdiff --help | --man | --info
	file1 or file2 can be - (but not both)
```
# Description

All command-line tools that show the difference between two files fall
short in showing minor changes visually usefully. This tool tries to give
the look and feel of `diff --color` or `colordiff`, but extending the
display of colored output from red for deleted lines and green for added
lines to red for deleted characters and green for added characters within
the changed lines.

The tool has options to choose your own favorite color combinations, as
long as they are supported by
[Term::ANSIColor](https://metacpan.org/pod/Term::ANSIColor).

If you want no colors but indicators below the removed/added characters
in the output, which is very useful if you want to email the output, the
option `--no-color` adds those indicators. With the `--fancy` option you
will get Unicode characters.

# Installation

Change the first line of `ccdiff` to start your favorite perl interpreter
and then move the file to a folder in your `$PATH`, or install from CPAN:
```
$ cpan App::ccdiff
```

# Alternatives

## Command line / CLI

 * `diff`

 * `diff --color`

 * `colordiff`

 * `klondiff`

 * `git`

   This however requires a long command:
```
$ git -c color.diff.new='bold reverse green' \
         -c color.diff.old='bold reverse red'   \
         diff --no-index -U0 --no-color \
              --word-diff=color --word-diff-regex=. \
             <file1> <file2>
```
   An alternative for integration with git is `diff-so-fancy`

## ASCII

 * `vimdiff`

## GUI

Please never use the `xdiff` command (if available at all), because it is
included in many distributions and/or packages and they all work different
or not at all. Some at not intended to be invoked from the command line.

The list is in increasing clarity of the tool being able to show *minor*
changes in lines visually outstanding:

 * `mgdiff` (C, X11)

 * `diffuse` (Python)

 * `bcompare` (C, X11, not freeware/opensource)

 * `kompare` (C, X11, KDE)

 * `xxdiff` (C, X11)

 * `meld` (Python)

 * `kdiff3` (C, X11, Qt)

 * `tkdiff` (Tcl/Tk)

## Other (not checked yet)

Reasons for not checking include Windows and emacs.

 * araxis
 * bc
 * bc3
 * codecompare
 * deltaworker
 * diffmerge
 * ecmerge
 * emerge
 * examdiff
 * guiffy
 * gvimdiff2
 * gvimdiff3
 * opendiff
 * p4merge
 * winmerge

# Dependencies

This tool will run on recent perl distributions that have
[Algorithm::Diff](https://metacpan.org/pod/Algorithm::Diff)
installed. The modules
[Term::ANSIColor](https://metacpan.org/pod/Term::ANSIColor)
and [Getopt::Long](https://metacpan.org/pod/Getopt::Long)
that are also used are part of the perl CORE distribution
since at least version 5.6.0.
```
 suse#   zypper in perl-Algorithm-Diff

 centos# yum install -y perl-Algorithm-Diff

 other#  cpan Algorithm::Diff
```
# Git integration

You can use ccdiff to show diffs in git. It may work like this:
```
$ git config --global diff.tool ccdiff
$ git config --global difftool.prompt false
$ git config --global difftool.ccdiff.cmd 'ccdiff --utf-8 -u -r $LOCAL $REMOTE'
$ git difftool SHA~..SHA
$ wget https://github.com/Tux/App-ccdiff/raw/master/Files/git-ccdiff \
    -O ~/bin/git-ccdiff
$ perl -pi -e 's{/pro/bin/perl}{/usr/bin/env perl}' ~/bin/git-ccdiff
$ chmod 755 ~/bin/git-ccdiff
$ git ccdiff SHA
```

Of course you can use `curl` instead of `wget` and you can choose your own
(fixed) path to `perl` instead of using `/usr/bin/env`.

## LIMITATIONS

There is no provision (yet) for coping with double-width characters.

Large datasets may consume all available memory, causing the diff to fail.

Not all that can be set from the configuration files can be overruled by
command-line options.

## LICENSE

The Artistic License 2.0

Copyright (c) 2018-2022 H.Merijn Brand
