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

`RussianStem` also works with lists of words:

```perl6
say RussianStem('Всходы урожая ожидаются с терпением, питьем и беконом.'.words)
```

The function `russian-word-stem` can be used as a synonym of `RussianStem`.

-------

## Command Line Interface (CLI)

The package provides the CLI function `RussianStem`. Here is its usage message:

```shell
RussianStem --help
```

Here are example shell commands of using the CLI function `RussianStem`:

```shell
RussianStem Какие
```

```shell
RussianStem --format=raku "Модуль Raku, предоставляющий процедуру для русского языка."
```

```shell
RussianStem Проверить корректность подбора по словарям и правилам
```

Here is a pipeline example using the CLI function `get-tokens` of the package 
["Grammar::TokenProcessing"](https://github.com/antononcube/Raku-Grammar-TokenProcessing),
[AAp1]:

```shell
get-tokens ./RecommenderPhrases-template | RussianStem --format=raku
```

**Remark:** These kind of tokens (literals) transformations are used in the packages
["DSL::Bulgarian"](https://github.com/antononcube/Raku-DSL-Bulgarian), [AAp2],
and
["DSL::Russian"](https://github.com/antononcube/Raku-DSL-Russian), [AAp3],

-------

## Other implementations

TBD...


-------

## Implementation notes

- Reprogrammed to Raku from : https://github.com/neilb/Lingua-Stem-Ru/blob/master/lib/Lingua/Stem/Ru.pm .

-------

## TODO

- [ ] DONE Respect the word case in the returned result. 

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

