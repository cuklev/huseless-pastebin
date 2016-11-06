{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
{-# LANGUAGE TemplateHaskell   #-}
module Handler.View where

import Foundation
import Yesod.Core
import Data.Text (Text)

getViewR :: Text -> Handler Html
getViewR id = defaultLayout $ do
    setTitle "Pastebin"
    $(whamletFile "templates/view.hamlet")
