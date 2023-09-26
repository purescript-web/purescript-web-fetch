{ name = "fetch-core"
, dependencies =
  [ "arraybuffer-types"
  , "arrays"
  , "effect"
  , "foldable-traversable"
  , "foreign"
  , "foreign-object"
  , "functions"
  , "http-methods"
  , "js-promise"
  , "maybe"
  , "newtype"
  , "prelude"
  , "record"
  , "tuples"
  , "typelevel-prelude"
  , "unfoldable"
  , "web-file"
  , "web-streams"
  ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs" ]
, license = "MIT"
, repository = "https://github.com/purescript-contrib/purescript-js-fetch.git"
}
