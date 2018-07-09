# App-ccdiff

A colored diff that also colors inside changed lines

# Synopsis
```
usage: ccdiff: [options] file1 [file2]
        file1 or file2 can be - (but not both)
   -V    --version    Show version and exit
  Diff options:
   -u[3] --unified=3  Show a unified diff (WIP)
   -w    --ignore-whitespace
                      Ignore whitespace changes
  Color options:
         --no-color   Do not use colors
         --old=red    Color to indicate removed content
         --new=green  Color to indicate added   content
         --bg=white   Background color for colored indicators
   -p    --pink       Shortcut for --old=magenta
   -f    --fancy      Use Unicode indicators instead of ^
   -r    --reverse    Reverse the colors of the indicators
```
# Description

All command-line tools that show the difference between two files fall
short in showing minor changes visuably useful. This tool tries to give
the look and feel of `diff --color` or `colordiff`, but extending the
display of colored output from red for deleted lines and green for added
lines to red for deleted characters and green for added characters within
the changed lines.

The tool has options to choose your own favorite color combinations, as
long as they are supported by
[https://metacpan.org/pod/Term::ANSIColor|Term::ANSIColor].

If you want no colors but indicators below the removed/added characters
in the output, which is very useful if you want to email the output, the
option `--no-color` adds those indicators. With the `--fancy` option you
will get Unicode characters.

# Installation

Change the first line of `ccdiff` to start your favorite perl interpreter
and then move the file to a folder in your `$PATH`.

# Alternatives

## Command line / CLI

 * `diff`

 * `diff --color`

 * `colordiff`

 * `git`

   This however requires a long command:
```
$ git -c color.diff.new='bold reverse green' \
         -c color.diff.old='bold reverse red'   \
         diff --no-index -U0 --no-color \
              --word-diff=color --word-diff-regex=. \
             <file1> <file2>
```
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

# Dependencies

This tool will run on recent perl distributions that have
[https://metacpan.org/pod/Algorithm::Diff|Algorithm::Diff]
installed. The modules
[https://metacpan.org/pod/Term::ANSIColor|Term::ANSIColor]
and [https://metacpan.org/pod/Getopt::Long|Getopt::Long]
that are also used are part of the perl CORE distribution
since at least version 5.6.0.
```
 suse#   zypper in perl-Algorithm-Diff

 centos# yum install -y perl-Algorithm-Diff

 other#  cpan Algorithm::Diff
```
## LICENSE

The Artistic License 2.0

Copyright (c) 2018-2018 H.Merijn Brand
