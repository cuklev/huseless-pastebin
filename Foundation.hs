{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell   #-}
{-# LANGUAGE TypeFamilies      #-}
{-# LANGUAGE ViewPatterns      #-}
{-# LANGUAGE QuasiQuotes       #-}
{-# LANGUAGE GADTs             #-}
{-# LANGUAGE MultiParamTypeClasses   #-}
{-# LANGUAGE EmptyDataDecls #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
module Foundation where

import Yesod.Core
import Yesod.Persist
import Data.Text (Text)
import Database.Persist.Sqlite
import Yesod.Form.Types
import Database.Persist
import Yesod.Form.Functions

import Prelude
import Control.Applicative


data App = App { connPool :: ConnectionPool}

mkYesodData "App" $(parseRoutesFile "config/routes")

instance Yesod App where
    makeSessionBackend _ = Just <$> defaultClientSessionBackend 120 "config/client_session_key.aes"


share [mkPersist sqlSettings, mkMigrate "migrateAll"] [persistLowerCase|
Paste
    filename Text
    contents Text
    viewId   Text
    editId   Text
|]

instance YesodPersist App where
    type YesodPersistBackend App = SqlBackend
    runDB f = do
        master <- getYesod
        let pool = connPool master
        runSqlPool f pool

instance RenderMessage App FormMessage where
    renderMessage _ _ _ = ""

type Form x = Html -> MForm Handler (FormResult x, Widget)
