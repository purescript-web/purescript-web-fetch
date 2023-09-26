module JS.Fetch.RequestMode where

import Data.Maybe (Maybe(..))

data RequestMode
  = Cors
  | NoCors
  | SameOrigin
  | Navigate

toString :: RequestMode -> String
toString = case _ of
  Cors -> "cors"
  NoCors -> "no-cors"
  SameOrigin -> "same-origin"
  Navigate -> "navigate"

fromString :: String -> Maybe RequestMode
fromString = case _ of
  "cors" -> Just Cors
  "no-cors" -> Just NoCors
  "same-origin" -> Just SameOrigin
  "navigate" -> Just Navigate
  _ -> Nothing
