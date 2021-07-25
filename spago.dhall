{-
Welcome to a Spago project!
You can edit this file as you like.
-}
{ name = "rationals"
, dependencies = [ "integers", "prelude" ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs" ]
}
