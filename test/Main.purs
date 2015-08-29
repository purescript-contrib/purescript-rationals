module Test.Main where

import Prelude
import Control.Monad.Eff.Console
import Data.Rational
import Test.StrongCheck
import Test.StrongCheck.Gen


newtype TestRational = TestRational Rational

instance arbitraryTestRational :: Arbitrary TestRational where
  arbitrary = do
    a <- chooseInt (-99.0) 99.0
    b <- suchThat (chooseInt (-99.0) 99.0) (/= 0)
    return $ TestRational $ a % b

main = do
  -- Commutative monoid under addition
  quickCheck identity
  quickCheck identityZero
  quickCheck associative
  quickCheck commutative

  -- Semiring

  -- Monoid under multiplication
  quickCheck multAssoc
  quickCheck multIdentity

  -- Multiplication distributes over addition
  quickCheck leftDistributivity
  quickCheck rightDistributivity

  quickCheck annihilation
  quickCheck annihilation2

  quickCheck ordReflexivity
  quickCheck ordAntisymmetry
  quickCheck ordTransitivity

    where

    identity :: TestRational -> Result
    identity (TestRational a) = (zero + a) === (a + zero)

    identityZero :: TestRational -> Result
    identityZero (TestRational a) = a === (a + zero)

    associative :: TestRational -> TestRational -> TestRational -> Result
    associative (TestRational a) (TestRational b) (TestRational c) = (a + b) + c === a + (b + c)

    commutative :: TestRational -> TestRational -> Result
    commutative (TestRational a) (TestRational b) = a + b === b + a

    multAssoc :: TestRational -> TestRational -> TestRational -> Result
    multAssoc (TestRational a) (TestRational b) (TestRational c) = (a * b) * c === a * (b * c)

    multIdentity :: TestRational -> Boolean
    multIdentity (TestRational a) = one * a == a * one && a == a * one

    leftDistributivity :: TestRational -> TestRational -> TestRational -> Result
    leftDistributivity (TestRational a) (TestRational b) (TestRational c) = a * (b + c) === (a * b) + (a * c)

    rightDistributivity :: TestRational -> TestRational -> TestRational -> Result
    rightDistributivity (TestRational a) (TestRational b) (TestRational c) = (a + b) * c === (a * c) + (b * c)

    annihilation :: TestRational -> Result
    annihilation (TestRational a) = zero * a === a * zero

    annihilation2 :: TestRational -> Result
    annihilation2 (TestRational a) = zero === a * zero

    ordReflexivity :: TestRational -> Boolean
    ordReflexivity (TestRational a) = a <= a

    ordAntisymmetry :: TestRational -> TestRational -> Boolean
    ordAntisymmetry (TestRational a) (TestRational b) = if a <= b && b <= a then a == b else true

    ordTransitivity :: TestRational -> TestRational -> TestRational -> Boolean
    ordTransitivity (TestRational a) (TestRational b) (TestRational c) = if a <= b && b <= c then a <= c else true
