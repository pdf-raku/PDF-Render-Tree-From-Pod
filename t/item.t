use v6;

use Test;
use PDF::Render::Tree::From::Pod;

plan 1;

my $ast = :Document[:Lang("en"), :P["asdf"], :L[:LI[:LBody[:P["Abbreviated 1"]]], :LI[:LBody[:P["Abbreviated 2"]]]], :P["asdf"], :L[:LI[:LBody[:P["Top Item"], :L[:LI[:Lbl["1."], :LBody[:P["First numbered sub-item"]]], :LI[:Lbl["2."], :LBody[:P["Second numbered sub-item"]]], :LI[:LBody[:P["Un-numbered sub-item"]]]]]], :LI[:LBody[:P["Paragraph item"]]]], :P["asdf"], :L[:LI[:LBody[:P["Block item"]]]], :P["asdf"], :L[:LI[:LBody[:P["Abbreviated"]]], :LI[:LBody[:P["Paragraph item"]]], :LI[:LBody[:P["Block item"], :P["with multiple"], :P["paragraphs"]]]], :P["asdf"]];

PDF::Render::Tree::From::Pod.render($=pod).&is-deeply: $ast,
   'Various types of items convert correctly';


=begin pod
asdf

=item Abbreviated 1
=item Abbreviated 2

asdf

=begin item1
Top Item
=item2 #  First numbered sub-item
=item2 #  Second numbered sub-item
=item2    Un-numbered sub-item
=end item1

=for item
Paragraph
item

asdf

=begin item
Block
item
=end item

asdf

=item Abbreviated

=for item
Paragraph
item

=begin item
Block
item

with
multiple

paragraphs
=end item

asdf
=end pod
