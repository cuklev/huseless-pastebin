module Helpers.RandID
    ( randID
    ) where

import System.Random
import Data.Text (Text, pack)

idLen :: Int
idLen = 24

symbols :: String
symbols = ['a'..'z'] ++ ['A'..'Z'] ++ ['0'..'9']

randID :: IO Text
randID = do
    ind <- sequence $ replicate idLen $ randomRIO (0, length symbols - 1)
    return $ pack $ map (symbols !!) ind
