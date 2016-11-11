{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
{-# LANGUAGE TemplateHaskell   #-}
module Handler.Home where

import Foundation
import Yesod.Core
import Yesod.Persist
import Model

getHomeR :: Handler Html
getHomeR = do
    pasteEnt <- runDB $ selectList [] [ LimitTo 20, Desc PasteTimestamp ]
    let pastes = map entityVal pasteEnt
    defaultLayout $ do
        setTitle "Pastebin"
        $(whamletFile "templates/home.hamlet")
