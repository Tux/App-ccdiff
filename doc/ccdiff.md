# NAME

ccdiff - Colored Character diff

# SYNOPSIS

    ccdiff [options] file1|- file2|-

    ccdiff --help
    ccdiff --man
    ccdiff --info

# DESCRIPTION

# OPTIONS

## Command line options

- --help -?

    Show a summary of the available command-line options and exit.

- --version -V

    Show the version and exit.

- --man

    Show this manual using pod2man and nroff.

- --info

    Show this manual using pod2text.

- --utf-8 -U

    All I/O (streams to compare and standard out) are in UTF-8.

- --unified\[=3\] -u \[3\]

    Generate a unified diff. The number of context lines is optional. When omitted
    it defaults to 3. Currently there is no provision of dealing with overlapping
    diff chunks. If the common part between two diff chunks is shorter than twice
    the number of context lines, some lines may show twice.

    The default is to use traditional diff:

        5,5c5,5
        < Sat Dec 18 07:00:33 1993,I.O.D.U.,,756194433,1442539
        ---
        > Sat Dec 18 07:08:33 1998,I.O.D.U.,,756194433,1442539

    a unified diff (-u1) would be

        5,5c5,5
         Tue Sep  6 05:43:59 2005,B.O.Q.S.,,1125978239,1943341
        -Sat Dec 18 07:00:33 1993,I.O.D.U.,,756194433,1442539
        +Sat Dec 18 07:08:33 1998,I.O.D.U.,,756194433,1442539
         Mon Feb 23 10:37:02 2004,R.X.K.S.,van,1077529022,1654127

- --verbose\[=1\] -v\[1\]

    Show an additional line for each old or new section in a change chunk (not for
    added or deleted lines) that shows the hexadecimal value of each character. If
    `--utf-8` is in effect, it will show the Unicode character name(s).

    This is a debugging option, so invisible characters can still be "seen".

    `--verbose` accepts an optional verbosity-level. On level 2 and up, all
    horizontal changes get left-and-right markers inserted to enable seeing the
    location of the ZERO WIDTH or invisible characters. With level 3 and up and
    Unicode enabled, the changed characters will also show the codepoint in hex.

    An example of this:

    With -Uu0v0:

        1,1c1,1
        - A  BCDE Fg
        + A BcdE​Fg

    With -Uu0v1:

        1,1c1,1
        - A  BCDE Fg
        - -- verbose : SPACE, LATIN CAPITAL LETTER C, LATIN CAPITAL LETTER D, SPACE
        + A BcdE​Fg
        + -- verbose : LATIN SMALL LETTER C, LATIN SMALL LETTER D, ZERO WIDTH SPACE

    With -Uu0v2:

        1,1c1,1
        - A ↱ ↰B↱CD↰E↱ ↰Fg
        - -- verbose : SPACE, LATIN CAPITAL LETTER C, LATIN CAPITAL LETTER D, SPACE
        + A B↱cd↰E↱​↰Fg
        + -- verbose : LATIN SMALL LETTER C, LATIN SMALL LETTER D, ZERO WIDTH SPACE

    With -Uu0v3:

        1,1c1,1
        - A ↱ ↰B↱CD↰E↱ ↰Fg
        - -- verbose : SPACE (U+000020), LATIN CAPITAL LETTER C (U+000043), LATIN CAPITAL LETTER D (U+000044), SPACE (U+000020)
        + A B↱cd↰E↱​↰Fg
        + -- verbose : LATIN SMALL LETTER C (U+000063), LATIN SMALL LETTER D (U+000064), ZERO WIDTH SPACE (U+00200B)

    With -Uu0v2 --ascii:

        1,1c1,1
        - A > <B>CD<E> <Fg
        - -- verbose : SPACE, LATIN CAPITAL LETTER C, LATIN CAPITAL LETTER D, SPACE
        + A B>cd<E>​<Fg
        + -- verbose : LATIN SMALL LETTER C, LATIN SMALL LETTER D, ZERO WIDTH SPACE

    the word "verbose" and the character markers will be displayed using the
    `verbose` color. The characters used for the markers can be defined in your
    configuration file as `chr_cml` (the character used as marker on the left)
    and `chr_cmr` (the character used as marker on the right).

