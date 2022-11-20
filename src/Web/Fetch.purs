module Web.Fetch
  ( FetchOptions
  , fetch
  , fetchWithOptions
  ) where

import Effect (Effect)
import Effect.Uncurried (EffectFn2, runEffectFn2)
import Prim.Row as Row
import Promise (Promise)
import Web.Fetch.AbortController (AbortSignal)
import Web.Fetch.Request (Request)
import Web.Fetch.Response (Response)

type FetchOptions =
  ( keepalive :: Boolean
  , signal :: AbortSignal
  )

foreign import _fetch :: forall r. EffectFn2 Request { | r } (Promise Response)

fetch :: Request -> Effect (Promise Response)
fetch req = runEffectFn2 _fetch req {}

fetchWithOptions :: forall r rx. Row.Union r rx FetchOptions => Request -> { | r } -> Effect (Promise Response)
fetchWithOptions = runEffectFn2 _fetch