{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
{-# LANGUAGE TemplateHaskell   #-}
module Handler.View where

import Foundation
import Yesod.Core
import Yesod.Persist
import Data.Text (Text)
import Model

getViewR :: Text -> Handler Html
getViewR p = do
    pastes <- runDB $ selectList [ PasteViewId ==. p ] [ LimitTo 1 ]
    case pastes of
        [x] -> do
            let paste = entityVal x
            defaultLayout $ do
                setTitle "Pastebin"
                $(whamletFile "templates/view.hamlet")
        _ -> redirect ErrorR
