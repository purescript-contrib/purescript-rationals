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
```

#### `numerator`

``` purescript
numerator :: forall a. Ratio a -> a
```

#### `denominator`

``` purescript
denominator :: forall a. Ratio a -> a
```


