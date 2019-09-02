requires   "Algorithm::Diff"          => "1.1901";
requires   "Getopt::Long";
requires   "Term::ANSIColor";
requires   "charnames";

recommends "Algorithm::Diff"          => "1.1903";

on "configure" => sub {
    requires   "ExtUtils::MakeMaker";
    };

on "build" => sub {
    requires   "Config";
    };

on "test" => sub {
    requires   "Capture::Tiny";
    requires   "Test::More";
    };
