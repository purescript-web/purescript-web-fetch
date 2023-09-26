module JS.Fetch.RequestCache where

import Data.Maybe (Maybe(..))

data RequestCache
  = Default
  | NoStore
  | Reload
  | NoCache
  | ForceCache
  | OnlyIfCached

toString :: RequestCache -> String
toString = case _ of
  Default -> "default"
  NoStore -> "no-store"
  Reload -> "reload"
  NoCache -> "no-cache"
  ForceCache -> "force-cache"
  OnlyIfCached -> "only-if-cached"

fromString :: String -> Maybe RequestCache
fromString = case _ of
  "default" -> Just Default
  "no-store" -> Just NoStore
  "reload" -> Just Reload
  "no-cache" -> Just NoCache
  "force-cache" -> Just ForceCache
  "only-if-cached" -> Just OnlyIfCached
  _ -> Nothing
