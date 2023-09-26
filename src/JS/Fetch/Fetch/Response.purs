module JS.Fetch.Response
  ( Response
  , arrayBuffer
  , blob
  , body
  , headers
  , json
  , ok
  , redirected
  , status
  , statusText
  , text
  , url
  ) where

import Data.ArrayBuffer.Types (ArrayBuffer, Uint8Array)
import Effect (Effect)
import Foreign (Foreign)
import JS.Fetch.Headers (Headers)
import Promise (Promise)
import Web.File.Blob (Blob)
import Web.Streams.ReadableStream (ReadableStream)

foreign import data Response :: Type

foreign import headers :: Response -> Headers

foreign import ok :: Response -> Boolean

foreign import redirected :: Response -> Boolean

foreign import status :: Response -> Int

foreign import statusText :: Response -> String

foreign import url :: Response -> String

foreign import body :: Response -> Effect (ReadableStream Uint8Array)

foreign import arrayBuffer :: Response -> Effect (Promise ArrayBuffer)

foreign import blob :: Response -> Effect (Promise Blob)

foreign import text :: Response -> Effect (Promise String)

foreign import json :: Response -> Effect (Promise Foreign)
