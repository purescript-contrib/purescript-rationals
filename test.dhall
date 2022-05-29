let conf = ./spago.dhall

in conf // {
  sources = conf.sources # [ "test/**/*.purs" ],
  dependencies = conf.dependencies # [  "console", "effect", "test-unit", "quickcheck", "quickcheck-laws"  ]
}
 