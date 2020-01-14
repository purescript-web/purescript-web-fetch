module Web.Fetch.Response where

import Data.ArrayBuffer.Types (ArrayBuffer, Uint8Array)
import Effect (Effect)
import Web.Fetch.Headers (Headers)
import Web.File.Blob (Blob)
import Web.Promise (Promise)
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