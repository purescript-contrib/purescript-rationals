module Data.Rational
  ( Rational
  , (%)
  , toNumber
  , fromInt
  , fromBigInt
  , numerator
  , denominator
  , class ToRational
  , toRational
  ) where

import Prelude

import Data.Int as Int
import Data.Ratio (Ratio, denominator, numerator, (%))
import Data.Ratio as Ratio
import JS.BigInt (BigInt)
import JS.BigInt as BigInt

newtype Rational = Rational (Ratio.Ratio BigInt)

derive newtype instance Eq Rational
derive newtype instance Ord Rational
derive newtype instance Show Rational
derive newtype instance Semiring Rational
derive newtype instance Ring Rational
derive newtype instance CommutativeRing Rational
derive newtype instance EuclideanRing Rational
derive newtype instance DivisionRing Rational

toNumber :: Rational -> Number
toNumber (Rational x) = BigInt.toNumber (Ratio.numerator x) / BigInt.toNumber (Ratio.denominator x)

fromInt :: Int -> Rational
fromInt i = Rational $ Ratio.reduce (BigInt.fromInt i) (BigInt.fromInt 1)

fromBigInt :: BigInt -> Rational
fromBigInt i = Rational $ Ratio.reduce i (BigInt.fromInt 1)

numerator :: Rational -> BigInt
numerator (Rational x) = Ratio.numerator x

denominator :: Rational -> BigInt
denominator (Rational x) = Ratio.denominator x

class
  ToRational a
  where
  toRational :: a -> a -> Rational

instance ToRational Int
  where
  toRational a b = Rational $ Ratio.reduce (BigInt.fromInt a) (BigInt.fromInt b)

instance ToRational BigInt
  where
  toRational a b = Rational $ Ratio.reduce a b

infixl 7 toRational as %
