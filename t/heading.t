use v6;

use Test;
use PDF::Render::Tree::From::Pod;

plan 1;

my $ast =
    :Document[:Subject("for Pod::To::XML"), :Title("Heading tests"), :Lang("en"),
              :Title["Heading tests"],
              :H2["for ", :Link[:href("Pod::To::XML"), "Pod::To::XML"]],
              :H1["Abbreviated heading1"],
              :P["asdf"],
              :H1["Paragraph heading1"],
              :P["asdf"],
              :H2["Subheading2"],
              :H1[:P["Structured"], :P["heading1"]],
              :H3["Heading3"],
              :P["asdf"],
              :H2["Head2"],
              :P["asdf"],
              :H3["Head3"],
              :P["asdf"],
              :H4["Head4"],
              :P["asdf"]
             ];

PDF::Render::Tree::From::Pod.render($=pod).&is-deeply: $ast,
   'Various types of headings convert correctly';

=begin pod
=TITLE Heading tests
=SUBTITLE for L<Pod::To::XML>

=head1 Abbreviated heading1

asdf

=for head1
Paragraph heading1

asdf

=head2 Subheading2

=begin head1
Structured
	
heading1
=end head1

=head3 	Heading3

asdf

=head2 Head2

asdf

=head3 Head3

asdf

=head4 Head4

asdf

=end pod
