use v6;

use Test;
use PDF::Render::Tree::From::Pod;
use JSON::Fast;

plan 1;

my PDF::Render::Tree::From::Pod $reader .= new;

my $ast =
    :Document[:Lang("en"),
              :P["asdf"],
              :Code[:Placement("Block"), "indented"],
              :P["asdf"],
              :Code[:Placement("Block"), "indented\nmulti\nline"],
              :P["asdf"],
              :Code[:Placement("Block"), "indented\nmulti\nline\n\n    nested\nand\nbroken\nup"],
              :P["asdf"],
              :Code[:Placement("Block"), "Abbreviated", "\n"],
              :P["asdf"],
              :Code[:Placement("Block"), "Paragraph", "\n", "code", "\n"],
              :P["asdf"],
              :Code[:Placement("Block"), "Delimited", "\n", "code", "\n"],
              :P["asdf"],
              :Code[:Placement("Block"), :Strong["Formatted"], "\n", "code", "\n"]
             ];

$reader.render($=pod).&is-deeply: $ast, 'Various types of code blocks convert correctly.';

=begin pod
asdf

    indented

asdf

    indented
    multi
    line

asdf

    indented
    multi
    line
    
        nested
    and
    broken
    up

asdf

=code Abbreviated

asdf

=for code
Paragraph
code

asdf

=begin code
Delimited
code
=end code

asdf

=begin code :allow<B>
B<Formatted>
code
=end code

=end pod
