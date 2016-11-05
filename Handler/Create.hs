{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
{-# LANGUAGE TemplateHaskell   #-}
module Handler.Create where

import Foundation
import Yesod.Core

getCreateR :: Handler Html
getCreateR = defaultLayout $ do
    setTitle "Pastebin"
    $(whamletFile "templates/create.hamlet")

postCreateR :: Handler Html
postCreateR = defaultLayout $ do
    setTitle "Pastebin"
    $(whamletFile "templates/create.hamlet")
