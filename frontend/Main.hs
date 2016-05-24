{-# language ScopedTypeVariables #-}
{-# language PackageImports #-}
{-# language NoMonomorphismRestriction #-}


module Main where

import Servant.API ((:<|>)((:<|>)))
import Servant.Reflex (client,BaseUrl(BaseFullUrl),Scheme(Http),reqSuccess)
import Data.Proxy (Proxy (Proxy))
import Reflex.Dom

import "common" API (api)

main :: IO ()
main = mainWidget run

server = constDyn $ BaseFullUrl Http "localhost" 8000 "api"

run :: forall t m. MonadWidget t m => m ()
run = do
    let (getNumber :<|> getText) = client api (Proxy :: Proxy m) server
    r <- button "getNumber" >>= getNumber
    holdDyn Nothing (reqSuccess <$> r) >>= display
    r <- button "getText" >>= getText
    holdDyn Nothing (reqSuccess <$> r) >>= display

