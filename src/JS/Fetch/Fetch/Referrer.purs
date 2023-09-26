module JS.Fetch.Referrer where

data Referrer
  = ReferrerNone
  | ReferrerClient
  | ReferrerUrl String

toString :: Referrer -> String
toString = case _ of
  ReferrerNone -> "none"
  ReferrerClient -> "client"
  ReferrerUrl url -> url

fromString :: String -> Referrer
fromString = case _ of
  "none" -> ReferrerNone
  "client" -> ReferrerClient
  url -> ReferrerUrl url
