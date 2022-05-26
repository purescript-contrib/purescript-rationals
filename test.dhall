let conf = ./spago.dhall

in conf // {
  sources = conf.sources # [ "test/**/*.purs" ],
  dependencies = conf.dependencies # [  "bigints", "console", "effect", "test-unit", "quickcheck", "quickcheck-laws"  ]
}
 