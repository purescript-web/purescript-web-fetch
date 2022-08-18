module Fetch.Core.Integrity where

import Data.Newtype (class Newtype)
import Prelude (class Eq, class Ord)

newtype Integrity = Integrity String

derive instance newtypeIntegrity :: Newtype Integrity _
derive newtype instance eqIntegrity :: Eq Integrity
derive newtype instance ordIntegrity :: Ord Integrity