- --markers -m

    Use markers under each changed character in change-chunks.

    `--markers` is especially useful if the terminal does not support colors, or
    if you want to copy/paste the output to (ASCII) mail. See also `--ascii`. The
    markers will have the same color as added or deleted text.

    This will look like (with unified diff):

        5,5c5,5
        -Sat Dec 18 07:08:33 1998,I.O.D.U.,,756194433,1442539
        -               ▼       ▼
        +Sat Dec 18 07:00:33 1993,I.O.D.U.,,756194433,1442539
        +               ▲       ▲

    The characters used for the markers can be defined in your configuration file
    as `chr_old` (the character used as marker under removed characters) and
    `chr_new` (the character used as marker under added characters).

    If `--ellipsis` is also in effect and either the `chr_eli` is longer than
    one character or `--verbose` level is over 2, this option is automatically
    disabled.

- --ascii -a

    Use (colored) ASCII indicators instead of Unicode. The default indicators are
    Unicode characters that stand out better. The markers will have the same color
    as added or deleted text.

    For the vertical markers (`-m`) that would look like:

        5,5c5,5
        -Sat Dec 18 07:08:33 1998,I.O.D.U.,,756194433,1442539
        -               ^       ^
        +Sat Dec 18 07:00:33 1993,I.O.D.U.,,756194433,1442539
        +               ^       ^

    For the positional indicators, I did consider using U+034e (COMBINING UPWARDS
    ARROW BELOW), but as most terminals are probably unable to show it due to line
    height changes, I did not pursue the idea.

