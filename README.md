Rational numbers for PureScript
-------------------------------

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

## Installation

```
bower install purescript-rationals
```

## API documentation

Module documentation is [published on Pursuit](http://pursuit.purescript.org/packages/purescript-rationals/).
