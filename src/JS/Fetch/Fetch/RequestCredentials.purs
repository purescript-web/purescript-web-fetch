module JS.Fetch.RequestCredentials where

import Data.Maybe (Maybe(..))

data RequestCredentials
  = Omit
  | SameOrigin
  | Include

toString :: RequestCredentials -> String
toString = case _ of
  Omit -> "omit"
  SameOrigin -> "same-origin"
  Include -> "include"

fromString :: String -> Maybe RequestCredentials
fromString = case _ of
  "omit" -> Just Omit
  "same-origin" -> Just SameOrigin
  "include" -> Just Include
  _ -> Nothing
