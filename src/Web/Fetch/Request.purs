module Web.Fetch.Request
  ( Request
  , RequestOptions
  , UnsafeRequestOptions
  , new
  , new'
  , unsafeNew
  , class BuildRequestOptions
  , buildRequestOptions
  , defaultOptions
  , defaultUnsafeOptions
  , class ConvertOptions
  , convertOptions
  , class ConvertOption
  , convertOption
  ) where

import Prelude

import Data.ArrayBuffer.Types (ArrayBuffer, ArrayView)
import Data.HTTP.Method (Method(..))
import Data.Maybe (Maybe(..))
import Data.Newtype (un)
import Data.Nullable (Nullable, toNullable)
import Data.Symbol (class IsSymbol)
import Data.Tuple (Tuple)
import Effect (Effect)
import Effect.Uncurried (EffectFn2, runEffectFn2)
import Foreign.Object (Object)
import Prim.Row as Row
import Prim.RowList (RowList)
import Prim.RowList as RowList
import Record (merge)
import Record.Builder as Record
import Type.Proxy (Proxy(..))
import Type.Row.Homogeneous (class Homogeneous)
import Web.Fetch.Headers (Headers)
import Web.Fetch.Headers as Headers
import Web.Fetch.Integrity (Integrity(..))
import Web.Fetch.Referrer (Referrer)
import Web.Fetch.Referrer as Referrer
import Web.Fetch.ReferrerPolicy (ReferrerPolicy)
import Web.Fetch.ReferrerPolicy as ReferrerPolicy
import Web.Fetch.RequestBody (RequestBody)
import Web.Fetch.RequestBody as RequestBody
import Web.Fetch.RequestCache (RequestCache)
import Web.Fetch.RequestCache as RequestCache
import Web.Fetch.RequestCredentials (RequestCredentials)
import Web.Fetch.RequestCredentials as RequestCredentials
import Web.Fetch.RequestMode (RequestMode)
import Web.Fetch.RequestMode as RequestMode

foreign import data Request :: Type

foreign import _unsafeNew :: forall r. EffectFn2 String { | r } Request

type UnsafeRequestOptions =
  ( method :: String
  , headers :: Headers
  , body :: RequestBody
  , credentials :: String
  , cache :: String
  , mode :: String
  , referrer :: Nullable String
  , referrerPolicy :: String
  , integrity :: String
  )

type RequestOptions =
  ( method :: Method
  , headers :: Headers
  , body :: RequestBody
  , credentials :: RequestCredentials
  , cache :: RequestCache
  , mode :: RequestMode
  , referrer :: Maybe Referrer
  , referrerPolicy :: ReferrerPolicy
  , integrity :: Integrity
  )

defaultOptions :: { | RequestOptions }
defaultOptions =
  { method: GET
  , headers: Headers.empty
  , body: RequestBody.empty
  , credentials: RequestCredentials.SameOrigin
  , cache: RequestCache.Default
  , mode: RequestMode.Cors
  , referrer: Nothing
  , referrerPolicy: ReferrerPolicy.NoReferrer
  , integrity: Integrity ""
  }

defaultUnsafeOptions :: { | UnsafeRequestOptions }
defaultUnsafeOptions = toUnsafeOptions defaultOptions

toUnsafeOptions :: { | RequestOptions } -> { | UnsafeRequestOptions }
toUnsafeOptions opts =
  { method: show opts.method
  , headers: opts.headers
  , body: opts.body
  , credentials: RequestCredentials.toString opts.credentials
  , cache: RequestCache.toString opts.cache
  , mode: RequestMode.toString opts.mode
  , referrer: toNullable $ Referrer.toString <$> opts.referrer
  , referrerPolicy: ReferrerPolicy.toString opts.referrerPolicy
  , integrity: un Integrity opts.integrity
  }

unsafeNew :: String -> { | UnsafeRequestOptions } -> Effect Request
unsafeNew = runEffectFn2 _unsafeNew

new :: String -> { | RequestOptions } -> Effect Request
new url options = runEffectFn2 _unsafeNew url (toUnsafeOptions options)

new' :: forall r. BuildRequestOptions { | r } => String -> { | r } -> Effect Request
new' url options = runEffectFn2 _unsafeNew url (toUnsafeOptions (buildRequestOptions options))

class BuildRequestOptions a where
  buildRequestOptions :: a -> { | RequestOptions }

instance buildRequestOptionsRecord
  :: ( RowList.RowToList r rl
     , ConvertOptions rl r r'
     , Row.Union r' RequestOptions r''
     , Row.Nub r'' RequestOptions
     )
  => BuildRequestOptions { | r } where
  buildRequestOptions r = merge (Record.build (convertOptions (Proxy :: _ rl)) r) defaultOptions

class ConvertOptions (rl :: RowList Type) (input :: Row Type) (output :: Row Type) | rl input -> output where
  convertOptions :: forall rlproxy. rlproxy rl -> Record.Builder { | input } { | output }

instance convertOptionsCons ::
  ( ConvertOptions rest input' output
  , ConvertOption field from to
  , Row.Cons field from rx input
  , Row.Cons field to rx input'
  , IsSymbol field
  ) => ConvertOptions (RowList.Cons field from rest) input output where
  convertOptions _ =
    convertOptions (Proxy :: _ rest)
      <<< Record.modify (Proxy :: _ field) (convertOption (Proxy :: _ field))

instance convertOptionsNil :: ConvertOptions RowList.Nil r r where
  convertOptions _ = identity

class ConvertOption (field :: Symbol) from to | field -> to where
  convertOption :: forall sproxy. sproxy field -> from -> to

instance convertMethod :: ConvertOption "method" Method Method where
  convertOption _ = identity

instance convertBody :: ConvertOption "body" RequestBody RequestBody where
  convertOption _ = identity

instance convertBodyString :: ConvertOption "body" String RequestBody where
  convertOption _ = RequestBody.fromString

instance convertBodyBuffer :: ConvertOption "body" ArrayBuffer RequestBody where
  convertOption _ = RequestBody.fromArrayBuffer

instance convertBodyView :: ConvertOption "body" (ArrayView t) RequestBody where
  convertOption _ = RequestBody.fromArrayView

instance convertHeaders :: ConvertOption "headers" Headers Headers where
  convertOption _ = identity

instance convertHeadersRecord :: Homogeneous r String => ConvertOption "headers" { | r } Headers where
  convertOption _ = Headers.fromRecord

instance convertHeadersObject :: ConvertOption "headers" (Object String) Headers where
  convertOption _ = Headers.fromObject

instance convertHeadersArray :: ConvertOption "headers" (Array (Tuple String String)) Headers where
  convertOption _ = Headers.fromFoldable

instance convertCache :: ConvertOption "cache" RequestCache RequestCache where
  convertOption _ = identity

instance convertMode :: ConvertOption "mode" RequestMode RequestMode where
  convertOption _ = identity

instance convertReferrer :: ConvertOption "referrer" Referrer (Maybe Referrer) where
  convertOption _ = Just

instance convertReferrerPolicy :: ConvertOption "referrerPolicy" ReferrerPolicy ReferrerPolicy where
  convertOption _ = identity

instance convertIntegrity :: ConvertOption "integrity" Integrity Integrity where
  convertOption _ = identity
