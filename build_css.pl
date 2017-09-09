#!/usr/bin/env perl
use strict;
use warnings;

use feature 'say';

use IO::Handle;
use IO::File;
use YAML::XS;
use Data::Dumper;

my $filepath = 'glyphs.lst';
my $file = IO::File->new($filepath, 'r');
IO::Handle->input_record_separator(undef);
my $text = $file->getline;

my $data = Load $text;

say "

\@font-face {
	font-family: 'Journey Glyph';
	src: url('Journey_Glyph_v1.ttf') format('truetype'),
		url('Journey_Glyph_v1.otf') format('opentype'),
		url('Journey_Glyph_v1.woff') format('woff');
	font-weight: normal;
	font-style: normal;
}

i[class^='journey-glyph-'], i[class*=' journey-glyph-'] {
	font-style: normal;
}

[class^='journey-glyph-'], [class*=' journey-glyph-'] {
	font-family: 'Journey Glyph';
	font-size: 4.0em;
	line-height: 1.0em;
}

.small[class^='journey-glyph-'], .small[class*=' journey-glyph-'] {
	font-size: 4.0em;
}

.medium[class^='journey-glyph-'], .medium[class*=' journey-glyph-'] {
	font-size: 8.0em;
}

.large[class^='journey-glyph-'], .large[class*=' journey-glyph-'] {
	font-size: 16.0em;
}

";

foreach my $glyph_record (@$data) {
	my $glyph_id = lc $glyph_record->{name} =~ y/ /-/r;
	say ".journey-glyph-$glyph_id\::before { content: '$glyph_record->{glyph}'; }";
}


