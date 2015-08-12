module Test.Main where

import Prelude
import Control.Monad.Eff.Console
import Data.Rational

main = do
  print $ toNumber $ (1 % 10) + (1 % 5)
