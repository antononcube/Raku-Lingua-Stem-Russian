# Lingua::Stem::Russian Raku package

## Introduction

This Raku package is for stemming Russian words. 
It implements the Snowball algorithm presented in 
[[SNa1](http://snowball.tartarus.org/algorithms/russian/stemmer.html)].

-------

## Usage examples

The `RussianStem` function is used to find stems:

```perl6
use Lingua::Stem::Russian;
say RussianStem('всходы')
```
```
# всход
```

`RussianStem` also works with lists of words:

```perl6
say RussianStem('Всходы урожая ожидаются с терпением, питьем и беконом.'.words)
```
```
# (Всход урож ожида с терпением, пит и беконом.)
```

The function `russian-word-stem` can be used as a synonym of `RussianStem`.

-------

## Command Line Interface (CLI)

The package provides the CLI function `RussianStem`. Here is its usage message:

```shell
RussianStem --help
```
```
# Usage:
#   RussianStem <text> [--splitter=<Str>] [--format=<Str>] -- Finds stems of Russian words in text.
#   RussianStem [<words> ...] [--format=<Str>] -- Finds stems of Russian words.
#   RussianStem [--format=<Str>] -- Finds stems of Russian words in (pipeline) input.
#   
#     <text>              Text to spilt and its words stemmed.
#     --splitter=<Str>    String to make a split regex with. [default: '\W+']
#     --format=<Str>      Output format one of 'text', 'lines', or 'raku'. [default: 'text']
#     [<words> ...]       Words to be stemmed.
```

Here are example shell commands of using the CLI function `RussianStem`:

```shell
RussianStem Какие
```
```
# Как
```

```shell
RussianStem --format=raku "Модуль Raku, предоставляющий процедуру для русского языка."
```
```
# ["Модул", "Raku", "предоставля", "процедур", "для", "русск", "язык", ""]
```

```shell
RussianStem Проверить корректность подбора по словарям и правилам
```
```
# Провер корректност подбор по словар и правил
```

Here is a pipeline example using the CLI function `get-tokens` of the package 
["Grammar::TokenProcessing"](https://github.com/antononcube/Raku-Grammar-TokenProcessing),
[AAp1]:

```
get-tokens ./DataQueryPhrases-template | RussianStem --format=raku 

# ("ассоциац", "ассоциирован", "ассоциирова", "безопасн", "восходя", "выбер", "заказа", "комбайн", "крестообразн", 
#  "поверхност", "мутирова", "обзор", "обобщ", "переименова", "пол", "просмотрет", "разгруппирова", "разделител",
#  "распла", "расстав", "символ", "слит", "слиян", "сплит", "табулирова", "тольк", "убыва", "уверен", "форм", 
#  "формат", "формирова", "формул", "широк")
```

**Remark:** These kind of tokens (literals) transformations are used in the packages
["DSL::Bulgarian"](https://github.com/antononcube/Raku-DSL-Bulgarian), [AAp2],
and
["DSL::Russian"](https://github.com/antononcube/Raku-DSL-Russian), [AAp3],


-------

## Implementation notes

- Reprogrammed to Raku from : https://github.com/neilb/Lingua-Stem-Ru/blob/master/lib/Lingua/Stem/Ru.pm .

-------

## TODO

- [X] DONE Respect the word case in the returned result. 

   - `RussianStem('ТАБЛА')` should return `'ТАБЛ'`. 
   - (Not `'табл'` as it currently does.) 
   
- [X] DONE CLI that can be inserted in UNIX pipelines.

- [ ] TODO Performance statistics.

- [ ] TODO More detailed documentation.

-------

## References

### Articles

[SNa1] Snowball Team,
[Russian stemming algorithm](http://snowball.tartarus.org/algorithms/russian/stemmer.html),
(2002),
[snowball.tartarus.org](http://snowball.tartarus.org).

### Packages

[AAp1] Anton Antonov,
[Grammar::TokenProcessing Raku package](https://github.com/antononcube/Raku-Grammar-TokenProcessing),
(2022),
[GitHub/antononcube](https://github.com/antononcube).

[AAp2] Anton Antonov,
[DSL::Bulgarian Raku package](https://github.com/antononcube/Raku-DSL-Bulgarian),
(2022),
[GitHub/antononcube](https://github.com/antononcube).

[AAp3] Anton Antonov,
[DSL::Russian Raku package](https://github.com/antononcube/Raku-DSL-Russian),
(2023),
[GitHub/antononcube](https://github.com/antononcube).

