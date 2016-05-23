{-# LANGUAGE OverloadedStrings   #-}
{-# LANGUAGE ScopedTypeVariables #-}

------------------------------------------------------------------------------
-- | This module is where all the routes and handlers are defined for your
-- site. The 'app' function is the initializer that combines everything
-- together and is exported by this module.
module Site
  ( app
  ) where

------------------------------------------------------------------------------
import           Control.Applicative
import           Control.Concurrent.STM
import           Control.Monad (forever, join)
import           Control.Monad.IO.Class    (liftIO)
import           Control.Monad.Trans.Class (lift)
import           Control.Monad.State (gets)
import qualified Data.Aeson as A
import           Data.Bifunctor (first)
import qualified Data.ByteString.Char8  as BS
import           Data.ByteString (ByteString)
import qualified Data.ByteString.Lazy   as BSL
import qualified Data.Configurator      as C
import           Data.Foldable
import qualified Data.Map as Map
import           Data.Map.Syntax ((##))
import           Data.Maybe (listToMaybe)
import           Data.Monoid
import           Data.Proxy
import qualified Data.Set as Set
import           Data.Time              (getCurrentTime)
import qualified Data.Text as T
import qualified Data.Text.Encoding as T
import           GHC.Generics
import           GHC.Int
import qualified Heist.Interpreted as I
import           Servant hiding (GET, POST, PUT, DELETE)
import           Servant.Server
import           Servant.Server.Internal.SnapShims
import           Snap.Core
import           Snap.Snaplet
import           Snap.Snaplet.Session
import qualified Snap.Snaplet.Heist as SHeist
import qualified Snap.Snaplet.Heist.Interpreted as I
import           Snap.Snaplet.Session.Backends.CookieSession
-- import           Snap.Util.FileServe
import qualified Network.WebSockets as WS
import qualified Network.WebSockets.Snap as WS
import           Web.HttpApiData (parseUrlPiece)
------------------------------------------------------------------------------
import           Application
import           API


apiServer :: Server API AppHandler
apiServer = serveA

apiApplication :: Application AppHandler
apiApplication = serve api apiServer


serveA :: AppHandler Int
serveA = return 42

------------------------------------------------------------------------------
-- | The application initializer.
app :: SnapletInit App App
app = makeSnaplet "app" "An snaplet example application." Nothing $ do

    addRoutes [ ("", applicationToSnap apiApplication)
                ,("", serveDirectory "static")
                ]
    return App

