{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
{-# LANGUAGE TemplateHaskell   #-}
module Handler.Error where

import Foundation
import Yesod.Core

getErrorR :: Handler Html
getErrorR = do
    defaultLayout $ do
        setTitle "Pastebin"
        $(whamletFile "templates/error.hamlet")
