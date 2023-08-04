module Fetch.Core
  ( FetchOptions
  , fetch
  , fetchWithOptions
  ) where

import Effect (Effect)
import Effect.Uncurried (EffectFn2, runEffectFn2)
import Prim.Row as Row
import Fetch.Core.AbortController (AbortSignal)
import Fetch.Core.Request (Request)
import Fetch.Core.Response (Response)
import Promise (Promise)

type FetchOptions =
  ( keepalive :: Boolean
  , signal :: AbortSignal
  )

foreign import _fetch :: forall r. EffectFn2 Request { | r } (Promise Response)

fetch :: Request -> Effect (Promise Response)
fetch req = runEffectFn2 _fetch req {}

fetchWithOptions :: forall r rx. Row.Union r rx FetchOptions => Request -> { | r } -> Effect (Promise Response)
fetchWithOptions = runEffectFn2 _fetch
