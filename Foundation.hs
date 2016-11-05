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

data App = App { connPool :: ConnectionPool}

mkYesodData "App" $(parseRoutesFile "config/routes")

instance Yesod App


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
