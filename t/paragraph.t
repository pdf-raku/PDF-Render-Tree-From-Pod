use v6;

use Test;
use PDF::Render::Tree::From::Pod;

plan 1;

my $ast =
    :Document[:lang("en"),
              :P["This is all a paragraph."],
              :P["This is the next paragraph."],
              :P["This is the third paragraph."],
              :P["Abbreviated paragraph"],
              :P["Paragraph paragraph"],
              :P["Block"],
              :P["paragraph"],
              :P["spaces and tabs are ignored"],
              :P["Paragraph with ", :Strong["formatting"], ", ", :Code["code"], " and ", :Reference[:Link[:href("#blah"), "links"]], "."],
              :P["Paragraph with ", "(see: ", :Link[:href("file:included.pod"), "file:included.pod"], ")", " placement"],
              "#comment" => " a single word that exceeds the line width ",
              :P["aaaaabbbbbcccccdddddeeeeefffffggggghhhhhiiiiijjjjjkkkkklllllmmmmmnnnnnooooopppppqqqqqrrrrrssssstttttuuuuuvvvvvwwwwwxxxxxyyyyyzzzzz"]];

PDF::Render::Tree::From::Pod.render($=pod).&is-deeply: $ast,
   'Paragraphs convert correctly.';

=begin pod
This is all
a paragraph.

This is the
next paragraph.

This is the
third paragraph.
=end pod

=para Abbreviated paragraph

=for para
Paragraph
paragraph

=begin para
Block

paragraph
=end para

=para spaces  and	tabs are ignored

=para Paragraph with B<formatting>, C<code> and L<links|#blah>.

=para Paragraph with P<file:included.pod> placement

=comment a single word that exceeds the line width

=para aaaaabbbbbcccccdddddeeeeefffffggggghhhhhiiiiijjjjjkkkkklllllmmmmmnnnnnooooopppppqqqqqrrrrrssssstttttuuuuuvvvvvwwwwwxxxxxyyyyyzzzzz
