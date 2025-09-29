use Test;
plan 2;
use PDF::Render::Tree::From::Pod;

my $title = 'Sample Title';
my $date = '2025-03-17';
my $author = 'David Warring';
my $description = "sample Pod with replaced content";
my %replace = :$date, :$title, :$author, :$description;

my PDF::Render::Tree::From::Pod $reader .= new: :%replace;

my $ast = :Document[:Author("David Warring"), :Subject("Replacement Test"), :Title("Sample Title"), :Lang("en"), "#comment" => " sample Pod with replaced content ", :Title["Sample Title"], :H2["Replacement Test"], :H2["Author"], :P["David Warring"], :H2["Date"], :P["2025-03-17"], :H2["Description"], :P["sample Pod with replaced content", ";"]];
$reader.render($=pod).&is-deeply: $ast,
   'Various types of replacement content correctly';

%replace<description> = $=pod;
$reader .= new: :%replace;
dies-ok {
    $reader.render($=pod, :%replace);
}, 'recursive replacement detected';


=begin pod
=comment sample Pod with replaced content
=TITLE R<title>
=SUBTITLE Replacement Test
=AUTHOR R<author>
=DATE R<date>
=head2 Description
=para R<description>;
=end pod
