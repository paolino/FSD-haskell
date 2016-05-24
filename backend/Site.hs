{-# LANGUAGE OverloadedStrings   #-}
{-# LANGUAGE PackageImports #-}

module Site
  ( app
  ) where

------------------------------------------------------------------------------
import           Servant.API ((:<|>)((:<|>)))
-----------------------
import           Servant.Server (serve)
import           Servant.Server.Internal.SnapShims (applicationToSnap, Application)
-----------------------
import           Snap.Snaplet (makeSnaplet,addRoutes,SnapletInit,Handler)
import           Snap.Util.FileServe  (serveDirectory)
------------------------------------------------------------------------------
import "common"  API (api)


data App = App

-- makeLenses ''App

apiApplication :: Application (Handler App App)
apiApplication = serve api $ 
    return 42 :<|> return "why worry?"

app :: SnapletInit App App
app = makeSnaplet "app" "A snaplet example application." Nothing $ do

    addRoutes   [   ("api"  , applicationToSnap apiApplication)
                ,   (""     , serveDirectory "static")

                ]
    return App

