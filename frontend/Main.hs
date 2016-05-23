{-# language ScopedTypeVariables #-}
{-# language RankNTypes          #-}
{-# language LambdaCase          #-}
{-# language OverloadedStrings   #-}
{-# language CPP                 #-}
{-# language RecursiveDo         #-}

module Main where

import Reflex.Dom
import Servant.Reflex.BaseUrl (BaseUrl (BaseFullUrl),Scheme(Http))
import Servant.Reflex.Req
import Servant.Reflex -- (BaseUrl (BaseUrl),Scheme (HTTP),client)
import API
import Data.Proxy

-- > getAllBooks :: Event t () -> m (Event t (Either XhrError ((),[Book])))
------------------------------------------------------------------------------
main :: IO ()
main = mainWidget run

run :: forall t m. MonadWidget t m => m ()
run = do
    let getA = client api (Proxy :: Proxy m) $ constDyn $ BaseFullUrl Http "localhost" 8000 ""
    r <- button "getA" >>= getA
    succ <- holdDyn Nothing (reqSuccess <$> r)
    fail <- holdDyn Nothing (reqFailure <$> r)
    display succ
    display fail

