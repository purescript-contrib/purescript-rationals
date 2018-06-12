module Data.Ratio
  ( Ratio
  , reduce
  , (%)
  , numerator
  , denominator
  ) where

import Prelude
import Data.Ord (abs, signum)

data Ratio a = Ratio a a

instance showRatio :: Show a => Show (Ratio a) where
  show (Ratio a b) = show a <> " % " <> show b

instance eqRatio :: Eq a => Eq (Ratio a) where
  eq (Ratio a b) (Ratio c d) = a == c && b == d

instance ordRatio :: (Ord a, EuclideanRing a) => Ord (Ratio a) where
  compare x y =
    case x - y of
      Ratio n d ->
        if n == zero
          then EQ
          else case n > zero, d > zero of
            true, true -> GT
            false, false -> GT
            _, _ -> LT

instance semiringRatio :: (Ord a, EuclideanRing a) => Semiring (Ratio a) where
  one = Ratio one one
  mul (Ratio a b) (Ratio c d) = reduce (a * c) (b * d)
  zero = Ratio zero one
  add (Ratio a b) (Ratio c d) = reduce ((a * d) + (b * c)) (b * d)

instance ringRatio :: (Ord a, EuclideanRing a) => Ring (Ratio a) where
  sub (Ratio a b) (Ratio c d) = reduce ((a * d) - (b * c)) (b * d)

instance commutativeRingRatio :: (Ord a, EuclideanRing a) => CommutativeRing (Ratio a)

instance euclideanRingRatio :: (Ord a, EuclideanRing a) => EuclideanRing (Ratio a) where
  degree _ = 1
  div (Ratio a b) (Ratio c d) = reduce (a * d) (b * c)
  mod _ _ = zero

instance divisionRingRatio :: (Ord a, EuclideanRing a) => DivisionRing (Ratio a) where
  recip (Ratio a b) = Ratio b a

reduce :: forall a. Ord a => EuclideanRing a => a -> a -> Ratio a
reduce n d =
  let
    g = gcd n d
    d' = d / g
  in
    Ratio ((n / g) * signum d') (abs d')

infixl 7 reduce as %

numerator :: forall a. Ratio a -> a
numerator (Ratio a _) = a

denominator :: forall a. Ratio a -> a
denominator (Ratio _ b) = b
