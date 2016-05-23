{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}

module API where

import Servant.API
import Data.Proxy

type API = "a" :> Get '[JSON] Int

api :: Proxy API
api = Proxy
