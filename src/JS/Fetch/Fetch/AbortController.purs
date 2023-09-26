module JS.Fetch.AbortController where

import Effect (Effect)
import Prelude (Unit)

foreign import data AbortController :: Type

foreign import data AbortSignal :: Type

foreign import new :: Effect AbortController

foreign import abort :: AbortController -> Effect Unit

foreign import signal :: AbortController -> AbortSignal
