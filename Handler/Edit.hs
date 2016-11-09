{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
{-# LANGUAGE TemplateHaskell   #-}
module Handler.Edit where

import Foundation
import Yesod.Core
import Yesod.Persist
import Data.Text (Text)
import Database.Persist
import Yesod.Form.Functions
import Yesod.Form.Fields
import Yesod.Form.Types
import Model
import Handler.Create (pasteForm)

getEditR :: Text -> Handler Html
getEditR p = do
    pastes <- runDB $ selectList [ PasteEditId ==. p ] [ LimitTo 1 ]
    let paste = entityVal $ head pastes
    (pasteW, enctype) <- generateFormPost $ pasteForm $ Just paste
    defaultLayout $ do
        setTitle "Pastebin"
        $(whamletFile "templates/edit.hamlet")

postEditR :: Text -> Handler Html
postEditR p = do
    ((res, pasteW), enctype) <- runFormPost $ pasteForm Nothing
    case res of
        FormSuccess paste -> do
            _ <- runDB $ updateWhere [ PasteEditId ==. p ] [ PasteFilename =. pasteFilename paste, PasteContents =. pasteContents paste ]
            redirect $ EditR p
