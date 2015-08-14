Rational numbers for PureScript
-------------------------------

Using the `Number` type:

```
> 0.1 + 0.2
0.30000000000000004
```

The same can be expressed with `Rational` using the `(%)` operator:

```
> import Data.Rational
> toNumber $ (1 % 10) + (2 % 10)
0.3
```

