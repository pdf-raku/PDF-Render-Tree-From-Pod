use Test;
use PDF::Render::Tree::From::Pod;

plan 1;

my PDF::Render::Tree::From::Pod $reader;
my $ast = :Document[:Lang("en"), :Div[:role("Declaration"), :H2["Module Asdf1"], :P["This is a module"], :Code[:Placement("Block"), :role("Raku"), "module Asdf1"]], :Div[:role("Declaration"), :H3["Sub asdf"], :P["This is a sub"], :Code[:Placement("Block"), :role("Raku"), "sub asdf(\n    Str \$asdf1,\n    Str :\$asdf2 = \"asdf\",\n) returns Str"]], :Div[:role("Declaration"), :H2["Class Asdf2"], :P["This is a class"], :Code[:Placement("Block"), :role("Raku"), "class Asdf2"]], :Div[:role("Declaration"), :H3["Attribute t"], :P["This is an attribute"], :Code[:Placement("Block"), :role("Raku"), "has Str \$.t"]], :Div[:role("Declaration"), :H3["Method asdf"], :P["This is a method"], :Code[:Placement("Block"), :role("Raku"), "method asdf(\n    Str :\$asdf = \"asdf\",\n) returns Str"]]];

$reader.render($=pod).&is-deeply: $ast,
    'Converts definitions correctly';

#| This is a module
module Asdf1 {
    #| This is a sub
    sub asdf(Str $asdf1, Str :$asdf2? = 'asdf') returns Str {
	return '';
    }
}

#| This is a class
class Asdf2 does Positional  {
    #| This is an attribute
    has Str $.t = 'asdf';
    
    #| This is a method
    method asdf(Str :$asdf? = 'asdf') returns Str {
	
    }
}


