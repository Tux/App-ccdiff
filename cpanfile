requires   "Algorithm::Diff"          => "1.1901";
requires   "Getopt::Long";
requires   "List::Util";
requires   "Term::ANSIColor";
requires   "charnames";

recommends "Algorithm::Diff"          => "1.201";
recommends "Algorithm::Diff::XS"      => "0.04";

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
