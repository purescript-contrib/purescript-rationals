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

newtype TestRatNonZero = TestRatNonZero Rational

instance arbitraryTestRatNonZero :: Arbitrary TestRatNonZero where
  arbitrary = do
    a <- suchThat (chooseInt (-99.0) 99.0) (/= 0)
    b <- suchThat (chooseInt (-99.0) 99.0) (/= 0)
    return $ TestRatNonZero $ a % b

main = do
  log "Semiring: commutative monoid under addition:"
  log "- associative"
  quickCheck associative
  log "- identity"
  quickCheck identity
  log "- identityZero"
  quickCheck identityZero
  log "- commutative"
  quickCheck commutative

  log "Semiring: Monoid under multiplication"
  log "- associative"
  quickCheck multAssoc
  log "- identity"
  quickCheck multIdentity

  log "Semiring: Multiplication distributes over addition"
  log "- left distributivity"
  quickCheck leftDistributivity
  log "- right distributivity"
  quickCheck rightDistributivity
  log "- annihilation"
  quickCheck annihilation

  log "ModuloSemiring"
  log "- remainder"
  quickCheck remainder

  log "DivisionRing"
  log "- multiplicative inverse"
  quickCheck multiplicativeInverse

  log "Num:"
  log "- commutative multiplication"
  quickCheck commutativeMultiplication

  log "Ord"
  log "- reflexivity"
  quickCheck ordReflexivity
  log "- antisymmetry"
  quickCheck ordAntisymmetry
  log "- transitivity"
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
