use v6;

use Test;
use PDF::Render::Tree::From::Pod;

plan 1;

my %replace = :where<POD>;
my PDF::Render::Tree::From::Pod $reader .= new: :indent, :%replace;
my $ast = :Document[:Author("David Warring"), :Subject("Subtitle from POD"), :Title("Main Title v1.2.3"), :Lang("en"), "\n  ", :Title["Main Title"], "\n  ", :H2["Subtitle from ", "POD"], "\n  ", :H2["Author"], "\n  ", :P["David Warring"], "\n  ", :H2["Version"], "\n  ", :P["1.2.3"], "\n  ", :H2["Head2 from ", "POD"], "\n  ", :P["a paragraph."], "\n"];
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

