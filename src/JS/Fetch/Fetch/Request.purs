module JS.Fetch.Request
  ( Request
  , RequestOptions
  , UnsafeRequestOptions
  , _unsafeNew
  , class ToInternal
  , class ToInternalConverter
  , class ToInternalHelper
  , convert
  , convertHelper
  , convertImpl
  , new
  , unsafeNew
  ) where

import Prelude

import Data.HTTP.Method (Method)
import Data.Newtype (un)
import Data.Symbol (class IsSymbol)
import Effect (Effect)
import Effect.Uncurried (EffectFn2, runEffectFn2)
import JS.Fetch.Duplex (Duplex)
import JS.Fetch.Duplex as Duplex
import JS.Fetch.Headers (Headers)
import JS.Fetch.Integrity (Integrity(..))
import JS.Fetch.Referrer (Referrer)
import JS.Fetch.Referrer as Referrer
import JS.Fetch.ReferrerPolicy (ReferrerPolicy)
import JS.Fetch.ReferrerPolicy as ReferrerPolicy
import JS.Fetch.RequestBody (RequestBody)
import JS.Fetch.RequestCache (RequestCache)
import JS.Fetch.RequestCache as RequestCache
import JS.Fetch.RequestCredentials (RequestCredentials)
import JS.Fetch.RequestCredentials as RequestCredentials
import JS.Fetch.RequestMode (RequestMode)
import JS.Fetch.RequestMode as RequestMode
import Prim.Row (class Lacks, class Union)
import Prim.Row as R
import Prim.RowList as RL
import Record (delete, get, insert)
import Type.Proxy (Proxy(..))

foreign import data Request :: Type

foreign import _unsafeNew :: forall r. EffectFn2 String { | r } Request

type UnsafeRequestOptions =
  ( method :: String
  , headers :: Headers
  , body :: RequestBody
  , credentials :: String
  , cache :: String
  , mode :: String
  , referrer :: String
  , referrerPolicy :: String
  , integrity :: String
  , duplex :: String
  )

type RequestOptions =
  ( method :: Method
  , headers :: Headers
  , body :: RequestBody
  , credentials :: RequestCredentials
  , cache :: RequestCache
  , mode :: RequestMode
  , referrer :: Referrer
  , referrerPolicy :: ReferrerPolicy
  , integrity :: Integrity
  , duplex :: Duplex
  )

toUnsafeOptions
  :: forall input output thruIn thruOut
   . Union input thruIn RequestOptions
  => Union output thruOut UnsafeRequestOptions
  => ToInternal input output
  => { | input }
  -> { | output }
toUnsafeOptions = convert

unsafeNew :: String -> { | UnsafeRequestOptions } -> Effect Request
unsafeNew = runEffectFn2 _unsafeNew

new
  :: forall input output thruIn thruOut
   . Union input thruIn RequestOptions
  => Union output thruOut UnsafeRequestOptions
  => ToInternal input output
  => String
  -> { | input }
  -> Effect Request
new url options = runEffectFn2 _unsafeNew url (toUnsafeOptions options)

class ToInternal input output | input -> output where
  convert :: Record input -> Record output

instance (Union rIn thru RequestOptions, RL.RowToList rIn rInRL, ToInternalHelper rIn rInRL rOut) => ToInternal (| rIn) (| rOut) where
  convert = convertHelper (Proxy :: Proxy rInRL)

class ToInternalHelper :: forall k. Row Type -> k -> Row Type -> Constraint
class ToInternalHelper input inputRL output | inputRL -> output where
  convertHelper :: Proxy inputRL -> Record input -> Record output

instance ToInternalHelper r RL.Nil () where
  convertHelper _ _ = {}
else instance
  ( ToInternalConverter tpeIn tpeOut
  , R.Cons sym tpeIn tailIn r
  , RL.RowToList tailIn tailInRL
  , Lacks sym tailIn
  , IsSymbol sym
  , ToInternalHelper tailIn tailInRL tailOutput
  , R.Cons sym tpeOut tailOutput output
  , Lacks sym tailOutput
  ) =>
  ToInternalHelper r (RL.Cons sym tpeIn tailInRL) output where
  convertHelper _ r = insert (Proxy :: Proxy sym) head tail
    where
    tail :: Record tailOutput
    tail = delete (Proxy :: Proxy sym) r # convertHelper (Proxy :: Proxy tailInRL)

    head :: tpeOut
    head = get (Proxy :: Proxy sym) r # convertImpl

class ToInternalConverter input output | input -> output where
  convertImpl :: input -> output

instance ToInternalConverter Method String where
  convertImpl = show

instance ToInternalConverter Headers Headers where
  convertImpl = identity

instance ToInternalConverter RequestBody RequestBody where
  convertImpl = identity

instance ToInternalConverter RequestCredentials String where
  convertImpl = RequestCredentials.toString

instance ToInternalConverter RequestCache String where
  convertImpl = RequestCache.toString

instance ToInternalConverter RequestMode String where
  convertImpl = RequestMode.toString

instance ToInternalConverter Referrer String where
  convertImpl = Referrer.toString

instance ToInternalConverter ReferrerPolicy String where
  convertImpl = ReferrerPolicy.toString

instance ToInternalConverter Integrity String where
  convertImpl = un Integrity

instance ToInternalConverter Duplex String where
  convertImpl = Duplex.toString
