module Data.Rational
  ( Rational(..)
  , rational
  , (%)
  , toNumber
  , fromInt
  ) where

import Prelude
import Data.Int as Int
import Data.Ord (signum)
import Data.Ratio (Ratio(Ratio))

newtype Rational = Rational (Ratio Int)

instance showRational :: Show Rational where
  show (Rational (Ratio a b)) = show a <> " % " <> show b

instance eqRational :: Eq Rational where
  eq x y = eq' (reduce x) (reduce y)
    where
    eq' (Rational (Ratio a' b')) (Rational (Ratio c' d')) = a' == c' && b' == d'

instance ordRational :: Ord Rational where
  compare (Rational x) (Rational y) = case x / y of Ratio a b -> compare a b

instance semiringRational :: Semiring Rational where
  one = Rational one
  mul (Rational a) (Rational b) = reduce $ Rational $ a `mul` b
  zero = Rational zero
  add (Rational a) (Rational b) = reduce $ Rational $ a `add` b

instance ringRational :: Ring Rational where
  sub (Rational a) (Rational b) = reduce $ Rational $ a `sub` b

instance commutativeRingRational :: CommutativeRing Rational

instance euclideanRingRational :: EuclideanRing Rational where
  degree (Rational a) = degree a
  div (Rational a) (Rational b) = Rational $ a `div` b
  mod _ _ = Rational zero

instance fieldRational :: Field Rational

infixl 7 rational as %

rational :: Int -> Int -> Rational
rational x y = reduce $ Rational $ Ratio x y

toNumber :: Rational -> Number
toNumber (Rational (Ratio a b)) = Int.toNumber a / Int.toNumber b

fromInt :: Int -> Rational
fromInt i = Rational $ Ratio i 1

reduce :: Rational -> Rational
reduce (Rational (Ratio a b)) =
  let g = gcd a b
      b' = b / g
  in Rational $ Ratio ((a / g) * signum b') (degree b')
