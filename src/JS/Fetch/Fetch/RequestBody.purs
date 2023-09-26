module JS.Fetch.RequestBody where

import Data.ArrayBuffer.Types (ArrayBuffer, ArrayView, Uint8Array)
import Web.Streams.ReadableStream (ReadableStream)

foreign import data RequestBody :: Type

foreign import fromArrayBuffer :: ArrayBuffer -> RequestBody

foreign import fromArrayView :: forall a. ArrayView a -> RequestBody

foreign import fromString :: String -> RequestBody

foreign import fromReadableStream :: ReadableStream Uint8Array -> RequestBody

foreign import empty :: RequestBody
