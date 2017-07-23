module Data.Rational
  ( Rational
  , toNumber
  , fromInt
  , module Data.Ratio
  ) where

import Prelude
import Data.Int as Int
import Data.Ratio (Ratio, (%), numerator, denominator)

type Rational = Ratio Int

toNumber :: Rational -> Number
toNumber x = Int.toNumber (numerator x) / Int.toNumber (denominator x)

fromInt :: Int -> Rational
fromInt i = i % 1
