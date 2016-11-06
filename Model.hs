{-# LANGUAGE QuasiQuotes                  #-}
{-# LANGUAGE TemplateHaskell              #-}
{-# LANGUAGE OverloadedStrings            #-}
{-# LANGUAGE TypeFamilies                 #-}
{-# LANGUAGE GADTs                        #-}
{-# LANGUAGE EmptyDataDecls               #-}
{-# LANGUAGE MultiParamTypeClasses        #-}
{-# LANGUAGE GeneralizedNewtypeDeriving   #-}
module Model where

import Data.Text (Text)
import Database.Persist.TH
import Database.Persist.Quasi

share [mkPersist sqlSettings, mkMigrate "migrateAll"]
    $(persistFileWith lowerCaseSettings "config/models")
