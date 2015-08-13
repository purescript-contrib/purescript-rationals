## Module Data.Rational

#### `Rational`

``` purescript
data Rational
```

##### Instances
``` purescript
instance showRational :: Show Rational
instance semiringRational :: Semiring Rational
instance ringRational :: Ring Rational
```

#### `(%)`

``` purescript
(%) :: Int -> Int -> Rational
```

_left-associative / precedence 7_

#### `numerator`

``` purescript
numerator :: Rational -> Int
```

#### `denominator`

``` purescript
denominator :: Rational -> Int
```

#### `toNumber`

``` purescript
toNumber :: Rational -> Number
```

#### `fromInt`

``` purescript
fromInt :: Int -> Rational
```


