{-# LANGUAGE OverloadedStrings #-}
import Application () -- for YesodDispatch instance
import Foundation
import Yesod.Core
import Database.Persist.Sqlite
import Control.Monad.Logger (runStdoutLoggingT)

main :: IO ()
main = do
    pool <- runStdoutLoggingT $ createSqlitePool "pastebin.db3" 10
    warp 3000 $ App { connPool = pool }
