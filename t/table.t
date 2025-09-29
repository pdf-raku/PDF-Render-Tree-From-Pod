use v6;

use Test;
use PDF::Render::Tree::From::Pod;
plan 1;

my $ast = :Document[:Lang("en"), :P["asdf"], :Table[:Caption["Table 1"], :TBody[:TR[:TD["A A"], :TD["B B"], :TD["C C"]], :TR[:TD["1 1"], :TD["2 2"], :TD["3 3"]]]], :P["asdf"], :Table[:Caption["Table 2"], :THead[:TR[:TH["H 1"], :TH["H 2"], :TH["H 3"]]], :TBody[:TR[:TD["A A"], :TD["B B"], :TD["C C"]], :TR[:TD["1 1"], :TD["2 2"], :TD["3 3"]]]], :P["asdf"], :Table[:Caption["Table 3"], :THead[:TR[:TH["H11"], :TH["HHH 222"], :TH["H 3"]]], :TBody[:TR[:TD["AAA"], :TD["BB"], :TD["C C C C"]], :TR[:TD["1 1"], :TD["2 2 2 2"], :TD["3 3"]]]], :P["asdf"], :Table[:THead[:TR[:TH["H 1"], :TH["H 2"], :TH["H 3"], :TH["H 4"]]], :TBody[:TR[:TD["Hello, I'm kinda long, I think"], :TD["B B"], :TD["C C"], :TD[""]], :TR[:TD["1 1"], :TD["Me also, methinks"], :TD["3 3"], :TD["This should definitely wrap. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt"]], :TR[:TD["ww"], :TD["xx"], :TD["yy"], :TD["zz"]]]], :P["asdf"]];

PDF::Render::Tree::From::Pod.render($=pod).&is-deeply: $ast,
    'Converts tables correctly';

=begin pod
asdf
=begin table :caption('Table 1')
A A    B B       C C
1 1    2 2       3 3
=end table
asdf
=begin table :caption('Table 2')
H 1 | H 2 | H 3
====|=====|====
A A | B B | C C
1 1 | 2 2 | 3 3
=end table
asdf

=begin table :caption('Table 3')
       HHH
  H11  222  H 3
  ===  ===  ===
  AAA  BB   C C
            C C

  1 1  2 2  3 3
       2 2
=end table
asdf

=begin table
H 1 | H 2 | H 3 | H 4
====|=====|=====|====
Hello, I'm kinda long, I think | B B | C C
1 1 | Me also, methinks | 3 3 | This should definitely wrap. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt
ww | xx | yy | zz
=end table
asdf

=end pod
