{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
{-# LANGUAGE TemplateHaskell   #-}
module Handler.Edit where

import Foundation
import Yesod.Core

getEditR :: Handler Html
getEditR = defaultLayout $ do
    setTitle "Pastebin"
    $(whamletFile "templates/edit.hamlet")

postEditR :: Handler Html
postEditR = getEditR
