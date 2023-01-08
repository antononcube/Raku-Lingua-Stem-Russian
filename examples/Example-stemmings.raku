#!/usr/bin/env raku
use v6.d;

use Lingua::Stem::Russian;

# Single word
say RussianStem('облизал');

# Many words
say RussianStem('ты облизал тарелку с солеными огурцами и помидорами'.words);

my $text = q:to/END/;
На фоне всего этого завод также обеспокоен тем, как кризис повлияет на цены на природный газ, используемый в производстве.
За последние дни стоимость голубого топлива на голландской бирже, от которой зависят цены в стране, выросла примерно на 70%.
Сегодня они успокоились, но сомнительно, что снижение, объявленное Bulgargas на начало марта, произойдет.';
END

my $tstart = now;
my $res = RussianStem($text.words>>.trim);
say "Stemming time {now - $tstart}.";
