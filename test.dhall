let conf = ./spago.dhall

in conf // {
  sources = conf.sources # [ "test/**/*.purs" ],
  dependencies = conf.dependencies # [  "console", "effect", "integers", "quickcheck", "quickcheck-laws"  ]
}
 