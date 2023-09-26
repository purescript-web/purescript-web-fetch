# Changelog

Notable changes to this project are documented in this file. The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/) and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

Breaking changes:
- Migrated from `web-promise` to `js-promise`

- Fork from web-fetch
- Rename package
- Replaced web-promise dependency with js-promise

New features:

- Improve request options to only use the provided attributes instead of a full options record using default values

Bugfixes:

Other improvements:

## [v3.0.0](https://github.com/purescript-web/purescript-web-fetch/releases/tag/v3.0.0) - 2022-04-27

Breaking changes:

- Migrate FFI to ES modules (#8 by @JordanMartinez)

New features:

Bugfixes:

Other improvements:

## [v2.0.0](https://github.com/purescript-web/purescript-web-fetch/releases/tag/v2.0.0) - 2021-02-26

Breaking changes:

- Added support for PureScript 0.14 and dropped support for all previous versions (#2)

New features:

Bugfixes:

Other improvements:

- Migrated CI to GitHub Actions and updated installation instructions to use Spago (#1)
- Added a CHANGELOG.md file and pull request template (#3, #4)

## [v1.0.1](https://github.com/purescript-web/purescript-web-fetch/releases/tag/v1.0.1) - 2020-01-15

- Fixed illegal fetch invocation when not specifying options

## [v1.0.0](https://github.com/purescript-web/purescript-web-fetch/releases/tag/v1.0.0) - 2020-01-14

- Initial release
