module Paths_frontend (
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
libdir     = "/home/paolino/.cabal/lib/x86_64-linux-ghcjs-0.2.0-ghc7_10_3/frontend-0.1.0.0-9kSPJ5h0EIeHUSUxw6Fsec"
datadir    = "/home/paolino/.cabal/share/x86_64-linux-ghcjs-0.2.0-ghc7_10_3/frontend-0.1.0.0"
libexecdir = "/home/paolino/.cabal/libexec"
sysconfdir = "/home/paolino/.cabal/etc"

getBinDir, getLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "frontend_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "frontend_libdir") (\_ -> return libdir)
getDataDir = catchIO (getEnv "frontend_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "frontend_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "frontend_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
