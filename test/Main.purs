module Test.Main where

import Prelude

import Effect (Effect)
import Effect.Console (log)

import Data.Ratio ((%))
import Data.Rational (Rational)

import Test.StrongCheck (Result, quickCheck', (===))
import Test.StrongCheck.Arbitrary (class Arbitrary)
import Test.StrongCheck.Gen (Gen, chooseInt, suchThat)
import Test.StrongCheck.Laws (checkLaws)
import Test.StrongCheck.Laws.Data as Data

import Type.Proxy (Proxy(Proxy))

newtype TestRational = TestRational Rational

derive newtype instance commutativeRingTestRational :: CommutativeRing TestRational
derive newtype instance eqTestRational :: Eq TestRational
derive newtype instance euclideanRingTestRational :: EuclideanRing TestRational
derive newtype instance ordTestRational :: Ord TestRational
derive newtype instance ringTestRational :: Ring TestRational
derive newtype instance semiringTestRational :: Semiring TestRational
derive newtype instance divisionRingTestRational :: DivisionRing TestRational

int :: Gen Int
int = chooseInt (-999) 999

nonZeroInt :: Gen Int
nonZeroInt = int `suchThat` notEq 0

newtype SmallInt = SmallInt Int

instance arbitrarySmallInt :: Arbitrary SmallInt where
  arbitrary = SmallInt <$> int

newtype NonZeroInt = NonZeroInt Int

instance arbitraryNonZeroInt :: Arbitrary NonZeroInt where
  arbitrary = NonZeroInt <$> nonZeroInt

instance arbitraryTestRational :: Arbitrary TestRational where
  arbitrary = compose TestRational <<< (%) <$> int <*> nonZeroInt

testRational :: Proxy TestRational
testRational = Proxy

newtype TestRatNonZero = TestRatNonZero Rational

derive newtype instance eqTestRatNonZero :: Eq TestRatNonZero
derive newtype instance semiringTestRatNonZero :: Semiring TestRatNonZero
derive newtype instance ringTestRatNonZero :: Ring TestRatNonZero
derive newtype instance commutativeRingTestRatNonZero :: CommutativeRing TestRatNonZero
derive newtype instance euclideanRingTestRatNonZero :: EuclideanRing TestRatNonZero
derive newtype instance divisionRingTestRatNonZero :: DivisionRing TestRatNonZero

instance arbitraryTestRatNonZero :: Arbitrary TestRatNonZero where
  arbitrary = compose TestRatNonZero <<< (%) <$> nonZeroInt <*> nonZeroInt

testRatNonZero :: Proxy TestRatNonZero
testRatNonZero = Proxy

main :: Effect Unit
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

  log "Checking `reduce`"
  quickCheck' 1000 reducing

    where

    remainder :: TestRatNonZero -> TestRatNonZero -> Result
    remainder (TestRatNonZero a) (TestRatNonZero b) = a / b * b + (a `mod` b) === a

    reducing :: NonZeroInt -> NonZeroInt -> SmallInt -> NonZeroInt -> Result
    reducing (NonZeroInt a) (NonZeroInt b) (SmallInt n) (NonZeroInt d)
      = (a * n) % (a * d) === (b * n) % (b * d)
