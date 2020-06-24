#!/usr/bin/env perl

use 5.014000;
use warnings;

use Test::More;
use Capture::Tiny "capture";

binmode STDOUT, ":encoding(utf-8)";
binmode STDERR, ":encoding(utf-8)";
binmode DATA,   ":encoding(utf-8)";

# localtime will differ on other machines
my %stamp = map { s{^Files/}{}r => "$_ ".localtime ((stat)[9]) } glob "Files/*";

local $/ = "** EOT **\n";
while (<DATA>) {
    chomp;
    my ($dsc, $f1, $f2, $opt, $exp) = split m/\n/, $_, 5;
    $exp =~ s/STAMP:1/$stamp{$f1}/g;
    $exp =~ s/STAMP:2/$stamp{$f2}/g;
    #diag "Description: $dsc";
    #diag "Options:     $opt";
    my @cmd = ($^X, "ccdiff", "--utf-8", "--no-color", "Files/$f1", "Files/$f2");
    $opt and push @cmd, split m/ / => $opt;
    #diag "@cmd";
    my ($out, $err, $exit) = capture { system @cmd; };
    is ($out, $exp, $dsc);
    is ($err, "", "No error");
    is ($exit, 0, "Success");
    }

done_testing;

__END__
No options
01_1.txt
01_2.txt

< Files/01_1.txt Mon Oct  8 17:19:46 2018
> Files/01_2.txt Mon Oct  8 18:03:59 2018
3,3c3,3
< usu. Ad duo posse theophrastus, vim in accumsan
---
> usu. Ad duo posse theophrastus. Vim in accumsan
** EOT **
Unified with header
01_1.txt
01_2.txt
-u0
--- STAMP:1
+++ STAMP:2
3,3c3,3
-usu. Ad duo posse theophrastus, vim in accumsan
+usu. Ad duo posse theophrastus. Vim in accumsan
** EOT **
No header
01_1.txt
01_2.txt
--no-header
3,3c3,3
< usu. Ad duo posse theophrastus, vim in accumsan
---
> usu. Ad duo posse theophrastus. Vim in accumsan
** EOT **
Unified with header
01_1.txt
01_2.txt
-u0
--- STAMP:1
+++ STAMP:2
3,3c3,3
-usu. Ad duo posse theophrastus, vim in accumsan
+usu. Ad duo posse theophrastus. Vim in accumsan
** EOT **
Unified without header
01_1.txt
01_2.txt
-u0 --no-header
3,3c3,3
-usu. Ad duo posse theophrastus, vim in accumsan
+usu. Ad duo posse theophrastus. Vim in accumsan
** EOT **
Unified with ascii markers
01_1.txt
01_2.txt
-mau0 --no-header
3,3c3,3
-usu. Ad duo posse theophrastus, vim in accumsan
-                              ^ ^
+usu. Ad duo posse theophrastus. Vim in accumsan
+                              ^ ^
** EOT **
Unified with unicode markers
01_1.txt
01_2.txt
-mu0 --no-header
3,3c3,3
-usu. Ad duo posse theophrastus, vim in accumsan
-                              ▼ ▼
+usu. Ad duo posse theophrastus. Vim in accumsan
+                              ▲ ▲
** EOT **
Unified with ascii markers and context
01_1.txt
01_2.txt
-mau1
--- STAMP:1
+++ STAMP:2
3,3c3,3
 id vix cibo omittantur, et impetus offendit convenire
-usu. Ad duo posse theophrastus, vim in accumsan
-                              ^ ^
+usu. Ad duo posse theophrastus. Vim in accumsan
+                              ^ ^
 efficiantur, sed in congue decore. Ex nullam iudicabit
** EOT **
Unified with ascii verbose 1
01_1.txt
01_2.txt
-au0 -v1 --no-header
3,3c3,3
-usu. Ad duo posse theophrastus, vim in accumsan
- -- verbose : COMMA, LATIN SMALL LETTER V
+usu. Ad duo posse theophrastus. Vim in accumsan
+ -- verbose : FULL STOP, LATIN CAPITAL LETTER V
** EOT **
Unified with unicode verbose 1
01_1.txt
01_2.txt
-u0 -v1 --no-header
3,3c3,3
-usu. Ad duo posse theophrastus, vim in accumsan
- -- verbose : COMMA, LATIN SMALL LETTER V
+usu. Ad duo posse theophrastus. Vim in accumsan
+ -- verbose : FULL STOP, LATIN CAPITAL LETTER V
** EOT **
Unified with ascii verbose 2
01_1.txt
01_2.txt
-au0 -v2 --no-header
3,3c3,3
-usu. Ad duo posse theophrastus>,< >v<im in accumsan
- -- verbose : COMMA, LATIN SMALL LETTER V
+usu. Ad duo posse theophrastus>.< >V<im in accumsan
+ -- verbose : FULL STOP, LATIN CAPITAL LETTER V
** EOT **
Unified with unicode verbose 2
01_1.txt
01_2.txt
-u0 -v2 --no-header
3,3c3,3
-usu. Ad duo posse theophrastus↱,↰ ↱v↰im in accumsan
- -- verbose : COMMA, LATIN SMALL LETTER V
+usu. Ad duo posse theophrastus↱.↰ ↱V↰im in accumsan
+ -- verbose : FULL STOP, LATIN CAPITAL LETTER V
** EOT **
