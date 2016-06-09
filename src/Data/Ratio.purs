module Data.Ratio where

import Prelude

data Ratio a = Ratio a a

instance semiringRatio :: (Semiring a) => Semiring (Ratio a) where
  one = Ratio one one
  mul (Ratio a b) (Ratio c d) = Ratio (a * c) (b * d)
  zero = Ratio zero one
  add (Ratio a b) (Ratio c d) = Ratio ((a * d) + (b * c)) (b * d)

instance ringRatio :: (Ring a) => Ring (Ratio a) where
  sub (Ratio a b) (Ratio c d) = Ratio ((a * d) - (b * c)) (b * d)

instance commutativeRingRatio :: (CommutativeRing a) => CommutativeRing (Ratio a)

instance euclideanRingRatio :: (CommutativeRing a, Semiring a) => EuclideanRing (Ratio a) where
  degree _ = 1
  div (Ratio a b) (Ratio c d) = Ratio (a * d) (b * c)
  mod _ _ = zero

instance fieldRatio :: (Field a) => Field (Ratio a)

numerator :: forall a. Ratio a -> a
numerator (Ratio a _) = a

denominator :: forall a. Ratio a -> a
denominator (Ratio _ b) = b
