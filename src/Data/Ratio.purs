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

instance moduloSemiringRatio :: (Ring a, ModuloSemiring a) => ModuloSemiring (Ratio a) where
  mod _ _ = zero
  div (Ratio a b) (Ratio c d) = Ratio (a * d) (b * c)

instance divisionRingRatio :: (DivisionRing a) => DivisionRing (Ratio a)

instance numRatio :: (Num a) => Num (Ratio a)

numerator :: forall a. Ratio a -> a
numerator (Ratio a _) = a

denominator :: forall a. Ratio a -> a
denominator (Ratio _ b) = b
