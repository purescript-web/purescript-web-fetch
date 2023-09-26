module Test.Main where

import Prelude

import Control.Promise as Promise
import Data.HTTP.Method (Method(..))
import Debug (spy)
import Effect (Effect)
import Effect.Aff (launchAff_)
import Effect.Class (liftEffect)
import Effect.Class.Console (log)
import JS.Fetch as Fetch
import JS.Fetch.Duplex (Duplex(..))
import JS.Fetch.Headers as Headers
import JS.Fetch.Request as Request
import JS.Fetch.RequestBody as RequestBody
import JS.Fetch.Response as Response
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
  response <- Promise.toAffE $ unsafeCoerce $ Fetch.fetch request
  responseBody <- Promise.toAffE $ unsafeCoerce $ Response.text response
  log $ show $ Response.status response
  log responseBody
