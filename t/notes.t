use v6;

use Test;
use PDF::Render::Tree::From::Pod;

plan 1;

my $ast = :Document[:Lang("en"),
                    :P["sanity test of ",
                       :FENote["if you click, here, you should got back to the paragraph"],
                       " footnotes."]
                   ];

PDF::Render::Tree::From::Pod.render($=pod).&is-deeply: $ast,
    'Paragraphs convert correctly.';

=begin pod

=para sanity test of N<if you click, here, you should got back to the paragraph> footnotes.

=end pod
