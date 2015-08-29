## Module Data.Rational

#### `Rational`

``` purescript
newtype Rational
  = Rational (Ratio Int)
```

##### Instances
``` purescript
instance showRational :: Show Rational
instance eqRational :: Eq Rational
instance ordRational :: Ord Rational
instance semiringRational :: Semiring Rational
instance ringRational :: Ring Rational
instance moduloSemiringRational :: ModuloSemiring Rational
instance divisionRingRational :: DivisionRing Rational
instance numRational :: Num Rational
```

#### `(%)`

``` purescript
(%) :: Int -> Int -> Rational
```

_left-associative / precedence 7_

#### `toNumber`

``` purescript
toNumber :: Rational -> Number
```

#### `fromInt`

``` purescript
fromInt :: Int -> Rational
```


