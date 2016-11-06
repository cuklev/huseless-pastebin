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

getEditR :: Text -> Handler Html
getEditR p = do
    (pasteW, enctype) <- generateFormPost pasteForm
    pastes <- runDB $ selectList [ PasteEditId ==. p ] [LimitTo 1]
    let paste = entityVal $ head pastes
    defaultLayout $ do
        setTitle "Pastebin"
        $(whamletFile "templates/edit.hamlet")

postEditR :: Text -> Handler Html
postEditR p = do
    ((res, pasteW), enctype) <- runFormPost pasteForm
    case res of
        FormSuccess paste -> do
            _ <- runDB $ updateWhere [ PasteEditId ==. p ] [ PasteFilename =. pasteFilename paste, PasteContents =. pasteContents paste ]
            redirect $ EditR p

pasteForm :: Form Paste
pasteForm = renderDivs $ Paste
    <$> areq textField "Filename" Nothing
    <*> areq textField "Contents" Nothing
    <*> pure ""
    <*> pure ""
