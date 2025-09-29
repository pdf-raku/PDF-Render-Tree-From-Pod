use Test;
use PDF::Render::Tree::From::Pod;

plan 1;

my $ast =
    :Document[:Lang("en"),
              :H2["Outer"],
              :P["This is an outer paragraph"],
              :H3["Inner1"],
              :P["This is the first inner paragraph"],
              :H3["Inner2"],
              :P["This is the second inner paragraph"]];

PDF::Render::Tree::From::Pod.render($=pod).&is-deeply: $ast,
   'Various types of paragraphs nest correctly';

=begin pod
=begin Outer

This is an outer paragraph

=begin Inner1

This is the first inner paragraph

=end Inner1

    =begin Inner2

    This is the second inner paragraph

    =end Inner2
=end Outer
=end pod