- --pink -p

    Change the default `red` for deleted text to the color closest to pink that
    is supported by [Term::ANSIColor](https://metacpan.org/pod/Term%3A%3AANSIColor): `magenta`.

- --reverse -r

    Reverse/invert the foreground and background for the colored indicators.

    If the foreground color has `bold`, it will be stripped from the new background
    color.

- --swap -s

    Swap the colors for new and old.

- --list-colors

    List available colors and exit.

- --no-colors

    Disable all colors. Useful for redirecting the diff output to a file that is to
    be included in documentation.

    This is the default if the environment variable `$NO_COLOR` has a true value or
    if the environment variable `$CLICOLOR` is set to a false value.  If set,
    `$CLICOLOR_FORCE` will overrule the default of `$NO_COLOR`.

- --old=color

    Define the foreground color for deleted text.

- --new=color

    Define the foreground color for added text.

- --bg=color

    Define the background color for changed text.

- --index --idx -I

    Prefix position indicators with an index.

        [001] 5,5c5,5
        -Sat Dec 18 07:08:33 1998,I.O.D.U.,,756194433,1442539
        +Sat Dec 18 07:00:33 1993,I.O.D.U.,,756194433,1442539

    If a positive number is passed (`--index=4` or `-I 4`), display just the
    chunk with that index, using the `verbose` color:

    This is useful in combination with `--verbose`.

- --threshold=2 -t 2

    Defines the number of lines a change block may differ before the fall-back of
    horizontal diff to vertical diff.

    If a chunk describes a change, and the number of lines in the original block
    has fewer or more lines than the new block and that difference exceeds this
    threshold, `ccdiff` will fall-back to vertical diff.

- --heuristics=n -h n

    Defines the percentage of character-changes a change block may differ before
    the fall-back of horizontal diff to vertical diff.

    This percentage is calculated as `(characters removed + characters added) /
    (2 * characters unchanged))`.

- --ellipsis=n -e n

    Defines the number of characters to keep on each side of a horizontal-equal
    segment. The default is `0`, meaning do not compress.

    If set to a positive number, and the length of a segment of equal characters
    inside a horizontal diff is longer than twice this value, the middle part is
    replaced with `┈ U02508 \N{BOX DRAWINGS LIGHT QUADRUPLE DASH HORIZONTAL}`
    (instead of … U02026, as HORIZONTAL ELLIPSIS does not stand out enough).

    With `-u0me3` that would be like

        5,5c5,5
        -Sat┈07:08:33┈ 1998,I.┈539
        -        ▼        ▼
        +Sat┈07:00:33┈ 1993,I.┈539
        +        ▲        ▲

    With `-u0e3 -v2` like

        5,5c5,5
        -Sat↤9↦07:0↱0↰:33 199↱3↰,I.↤23↦539
        - -- verbose : DIGIT ZERO, DIGIT THREE
        +Sat↤9↦07:0↱8↰:33 199↱8↰,I.↤23↦539
        + -- verbose : DIGIT EIGHT, DIGIT EIGHT

    The text used for the replaced text can be defined in your configuration file
    as `chr_eli` and/or `chr_eli_v`.

- --ignore-case -i

    Ignore case on comparison.

- --ignore-all-space -w

    Ignore all white-space changes. This will set all options `-b`, `-Z`, `-E`,
    and `-B`.

- --ignore-trailing-space -Z

    Ignore changes in trailing white-space (tabs and spaces).

- --ignore-ws|ignore-space-change -b

    Ignore changes in horizontal white-space (tabs and spaces). This does not
    include white-space changes that split non-white-space or remove white-space
    between two non-white-space elements.

- --ignore-tab-expansion -E

    NYI

- --ignore-blank-lines -B

    **Just Partly Implemented** (WIP)

## Configuration files

In order to be able to overrule the defaults set in `ccdiff`, one can set
options specific for this login. The following option files are looked for
in this order:

    - $HOME/ccdiff.rc
    - $HOME/.ccdiffrc
    - $HOME/.config/ccdiff

and evaluated in that order. Any options specified in a file later in that
chain will overwrite previously set options.

Option files are only read and evaluated if they are not empty and not writable
by others than the owner.

The syntax of the file is one option per line, where leading and trailing
white-space is ignored. If that line then starts with one of the options
listed below, followed by optional white-space followed by either an `=` or
a `:`, followed by optional white-space and the values, the value is assigned
to the option. The values `no` and `false` (case insensitive) are aliases
for `0`. The values `yes` and `true` are aliases to `-1` (`-1` being a
true value).

Between parens is the corresponding command-line option.

- unified (-u)

    If you prefer unified-diff over old-style diff by default, set this to the
    desired number of context lines:

        unified : 3

    The default is undefined

- markers (-m)

        markers : false

    Defines if markers should be used under changed characters. The default is to
    use colors only. The `-m` command line option will toggle the option when set
    from a configuration file.

- ascii (-a)

        ascii   : false

    Defines to use ASCII markers instead of Unicode markers. The default is to use
    Unicode markers.

- reverse (-r)

        reverse : false

    Defines if changes are displayed as foreground-color over background-color
    or background-color over foreground-color. The default is `false`, so it will
    color the changes with the appropriate color (`new` or `old`) over the
    default background color.

- swap (-s)

        swap    : false

    Swap the colors for new and old.

- new (--new)

        new     : green

    Defines the color to be used for added text. The default is `green`.

    The color `none` is also accepted and disables this color.

    Any color accepted by [Term::ANSIColor](https://metacpan.org/pod/Term%3A%3AANSIColor) is allowed. Any other color will
    result in a warning. This option can include `bold` either as prefix or
    as suffix.

    This option may also be specified as

        new-color
        new_color
        new-colour
        new_colour

- old (--old)

        old     : red

    Defines the color to be used for deleted text. The default is `red`.

    The color `none` is also accepted and disables this color.

    Any color accepted by [Term::ANSIColor](https://metacpan.org/pod/Term%3A%3AANSIColor) is allowed. Any other color will
    result in a warning. This option can include `bold` either as prefix or
    as suffix.

    This option may also be specified as

        old-color
        old_color
        old-colour
        old_colour

- bg (--bg)

        bg      : white

    Defines the color to be used as background for changed text. The default is
    `white`.

    The color `none` is also accepted and disables this color.

    Any color accepted by [Term::ANSIColor](https://metacpan.org/pod/Term%3A%3AANSIColor) is allowed. Any other color will
    result in a warning. The `bold` attribute is not allowed.

    This option may also be specified as

        bg-color
        bg_color
        bg-colour
        bg_colour
        background
        background-color
        background_color
        background-colour
        background_colour

- header (-H --header --HC=color --header-color=color)

        header  : 1
        header  : blue_on_white

    Defines if a header is displayed above the diff (default is 1), supported
    colors are allowed.

    If the value is a valid supported color, it will show the header in that
    color scheme.  To disable the header set it to `0` in the RC file or use
    `--no-header` as a command line argument.

- verbose

        verbose : cyan

    Defines the color to be used as color for the verbose tag. The default is
    `cyan`. This color will only be used under `--verbose`.

    The color `none` is also accepted and disables this color.

    Any color accepted by [Term::ANSIColor](https://metacpan.org/pod/Term%3A%3AANSIColor) is allowed. Any other color will
    result in a warning.

    This option may also be specified as

        verbose-color
        verbose_color
        verbose-colour
        verbose_colour

- utf8 (-U)

        utf8    : yes

    Defines whether all I/O is to be interpreted as UTF-8. The default is `no`.

    This option may also be specified as

        unicode
        utf
        utf-8

- index (-I)

        index   : no

    Defines if the position indication for a change chunk is prefixed with an
    index number. The default is `no`. The index is 1-based.

    Without this option, the position indication would be like

        5,5c5,5
        19,19d18
        42a42,42

    with this option, it would be

        [001] 5,5c5,5
        [002] 19,19d18
        [005] 42a42,42

    When this option contains a positive integer, `ccdiff` will only show the
    diff chunk with that index.

- emacs

        emacs   : no

    If this option is yes/true, calling `ccdiff` with just one single argument,
    and that argument being an existing file, the arguments will act as

        $ ccdiff file~ file

    if file~ exists.

- threshold (-t)

        threshold : 2

    Defines the number of lines a change block may differ before the fall-back of
    horizontal diff to vertical diff.

- heuristics (-h)

        heuristics : 40

    Defines the percentage of character-changes a change block may differ before
    the fall-back of horizontal diff to vertical diff. The default is undefined,
    meaning no fallback based on heuristics.

- ellipsis (-e)

        ellipsis : 0

    Defines the number of characters to keep on each side of a horizontal-equal
    segment. The default is `0`, meaning to not compress. See also `chr_eli`.

- chr\_old

        chr_old : U+25BC

    Defines the character used to indicate the position of removed text on the
    line below the text when option `-m` is in effect.

- chr\_new

        chr_new : U+25B2

    Defines the character used to indicate the position of added text on the
    line below the text when option `-m` is in effect.

- chr\_cml

        chr_cml : U+21B1

    Defines the character used to indicate the starting position of changed text
    in a line when verbose level is 3 and up.

- chr\_cmr

        chr_cmr : U+21B0

    Defines the character used to indicate the ending position of changed text
    in a line when verbose level is 3 and up.

- chr\_eli

        chr_eli : U+21B0

    Defines the character used to indicate omitted text in large unchanged text
    when `--ellipsis`/`-e` is in effect.

    This character is not equally well visible on all terminals or in all fonts,
    so you might want to change it to something that stands out better in your
    environment. Possible suggestions:

        … U+2026 HORIZONTAL ELLIPSIS
        ‴ U+2034 TRIPLE PRIME
        ‷ U+2037 REVERSED TRIPLE PRIME
        ↔ U+2194 LEFT RIGHT ARROW
        ↭ U+21ad LEFT RIGHT WAVE ARROW
        ↮ U+21ae LEFT RIGHT ARROW WITH STROKE
        ↹ U+21b9 LEFTWARDS ARROW TO BAR OVER RIGHTWARDS ARROW TO BAR
        ⇄ U+21c4 RIGHTWARDS ARROW OVER LEFTWARDS ARROW
        ⇆ U+21c6 LEFTWARDS ARROW OVER RIGHTWARDS ARROW
        ⇎ U+21ce LEFT RIGHT DOUBLE ARROW WITH STROKE
        ⇔ U+21d4 LEFT RIGHT DOUBLE ARROW
        ⇹ U+21f9 LEFT RIGHT ARROW WITH VERTICAL STROKE
        ⇼ U+21fc LEFT RIGHT ARROW WITH DOUBLE VERTICAL STROKE
        ⇿ U+21ff LEFT RIGHT OPEN-HEADED ARROW
        ≋ U+224b TRIPLE TILDE
        ┄ U+2504 BOX DRAWINGS LIGHT TRIPLE DASH HORIZONTAL
        ┅ U+2505 BOX DRAWINGS HEAVY TRIPLE DASH HORIZONTAL
        ┈ U+2508 BOX DRAWINGS LIGHT QUADRUPLE DASH HORIZONTAL
        ┉ U+2509 BOX DRAWINGS HEAVY QUADRUPLE DASH HORIZONTAL
        ⧻ U+29fb TRIPLE PLUS
        ⬌ U+2b0c LEFT RIGHT BLACK ARROW

- chr\_eli\_v

        chr_eli_v : U+21A4U+21A6

    When using `--ellipsis` with `--verbose` level 2 or up, the single character
    indicator will be replaced with this character. If it is 2 characters wide, the
    length of the compressed part is put between the characters.

    A suggested alternative might be U+21E4U+21E5

# Git integration

You can use ccdiff to show diffs in git. It may work like this:

    $ git config --global diff.tool ccdiff
    $ git config --global difftool.prompt false
    $ git config --global difftool.ccdiff.cmd 'ccdiff --utf-8 -u -r $LOCAL $REMOTE'
    $ git difftool SHA~..SHA
    $ wget https://github.com/Tux/App-ccdiff/raw/master/Files/git-ccdiff \
       -O ~/bin/git-ccdiff
    $ perl -pi -e 's{/pro/bin/perl}{/usr/bin/env perl}' ~/bin/git-ccdiff
    $ chmod 755 ~/bin/git-ccdiff
    $ git ccdiff SHA

Of course you can use `curl` instead of `wget` and you can choose your own
(fixed) path to `perl` instead of using `/usr/bin/env`.

From then on you can do

    $ git ccdiff
    $ git ccdiff 5c5a39f2

# CAVEATS

Due to the implementation, where both sides of the comparison are completely
kept in memory, this tool might not be able to deal with (very) large datasets.

## Speed

There are situations where [Algorithm::Diff](https://metacpan.org/pod/Algorithm%3A%3ADiff) takes considerably more time
compared to e.g. GNU diff. Installing [Algorithm::Diff::XS](https://metacpan.org/pod/Algorithm%3A%3ADiff%3A%3AXS) will make
`ccdiff` a lot faster. `ccdiff` will choose [Algorithm::Diff::XS](https://metacpan.org/pod/Algorithm%3A%3ADiff%3A%3AXS) if
available.

# SEE ALSO

[Algorithm::Diff::XS](https://metacpan.org/pod/Algorithm%3A%3ADiff%3A%3AXS), [Algorithm::Diff](https://metacpan.org/pod/Algorithm%3A%3ADiff), [Text::Diff](https://metacpan.org/pod/Text%3A%3ADiff)

# AUTHOR

H.Merijn Brand

# COPYRIGHT AND LICENSE

    Copyright (C) 2018-2022 H.Merijn Brand.  All rights reserved.

This library is free software;  you can redistribute and/or modify it under
the same terms as The Artistic License 2.0.
