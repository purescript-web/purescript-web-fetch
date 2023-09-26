module JS.Fetch.Duplex where

import Prelude

import Data.Maybe (Maybe(..))

data Duplex = Half | Full

derive instance Eq Duplex
derive instance Ord Duplex

toString :: Duplex -> String
toString = case _ of
  Half -> "half"
  Full -> "full"

fromString :: String -> Maybe Duplex
fromString = case _ of
  "full" -> Just Full
  "half" -> Just Half
  _ -> Nothing
