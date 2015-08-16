## Module Data.Ratio

#### `Ratio`

``` purescript
data Ratio a
  = Ratio a a
```

##### Instances
``` purescript
instance semiringRatio :: (Semiring a) => Semiring (Ratio a)
instance ringRatio :: (Ring a) => Ring (Ratio a)
instance moduloSemiringRatio :: (Ring a, ModuloSemiring a) => ModuloSemiring (Ratio a)
instance divisionRingRatio :: (DivisionRing a) => DivisionRing (Ratio a)
instance numRatio :: (Num a) => Num (Ratio a)
```

#### `numerator`

``` purescript
numerator :: forall a. Ratio a -> a
```

#### `denominator`

``` purescript
denominator :: forall a. Ratio a -> a
```


