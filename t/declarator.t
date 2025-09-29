use v6;

use Test;
use PDF::Render::Tree::From::Pod;

plan 1;

my $ast =
    :Document[:Lang("en"),
              "#comment" => " Example taken from docs.raku.org/language/pod#Declarator_blocks ",
              :Div[:role("Declaration"), :H2["Class Magician"], :P["Base class for magicians"], :Code[:Placement("Block"), :role("Raku"), "class Magician"]],
              :Div[:role("Declaration"), :H3["Sub duel"], :P["Fight mechanics"], :Code[:Placement("Block"), :role("Raku"), "sub duel(\n    Magician \$a,\n    Magician \$b,\n)"], :P["Magicians only, no mortals."]]
             ];

PDF::Render::Tree::From::Pod.render($=pod).&is-deeply: $ast,
   'Declarators convert correctly.';

=comment Example taken from docs.raku.org/language/pod#Declarator_blocks

#| Base class for magicians 
class Magician {
  has Int $.level;
  has Str @.spells;
}
 
#| Fight mechanics 
sub duel(Magician $a, Magician $b) {
}
#= Magicians only, no mortals. 

