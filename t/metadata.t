use v6;

use Test;
use PDF::Render::Tree::From::Pod;

plan 1;

my %replace = :where<POD>;
my PDF::Render::Tree::From::Pod $reader .= new: :%replace;
my $ast =
    :Document[:Author("David Warring"), :Subject("Subtitle from POD"), :Title("Main Title v1.2.3"), :Lang("en"),
              :Title["Main Title"],
              :H2["Subtitle from ", "POD"],
              :H2["Author"],
              :P["David Warring"],
              :H2["Version"],
              :P["1.2.3"],
              :H2["Head2 from ", "POD"],
              :P["a paragraph."]
             ];
$reader.render($=pod).&is-deeply: $ast,
   'Various types of metadata convert correctly';

=begin pod
=TITLE Main Title
=SUBTITLE Subtitle from R<where>
=AUTHOR David Warring
=VERSION 1.2.3

=head2 Head2 from R<where>

a paragraph.
=end pod

