# Changelog

Notable changes to this project are documented in this file. The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/) and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

Breaking changes:

New features:

Bugfixes:

Other improvements:

## v6.0.0

Breaking changes:

- `Rational` is now a newtype over `Ratio BigInt`.
- numerator and denominator now return `BigInt` instead of `Int`

New features:
- `%` is polymorphic. It accepts `Int -> Int -> Rational` or `BigInt -> BigInt -> Rational`.
