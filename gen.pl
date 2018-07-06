#!/pro/bin/perl

use 5.18.2;
use warnings;

say "Date,Initials,Voorv,Stamp,ID";
my @vv = qw( van der de aan );
for (0 .. 40) {
    my $dt = int rand time;
    my $in = join "" => map { chr (0x41 + int rand 26)."." } 0..3;
    my $vv = $vv[int rand 20] || "";
    my $id = 1000000 + int rand 1000000;
    say join "," => scalar localtime $dt, $in, $vv, $dt, $id;
    }
