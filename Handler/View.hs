{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
{-# LANGUAGE TemplateHaskell   #-}
module Handler.View where

import Foundation
import Yesod.Core

getViewR :: Handler Html
getViewR = defaultLayout $ do
    setTitle "Pastebin"
    $(whamletFile "templates/view.hamlet")