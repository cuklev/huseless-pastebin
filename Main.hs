{-# LANGUAGE OverloadedStrings #-}
import Application () -- for YesodDispatch instance
import Foundation
import Yesod.Core
import Database.Persist.Sqlite
import Control.Monad.Logger (runStdoutLoggingT)

main :: IO ()
main = do
    pool <- runStdoutLoggingT $ createSqlitePool "pastebin.sqlite3" 10
    runSqlPersistMPool (runMigration migrateAll) pool
    warp 3000 $ App { connPool = pool }
