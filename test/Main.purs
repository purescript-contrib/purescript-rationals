module Test.Main where

import Prelude
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE, log)
import Control.Monad.Eff.Random (RANDOM)
import Control.Monad.Eff.Exception (EXCEPTION)
import Data.Rational (Rational, (%))
import Test.StrongCheck (Result, quickCheck, (===))
import Test.StrongCheck.Arbitrary (class Arbitrary)
import Test.StrongCheck.Gen (chooseInt, suchThat)
import Test.StrongCheck.Laws.Data.CommutativeRing (checkCommutativeRing)
import Test.StrongCheck.Laws.Data.Eq (checkEq)
import Test.StrongCheck.Laws.Data.EuclideanRing (checkEuclideanRing)
import Test.StrongCheck.Laws.Data.Field (checkField)
import Test.StrongCheck.Laws.Data.Ord (checkOrd)
import Test.StrongCheck.Laws.Data.Ring (checkRing)
import Test.StrongCheck.Laws.Data.Semiring (checkSemiring)

import Type.Proxy (Proxy(Proxy))

newtype TestRational = TestRational Rational

derive newtype instance commutativeRingTestRational :: CommutativeRing TestRational
derive newtype instance eqTestRational :: Eq TestRational
derive newtype instance fieldTestRational :: Field TestRational
derive newtype instance ordTestRational :: Ord TestRational
derive newtype instance ringTestRational :: Ring TestRational
derive newtype instance semiringTestRational :: Semiring TestRational

instance arbitraryTestRational :: Arbitrary TestRational where
  arbitrary = do
    a <- chooseInt (-99) 99
    b <- suchThat (chooseInt (-99) 99) (_ /= 0)
    pure $ TestRational $ a % b

testRational :: Proxy TestRational
testRational = Proxy

newtype TestRatNonZero = TestRatNonZero Rational

derive newtype instance eqTestRatNonZero :: Eq TestRatNonZero
derive newtype instance euclideanRingTestRatNonZero :: EuclideanRing TestRatNonZero

instance arbitraryTestRatNonZero :: Arbitrary TestRatNonZero where
  arbitrary = do
    a <- suchThat (chooseInt (-99) 99) (_ /= 0)
    b <- suchThat (chooseInt (-99) 99) (_ /= 0)
    pure $ TestRatNonZero $ a % b

testRatNonZero :: Proxy TestRatNonZero
testRatNonZero = Proxy

main :: forall eff. Eff (console :: CONSOLE, random :: RANDOM, err :: EXCEPTION | eff) Unit
main = do
  checkEq testRational
  checkOrd testRational
  checkSemiring testRational
  checkRing testRational
  checkCommutativeRing testRational
  checkField testRational
  checkEuclideanRing testRatNonZero

  log "Checking 'Remainder' law for MuduloSemiring"
  quickCheck remainder

    where

    remainder :: TestRatNonZero -> TestRatNonZero -> Result
    remainder (TestRatNonZero a) (TestRatNonZero b) = a / b * b + (a `mod` b) === a
