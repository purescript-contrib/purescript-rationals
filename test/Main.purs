module Test.Main where

import Prelude

import Data.Rational (Rational, (%))
import Effect (Effect)
import Effect.Console (log)
import JS.BigInt (BigInt, fromInt)
import Test.QuickCheck (Result, quickCheck', (===))
import Test.QuickCheck.Arbitrary (class Arbitrary, arbitrary)
import Test.QuickCheck.Gen (Gen, suchThat)
import Test.QuickCheck.Laws (checkLaws)
import Test.QuickCheck.Laws.Data as Data
import Test.QuickCheck.Laws.Data.Field (checkField) as DataField
import Type.Proxy (Proxy(..))

newtype TestRational = TestRational Rational

derive newtype instance commutativeRingTestRational :: CommutativeRing TestRational
derive newtype instance eqTestRational :: Eq TestRational
derive newtype instance euclideanRingTestRational :: EuclideanRing TestRational
derive newtype instance ordTestRational :: Ord TestRational
derive newtype instance ringTestRational :: Ring TestRational
derive newtype instance semiringTestRational :: Semiring TestRational
derive newtype instance divisionRingTestRational :: DivisionRing TestRational

bigint :: Gen BigInt
bigint = fromInt <$> arbitrary

nonZeroBigInt :: Gen BigInt
nonZeroBigInt = bigint `suchThat` notEq (fromInt 0)

newtype NonZeroBigInt = NonZeroBigInt BigInt

instance arbitraryNonZeroBigInt :: Arbitrary NonZeroBigInt where
  arbitrary = NonZeroBigInt <$> nonZeroBigInt

instance arbitraryTestRational :: Arbitrary TestRational where
  arbitrary = compose TestRational <<< (%) <$> bigint <*> nonZeroBigInt

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
  arbitrary = compose TestRatNonZero <<< (%) <$> nonZeroBigInt <*> nonZeroBigInt

testRatNonZero :: Proxy TestRatNonZero
testRatNonZero = Proxy

main :: Effect Unit
main = checkLaws "Rational" do
  Data.checkEq testRational
  Data.checkOrd testRational
  Data.checkSemiring testRational
  Data.checkRing testRational
  Data.checkCommutativeRing testRational
  DataField.checkField testRational
  Data.checkEuclideanRing testRatNonZero
  Data.checkDivisionRing testRational
  Data.checkDivisionRing testRatNonZero

  log "Checking 'Remainder' law for ModuloSemiring"
  quickCheck' 1000 remainder

  log "Checking `reduce`"
  quickCheck' 1000 reducing

  where

  remainder :: TestRatNonZero -> TestRatNonZero -> Result
  remainder (TestRatNonZero a) (TestRatNonZero b) = a / b * b + (a `mod` b) === a

  reducing :: NonZeroBigInt -> NonZeroBigInt -> NonZeroBigInt -> NonZeroBigInt -> Result
  reducing (NonZeroBigInt a) (NonZeroBigInt b) (NonZeroBigInt n) (NonZeroBigInt d) = (a * n) % (a * d) === (b * n) % (b * d)
