requires   "Algorithm::Diff"          => "1.1901";
requires   "Getopt::Long";
requires   "List::Util";
requires   "Term::ANSIColor";
requires   "charnames";

recommends "Algorithm::Diff"          => "1.201";
recommends "Algorithm::Diff::XS"      => "0.04";

on "configure" => sub {
    requires   "ExtUtils::MakeMaker";

    recommends "ExtUtils::MakeMaker"      => "7.22";

    suggests   "ExtUtils::MakeMaker"      => "7.70";
    };

on "build" => sub {
    requires   "Config";
    };

on "test" => sub {
    requires   "Capture::Tiny";
    requires   "Test::More";

    recommends "Capture::Tiny"            => "0.24";

    suggests   "Capture::Tiny"            => "0.50";
    };
