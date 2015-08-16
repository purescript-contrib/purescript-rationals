module Test.Main where

import Prelude
import Control.Monad.Eff.Console
import Data.Rational

main = do
  print $ toNumber $ (1 % 10) + (1 % 5)
  print $ 2 % 10
  print $ 10 % 5 == 4 % 2
