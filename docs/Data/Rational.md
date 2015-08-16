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
instance semiringRational :: Semiring Rational
instance ringRational :: Ring Rational
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


