use v6.d;

=head1 RussianStem implementation
=begin para
Follows the Russian stemming implementation of:
=item http://snowball.tartarus.org/algorithms/russian/stemmer.html
=item https://github.com/neilb/Lingua-Stem-Ru
=end para

unit module Lingua::Stem::Russian;

#| The Russian stemming rules
my $vowel        = 'аеиоуыэюя';
my $NO-VOWEL     = '<-[' ~ $vowel ~ ']>';
my $VOWEL        = '<[' ~ $vowel ~ ']>';
my $PERFECTIVEGROUND = ' ((ив|ивши|ившись|ыв|ывши|ывшись) | ((<?after <[ая]>>) (в|вши|вшись))) $ ';
my $REFLEXIVE    = ' (с <[яь]>) $ ';
my $ADJECTIVE    = ' (ее|ие|ые|ое|ими|ыми|ей|ий|ый|ой|ем|им|ым|ом|его|ого|ему|ому|их|ых|ую|юю|ая|яя|ою|ею) $ ';
my $PARTICIPLE   = ' ((ивш|ывш|ующ)|((<?after <[ая]>>) (ем|нн|вш|ющ|щ))) $ ';
my $VERB         = ' ((ила|ыла|ена|ейте|уйте|ите|или|ыли|ей|уй|ил|ыл|им|ым|ен|ило|ыло|ено|ят|ует|уют|ит|ыт|ены|ить|ыть|ишь|ую|ю)|((<?after <[ая]>>) (ла|на|ете|йте|ли|й|л|ем|н|ло|но|ет|ют|ны|ть|ешь|нно))) $ ';
my $NOUN         = ' (а|ев|ов|ие|ье|е|иями|ями|ами|еи|ии|и|ией|ей|ой|ий|й|иям|ям|ием|ем|ам|ом|о|у|ах|иях|ях|ы|ь|ию|ью|ю|ия|ья|я) $ ';
my $RVRE         = rx / ^ (.*? <$VOWEL> ) (.*) $ /;
my $DERIVATIONAL = rx / <$NO-VOWEL> <$VOWEL>+ <$NO-VOWEL>+ <$VOWEL> .* <?after 'о'> 'сть'? $ /;

#`[ Original Perl code converted from KOI8-R to UTF-8
my $VOWEL        = qr/аеиоуыэюя/;
my $PERFECTIVEGROUND = qr/((ив|ивши|ившись|ыв|ывши|ывшись)|((?<=[ая])(в|вши|вшись)))$/;
my $REFLEXIVE    = qr/(с[яь])$/;
my $ADJECTIVE    = qr/(ее|ие|ые|ое|ими|ыми|ей|ий|ый|ой|ем|им|ым|ом|его|ого|ему|ому|их|ых|ую|юю|ая|яя|ою|ею)$/;
my $PARTICIPLE   = qr/((ивш|ывш|ующ)|((?<=[ая])(ем|нн|вш|ющ|щ)))$/;
my $VERB         = qr/((ила|ыла|ена|ейте|уйте|ите|или|ыли|ей|уй|ил|ыл|им|ым|ен|ило|ыло|ено|ят|ует|уют|ит|ыт|ены|ить|ыть|ишь|ую|ю)|((?<=[ая])(ла|на|ете|йте|ли|й|л|ем|н|ло|но|ет|ют|ны|ть|ешь|нно)))$/;
my $NOUN         = qr/(а|ев|ов|ие|ье|е|иями|ями|ами|еи|ии|и|ией|ей|ой|ий|й|иям|ям|ием|ем|ам|ом|о|у|ах|иях|ях|ы|ь|ию|ью|ю|ия|ья|я)$/;
my $RVRE         = qr/^(.*?[$VOWEL])(.*)$/;
my $DERIVATIONAL = qr/[^$VOWEL][$VOWEL]+[^$VOWEL]+[$VOWEL].*(?<=о)сть?$/;
]

#| RussianStem
proto RussianStem($wordSpec) is export {*}

#| RussianStem
multi RussianStem(@words --> List) {
    return @words.map({ RussianStem($_) }).List;
}

#| RussianStem
multi RussianStem(Str:D $word --> Str) {

    # The code in this function is very close to the original Perl code of stem_word in
    # https://github.com/neilb/Lingua-Stem-Ru/blob/master/lib/Lingua/Stem/Ru.pm

    my ($start, $RV) = |($word.lc ~~ $RVRE);

    return $word unless $RV;

    # note 'step 0: ',$RV;

    # Step 1
    unless $RV ~~ s/ <{$PERFECTIVEGROUND}> // {
        $RV ~~ s/ <{$REFLEXIVE}> //;

        # note 'step 1a: ', $RV;

        if ($RV ~~ s/ <{$ADJECTIVE}> //) {
            $RV ~~ s/ <{$PARTICIPLE}> //;
        } else {
            $RV ~~ s/ <{$NOUN}> // unless $RV ~~ s/ <{$VERB}> //;
        }
        # note 'step 1b: ',$RV;
    }

    # Step 2
    $RV ~~ s/и$//;
    # note 'step 2: ',$RV;

    # Step 3
    $RV ~~ s/ость?$// if $RV ~~ $DERIVATIONAL;
    # note 'step 3: ',$RV;

    # Step 4
    unless ($RV ~~ s/ь$//) {
        $RV ~~ s/ейше?//;
        $RV ~~ s/нн$/н/;
    }

    return $word.substr(0, $start.chars) ~ $word.substr($start.chars, $RV.Str.chars);
}

#| Synonym of RussianStem
sub ru-word-stem($arg) is export {
    return RussianStem($arg);
}
