module JS.Fetch
  ( FetchOptions
  , fetch
  , fetchWithOptions
  ) where

import Effect (Effect)
import Effect.Uncurried (EffectFn2, runEffectFn2)
import JS.Fetch.AbortController (AbortSignal)
import JS.Fetch.Request (Request)
import JS.Fetch.Response (Response)
import Prim.Row as Row
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
