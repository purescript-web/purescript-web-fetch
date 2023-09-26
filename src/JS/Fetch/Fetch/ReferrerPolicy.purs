module JS.Fetch.ReferrerPolicy where

import Data.Maybe (Maybe(..))

data ReferrerPolicy
  = Default
  | NoReferrer
  | NoReferrerWhenDowngrade
  | SameOrigin
  | StrictOrigin
  | OriginWhenCrossOrigin
  | StrictOriginWhenCrossOrigin
  | UnsafeUrl

toString :: ReferrerPolicy -> String
toString = case _ of
  Default -> ""
  NoReferrer -> "no-referrer"
  NoReferrerWhenDowngrade -> "no-referrer-when-downgrade"
  SameOrigin -> "same-origin"
  StrictOrigin -> "strict-origin"
  OriginWhenCrossOrigin -> "origin-when-cross-origin"
  StrictOriginWhenCrossOrigin -> "strict-origin-when-cross-origin"
  UnsafeUrl -> "unsafe-url"

fromString :: String -> Maybe ReferrerPolicy
fromString = case _ of
  "" -> Just Default
  "no-referrer" -> Just NoReferrer
  "no-referrer-when-downgrade" -> Just NoReferrerWhenDowngrade
  "same-origin" -> Just SameOrigin
  "strict-origin" -> Just StrictOrigin
  "origin-when-cross-origin" -> Just OriginWhenCrossOrigin
  "strict-origin-when-cross-origin" -> Just StrictOriginWhenCrossOrigin
  "unsafe-url" -> Just UnsafeUrl
  _ -> Nothing
