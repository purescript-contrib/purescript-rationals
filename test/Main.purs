module Test.Main where

import Prelude

import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE, log)
import Control.Monad.Eff.Random (RANDOM)
import Control.Monad.Eff.Exception (EXCEPTION)

import Data.Rational (Rational, (%))

import Test.StrongCheck (Result, quickCheck', (===))
import Test.StrongCheck.Arbitrary (class Arbitrary)
import Test.StrongCheck.Gen (Gen, chooseInt, suchThat)
import Test.StrongCheck.Laws (checkLaws)
import Test.StrongCheck.Laws.Data as Data

import Type.Proxy (Proxy(Proxy))

newtype TestRational = TestRational Rational

derive newtype instance commutativeRingTestRational :: CommutativeRing TestRational
derive newtype instance eqTestRational :: Eq TestRational
derive newtype instance fieldTestRational :: Field TestRational
derive newtype instance ordTestRational :: Ord TestRational
derive newtype instance ringTestRational :: Ring TestRational
derive newtype instance semiringTestRational :: Semiring TestRational

int :: Gen Int
int = chooseInt (-999) 999

nonZeroInt :: Gen Int
nonZeroInt = int `suchThat` notEq 0

instance arbitraryTestRational :: Arbitrary TestRational where
  arbitrary = compose TestRational <<< (%) <$> int <*> nonZeroInt

testRational :: Proxy TestRational
testRational = Proxy

newtype TestRatNonZero = TestRatNonZero Rational

derive newtype instance eqTestRatNonZero :: Eq TestRatNonZero
derive newtype instance euclideanRingTestRatNonZero :: EuclideanRing TestRatNonZero

instance arbitraryTestRatNonZero :: Arbitrary TestRatNonZero where
  arbitrary = compose TestRatNonZero <<< (%) <$> nonZeroInt <*> nonZeroInt

testRatNonZero :: Proxy TestRatNonZero
testRatNonZero = Proxy

main :: forall eff. Eff (console :: CONSOLE, random :: RANDOM, err :: EXCEPTION | eff) Unit
main = checkLaws "Rational" do
  Data.checkEq testRational
  Data.checkOrd testRational
  Data.checkSemiring testRational
  Data.checkRing testRational
  Data.checkCommutativeRing testRational
  Data.checkField testRational
  Data.checkEuclideanRing testRatNonZero

  log "Checking 'Remainder' law for MuduloSemiring"
  quickCheck' 1000 remainder

    where

    remainder :: TestRatNonZero -> TestRatNonZero -> Result
    remainder (TestRatNonZero a) (TestRatNonZero b) = a / b * b + (a `mod` b) === a
