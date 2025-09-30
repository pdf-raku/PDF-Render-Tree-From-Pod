use v6;

use Test;
use PDF::Render::Tree::From::Pod;

plan 1;

my $ast =
    :Document[:lang("en"),
              :L[:role("DL"),
                 :LI[:role("DL-DIV"),
                     :Lbl[:Placement("Block"), :role("DT"), "Happy"],
                     :LBody[:role("DD"), :P["When you're not blue."]]],
                 :LI[:role("DL-DIV"),
                     :Lbl[:Placement("Block"), :role("DT"), "Blue"],
                     :LBody[:role("DD"), :P["When you're not happy."]]]
                ]
             ];

PDF::Render::Tree::From::Pod.render($=pod).&is-deeply: $ast,
   'Declarators convert correctly.';

=begin pod

=defn # Happy
When you're not blue.

=defn # Blue
When you're not happy.

=end pod
