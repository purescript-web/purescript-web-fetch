module JS.Fetch.Headers
  ( Headers
  , fromFoldable
  , fromRecord
  , fromObject
  , toArray
  , toUnfoldable
  , empty
  ) where

import Prelude

import Data.Array as Array
import Data.Foldable (class Foldable, foldM)
import Data.Function.Uncurried (Fn2, runFn2)
import Data.Tuple (Tuple(..))
import Data.Unfoldable (class Unfoldable)
import Effect (Effect)
import Effect.Uncurried (EffectFn3, runEffectFn3)
import Effect.Unsafe (unsafePerformEffect)
import Foreign.Object (Object)
import Type.Row.Homogeneous (class Homogeneous)

foreign import data Headers :: Type

foreign import unsafeNew :: Effect Headers

foreign import unsafeAppend :: EffectFn3 String String Headers Unit

foreign import unsafeFromRecord :: forall r. { | r } -> Headers

foreign import _toArray :: Fn2 (forall a b. a -> b -> Tuple a b) Headers (Array (Tuple String String))

foreign import fromObject :: Object String -> Headers

fromFoldable :: forall f. Foldable f => f (Tuple String String) -> Headers
fromFoldable f = unsafePerformEffect do
  init <- unsafeNew
  foldM
    ( \headers (Tuple key value) -> do
        runEffectFn3 unsafeAppend key value headers
        pure headers
    )
    init
    f

fromRecord :: forall r. Homogeneous r String => { | r } -> Headers
fromRecord = unsafeFromRecord

toArray :: Headers -> Array (Tuple String String)
toArray = runFn2 _toArray Tuple

toUnfoldable :: forall f. Unfoldable f => Headers -> f (Tuple String String)
toUnfoldable = Array.toUnfoldable <<< toArray

empty :: Headers
empty = fromFoldable []
