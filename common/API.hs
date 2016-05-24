{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}

module API where

import Servant.API
import Data.Proxy

type API =  "number" :> Get '[JSON] Int 
            :<|>
            "text" :> Get '[JSON] String

api :: Proxy API
api = Proxy
