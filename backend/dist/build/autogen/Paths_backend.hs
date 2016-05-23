module Paths_backend (
    version,
    getBinDir, getLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/home/paolino/.cabal/bin"
libdir     = "/home/paolino/.cabal/lib/x86_64-linux-ghc-7.10.3/backend-0.1.0.0-36VJBjh0a9r35Vb2MsGOGW"
datadir    = "/home/paolino/.cabal/share/x86_64-linux-ghc-7.10.3/backend-0.1.0.0"
libexecdir = "/home/paolino/.cabal/libexec"
sysconfdir = "/home/paolino/.cabal/etc"

getBinDir, getLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "backend_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "backend_libdir") (\_ -> return libdir)
getDataDir = catchIO (getEnv "backend_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "backend_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "backend_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
