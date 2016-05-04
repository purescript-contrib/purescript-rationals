module Test.Main where

import Prelude
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE, log)
import Control.Monad.Eff.Random (RANDOM)
import Control.Monad.Eff.Exception (EXCEPTION)
import Data.Rational (Rational, (%))
import Test.StrongCheck (class Arbitrary, Result, quickCheck, (===))
import Test.StrongCheck.Gen (chooseInt, suchThat)


newtype TestRational = TestRational Rational

instance arbitraryTestRational :: Arbitrary TestRational where
  arbitrary = do
    a <- chooseInt (-99.0) 99.0
    b <- suchThat (chooseInt (-99.0) 99.0) (_ /= 0)
    return $ TestRational $ a % b

newtype TestRatNonZero = TestRatNonZero Rational

instance arbitraryTestRatNonZero :: Arbitrary TestRatNonZero where
  arbitrary = do
    a <- suchThat (chooseInt (-99.0) 99.0) (_ /= 0)
    b <- suchThat (chooseInt (-99.0) 99.0) (_ /= 0)
    return $ TestRatNonZero $ a % b

main :: forall eff. Eff (console :: CONSOLE, random :: RANDOM, err :: EXCEPTION | eff) Unit
main = do
  log "Checking 'Associative' law for Semiring addition"
  quickCheck associative
  log "Checking 'Identity' law for Semiring addition"
  quickCheck identity
  log "Checking 'Identity zero' law for Semiring addition"
  quickCheck identityZero
  log "Checking 'Commutative' law for Semiring addition"
  quickCheck commutative

  log "Checking 'Associative' law for Semiring multiplication"
  quickCheck multAssoc
  log "Checking 'Identity' law for Semiring multiplication"
  quickCheck multIdentity

  log "Checking 'Left distribution' law for Semiring"
  quickCheck leftDistributivity
  log "Checking 'Right distribution' law for Semiring"
  quickCheck rightDistributivity
  log "Checking 'Annihilation' law for Semiring"
  quickCheck annihilation

  log "Checking 'Remainder' law for MuduloSemiring"
  quickCheck remainder

  log "Checking 'Multiplicative inverse' law for DivisionRing"
  quickCheck multiplicativeInverse

  log "Checking 'Commutative multiplication' law for Num"
  quickCheck commutativeMultiplication

  log "Checking 'Reflexivity' law for Ord"
  quickCheck ordReflexivity
  log "Checking 'Antisymmetry' law for Ord"
  quickCheck ordAntisymmetry
  log "Checking 'Transitivity' law for Ord"
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

    annihilation :: TestRational -> Boolean
    annihilation (TestRational a) = zero * a == a * zero && zero == a * zero

    ordReflexivity :: TestRational -> Boolean
    ordReflexivity (TestRational a) = a <= a

    ordAntisymmetry :: TestRational -> TestRational -> Boolean
    ordAntisymmetry (TestRational a) (TestRational b) = if a <= b && b <= a then a == b else true

    remainder :: TestRatNonZero -> TestRatNonZero -> Result
    remainder (TestRatNonZero a) (TestRatNonZero b) = a / b * b + (a `mod` b) === a

    multiplicativeInverse :: TestRatNonZero -> Result
    multiplicativeInverse (TestRatNonZero x) = (one / x) * x === one

    commutativeMultiplication :: TestRational -> TestRational -> Result
    commutativeMultiplication (TestRational a) (TestRational b) = a * b === b * a

    ordTransitivity :: TestRational -> TestRational -> TestRational -> Boolean
    ordTransitivity (TestRational a) (TestRational b) (TestRational c) = if a <= b && b <= c then a <= c else true
