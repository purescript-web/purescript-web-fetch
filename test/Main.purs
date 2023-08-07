module Test.Main where

import Prelude

import Control.Promise as Promise
import Data.HTTP.Method (Method(..))
import Debug (spy)
import Effect (Effect)
import Effect.Aff (launchAff_)
import Effect.Class (liftEffect)
import Effect.Class.Console (log)
import Fetch.Core as Fetch
import Fetch.Core.Duplex (Duplex(..))
import Fetch.Core.Headers as Headers
import Fetch.Core.Request as Request
import Fetch.Core.RequestBody as RequestBody
import Fetch.Core.Response as Response
import Unsafe.Coerce (unsafeCoerce)

main :: Effect Unit
main = launchAff_ do
  let requestBody = """{"hello":"world"}"""
  request <- liftEffect $ Request.new "http://httpbin.org/post"
    { method: POST
    , body: RequestBody.fromString requestBody
    , headers: Headers.fromRecord { "Content-Type": "application/json" }
    , duplex: Half
    }
  let _ = spy "request" request
  response <- Promise.toAffE $ unsafeCoerce $ Fetch.fetch request
  responseBody <- Promise.toAffE $ unsafeCoerce $ Response.text response
  let _ = spy "response" response
  log $ show $ Response.status response
  log responseBody
  log "You should add some tests."
