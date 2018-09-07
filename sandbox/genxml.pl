#!/pro/bin/perl

use 5.16.3;
use warnings;

my $n = 0;
my @chr = map { chr } 0x20, 0x23, 0x2b, 0x30..0x3b, 0x3f..0x5a, 0x5e..0x6a;
my $x = qq{<?xml version="1.0" encoding="utf-8"?>\n<tags><tag id="test">ccdiff</tag>};
$x .= join "" => map { qq{<tag id="}.$n++.qq{">}.$chr[int rand @chr]."</tag>" } 0..600;
$x .= qq{</tags>};

open my $fh, ">", "test1.xml";
say   $fh $x;
close $fh;
open  $fh, ">", "test2.xml";
say   $fh $x =~ s/"569">\K./!/r;
close $fh;
