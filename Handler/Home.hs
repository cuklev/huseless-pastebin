{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
{-# LANGUAGE TemplateHaskell   #-}
module Handler.Home where

import Foundation
import Yesod.Core

getHomeR :: Handler Html
getHomeR = defaultLayout $ do
    setTitle "Pastebin"
    $(whamletFile "templates/home.hamlet")
