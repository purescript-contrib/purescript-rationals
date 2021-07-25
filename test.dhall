let conf = ./spago.dhall

in conf // {
  sources = conf.sources # [ "test/**/*.purs" ],
  dependencies = conf.dependencies # 
    [ "bigints"
    , "console"
    , "effect"
    , "quickcheck"
    , "test-unit"
    , "quickcheck-laws"  
    ]
}
 