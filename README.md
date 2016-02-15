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

## Installation

```
bower install purescript-rationals
```

## Documentation

Module documentation is [published on Pursuit](http://pursuit.purescript.org/packages/purescript-rationals/).
