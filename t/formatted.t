use v6;

use Test;
use PDF::Render::Tree::From::Pod;

plan 1;

my $ast = :Document[:Lang("en"),
                    :P["This text is of ", :Span[:TextDecorationType("Underline"), "minor significance"], "."],
                    :P["This text is of ", :Em["major significance"], "."],
                    :P["This text is of ", :Strong["fundamental significance"], "."],
                    :P["This text is verbatim C<with> B<disarmed> Z<formatting>."],
                    :P["This text ", "has been replaced", "."],
                    :P["This has ", "invisible text."],
                    :P["This text contains a link to ", :Link[:href("http://www.google.com/"), "http://www.google.com/"], "."],
                    :P["This text contains a link with label to ", :Link[:href("http://www.google.com/"), "google"], "."],
                    :P["This has ", :Code[:TextDecorationType("Underline"), :role("Keyboard"), "keyboard"], " and ", :Code[:role("Terminal"), "terminal"], " text."],
                    "#comment" => " a real-world sample, taken from Supply.pod6 ",
                    :P["A tap on an ", :Code["on demand"], " supply will initiate the production of values, and tapping the supply again may result in a new set of values. For example, ", :Code["Supply.interval"], " produces a fresh timer with the appropriate interval each time it is tapped. If the tap is closed, the timer simply stops emitting values to that tap."]
                   ];

my %replace = 'is to be replaced' => 'has been replaced';
my PDF::Render::Tree::From::Pod $reader .= new: :%replace;

$reader.render($=pod).&is-deeply: $ast,
   'Formatting and replacement convert correctly.';

=begin pod
This text is of U<minor significance>.

This text is of I<major significance>.

This text is of B<fundamental significance>.

This text is V<verbatim C<with> B<disarmed> Z<formatting>>.

This text R<is to be replaced>.

This has Z<blabla>invisible text.

This text contains a link to L<http://www.google.com/>.

This text contains a link with label to L<google|http://www.google.com/>.

This has K<keyboard> and T<terminal> text.

=comment a real-world sample, taken from Supply.pod6

A tap on an C<on demand> supply will initiate the production of values, and
tapping the supply again may result in a new set of values. For example,
C<Supply.interval> produces a fresh timer with the appropriate interval each
time it is tapped. If the tap is closed, the timer simply stops emitting values
to that tap.

=end pod
