{-# LANGUAGE TemplateHaskell       #-}
{-# LANGUAGE FlexibleInstances     #-}
{-# LANGUAGE MultiParamTypeClasses #-}

------------------------------------------------------------------------------
-- | This module defines our application's state type and an alias for its
-- handler monad.
module Application where

------------------------------------------------------------------------------
import Control.Lens
import Data.Map (Map)
import Control.Concurrent.STM
import Control.Monad.IO.Class (liftIO)
import Control.Monad.Reader.Class
import Control.Monad.State.Class
import Snap.Snaplet
import Snap.Snaplet.Heist
import Snap.Snaplet.Auth
import Snap.Snaplet.Session
import qualified Network.WebSockets as WS

------------------------------------------------------------------------------
data App = App

makeLenses ''App

type AppHandler = Handler App App
