{ name = "fetch-core"
, dependencies =
  [ "arraybuffer-types"
  , "arrays"
  , "console"
  , "effect"
  , "foldable-traversable"
  , "foreign"
  , "foreign-object"
  , "functions"
  , "http-methods"
  , "maybe"
  , "newtype"
  , "nullable"
  , "prelude"
  , "record"
  , "tuples"
  , "typelevel-prelude"
  , "unfoldable"
  , "unsafe-coerce"
  , "web-file"
  , "web-promise"
  , "web-streams"
  ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs" ]
, license = "MIT"
, repository = "https://github.com/rowtype-yoga/purescript-yoga-fetch.git"
}
