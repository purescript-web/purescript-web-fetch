module JS.Fetch.RequestRedirect where

import Data.Maybe (Maybe(..))

data RequestRedirect
  = Follow
  | Error
  | Manual

toString :: RequestRedirect -> String
toString = case _ of
  Follow -> "follow"
  Error -> "error"
  Manual -> "manual"

fromString :: String -> Maybe RequestRedirect
fromString = case _ of
  "follow" -> Just Follow
  "error" -> Just Error
  "manual" -> Just Manual
  _ -> Nothing
