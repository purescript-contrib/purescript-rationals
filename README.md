# Rationals

[![CI](https://github.com/purescript-contrib/purescript-rationals/workflows/CI/badge.svg?branch=master)](https://github.com/purescript-contrib/purescript-rationals/actions?query=workflow%3ACI+branch%3Amaster)
[![Release](https://img.shields.io/github/release/purescript-contrib/purescript-rationals.svg)](https://github.com/purescript-contrib/purescript-rationals/releases)
[![Pursuit](https://pursuit.purescript.org/packages/purescript-rationals/badge)](https://pursuit.purescript.org/packages/purescript-rationals)
[![Maintainer: gbagan](https://img.shields.io/badge/maintainer-gbagan-teal.svg)](https://github.com/gbagan)

Using numbers to do arithmetic with fractions in PureScript may yield surprising results:

```
> 0.1 + 0.2
0.30000000000000004
```

The same can be expressed accurately with `Rational` using the `(%)` operator:

```
> import Data.Rational
> (1 % 10) + (2 % 10)
3 % 10
```

You can turn a `Rational` to a `Number`:

```
> toNumber (3 % 10)
0.3
```

## Installation

Install `rationals` with [Spago](https://github.com/purescript/spago):

```sh
spago install rationals

# Or with Bower
bower install purescript-rationals
```

## Other Ratios

`Rational` is just a newtype over `Ratio BigInt` and you might want to use
`Ratio` with other than `BigInt`. The type you choose must however be an `EuclideanRing`.

```
> import Data.Ratio ((%), reduce)
> import Data.BigInt (fromInt, fromString)
> :type fromInt 1 % fromInt 3
Ratio BigInt
> reduce <$> fromString "10" <*> fromString "857981209301293808359384092830482"
(Just fromString "5" % fromString "428990604650646904179692046415241")
```

## Documentation

`rationals` documentation is stored in a few places:

1. Module documentation is [published on Pursuit](https://pursuit.purescript.org/packages/purescript-rationals).
2. Usage examples can be found in [the test suite](./test).

If you get stuck, there are several ways to get help:

- [Open an issue](https://github.com/purescript-contrib/purescript-rationals/issues) if you have encountered a bug or problem.
- Ask general questions on the [PureScript Discourse](https://discourse.purescript.org) forum or the [PureScript Discord](https://discord.com/invite/sMqwYUbvz6) chat.

## Contributing

You can contribute to `rationals` in several ways:

1. If you encounter a problem or have a question, please [open an issue](https://github.com/purescript-contrib/purescript-rationals/issues). We'll do our best to work with you to resolve or answer it.

2. If you would like to contribute code, tests, or documentation, please [read the contributor guide](./CONTRIBUTING.md). It's a short, helpful introduction to contributing to this library, including development instructions.

3. If you have written a library, tutorial, guide, or other resource based on this package, please share it on the [PureScript Discourse](https://discourse.purescript.org)! Writing libraries and learning resources are a great way to help this library succeed.
