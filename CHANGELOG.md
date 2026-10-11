# Changelog

Notable changes to this project are documented in this file. The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/) and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

Breaking changes:

New features:

Bugfixes:

Other improvements:

## v6.0.2

Other improvements:

- Remove the unused direct `integers` dependency so the package passes Spago's publication checks. All remaining dependency bounds are unchanged.

## v6.0.1

This version was released on GitHub but was not published to the registry because Spago rejected the unused direct `integers` dependency.

Bugfixes:

- Remove redundant Data.Int and Data.Ratio imports that generate warnings (#44, #45).

Other improvements:

- Migrate to registry-backed Spago 1.0 and update repository tooling and CI actions (#47).

## v6.0.0

Breaking changes:

- `Rational` is now a newtype over `Ratio BigInt`.
- numerator and denominator now return `BigInt` instead of `Int`

New features:
- `%` is polymorphic. It accepts `Int -> Int -> Rational` or `BigInt -> BigInt -> Rational`.
