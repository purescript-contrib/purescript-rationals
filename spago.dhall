{-
Welcome to a Spago project!
You can edit this file as you like.
-}
{ name = "rationals"
, dependencies = [ "js-bigints", "prelude" ]
, license = "MIT"
, repository = "git://github.com/purescript-contrib/purescript-rationals.git"
, packages = ./packages.dhall
, sources = [ "src/**/*.purs" ]
}
