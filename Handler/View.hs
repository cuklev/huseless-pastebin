{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
{-# LANGUAGE TemplateHaskell   #-}
module Handler.View where

import Foundation
import Yesod.Core
import Yesod.Persist
import Data.Text (Text)
import Database.Persist
import Model

getViewR :: Text -> Handler Html
getViewR p = do
    pastes <- runDB $ selectList [ PasteViewId ==. p ] [LimitTo 1]
    let paste = entityVal $ head pastes
    defaultLayout $ do
        setTitle "Pastebin"
        $(whamletFile "templates/view.hamlet")
