{-
Welcome to a Spago project!
You can edit this file as you like.
-}
{ name = "rationals"
, dependencies = [ "console", "effect", "integers", "psci-support" ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs" ]
}
