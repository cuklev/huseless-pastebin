{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
{-# LANGUAGE TemplateHaskell   #-}
module Handler.Create where

import Foundation
import Yesod.Core
import Yesod.Persist
import Yesod.Form.Functions
import Yesod.Form.Types
import Yesod.Form.Fields
import Helpers.RandID
import Model

getCreateR :: Handler Html
getCreateR = do
    (pasteW, enctype) <- generateFormPost $ pasteForm Nothing
    defaultLayout $ do
        setTitle "Pastebin"
        $(whamletFile "templates/create.hamlet")

postCreateR :: Handler Html
postCreateR = do
    ((res, pasteW), enctype) <- runFormPost $ pasteForm Nothing
    case res of
        FormSuccess paste -> do
            _ <- runDB $ insert paste
            redirect $ EditR $ pasteEditId paste
--        _ -> error "pesho"

pasteForm :: Maybe Paste -> Form Paste
pasteForm mpaste = renderDivs $ Paste
    <$> areq textField "Filename" (fmap pasteFilename mpaste)
    <*> areq textareaField contentsSettings (fmap pasteContents mpaste)
    <*> pure ""
    <*> pure ""
    where contentsSettings = FieldSettings
            { fsLabel = "Contents"
            , fsTooltip = Nothing
            , fsId = Nothing
            , fsName = Nothing
            , fsAttrs = [("rows", "40"), ("cols", "40")]
            }
