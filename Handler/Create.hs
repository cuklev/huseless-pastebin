{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
{-# LANGUAGE TemplateHaskell   #-}
module Handler.Create
    ( getCreateR
    , postCreateR
    ) where

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
    (pasteW, enctype) <- generateFormPost pasteForm
    defaultLayout $ do
        setTitle "Pastebin"
        $(whamletFile "templates/create.hamlet")

postCreateR :: Handler Html
postCreateR = do
    ((res, pasteW), enctype) <- runFormPost pasteForm
    case res of
        FormSuccess paste -> do
            _ <- runDB $ insert paste
            let (Paste _ _ v _) = paste
            redirect $ ViewR v
--        _ -> error "pesho"

pasteForm :: Form Paste
pasteForm = renderDivs $ Paste
    <$> areq textField "Filename" Nothing
    <*> areq textField "Contents" Nothing
    <*> lift (liftIO randID)
    <*> lift (liftIO randID)
