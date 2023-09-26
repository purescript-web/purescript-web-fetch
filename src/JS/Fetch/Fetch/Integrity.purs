module JS.Fetch.Integrity where

import Data.Newtype (class Newtype)
import Prelude (class Eq, class Ord)

newtype Integrity = Integrity String

derive instance Newtype Integrity _
derive newtype instance Eq Integrity
derive newtype instance Ord Integrity
