# Change Log

All notable changes to this project will be documented in this file.

The format is based on Keep a Changelog.
and this project adheres to Semantic Versioning.

## [Unreleased]

### Changed

- Removed use of `dart:io` and extracted reporter and debugger functionality.

## [0.2.0]

### Added

- Added custom exceptions.
- Added `en` language tests.
- Added addition and subtraction grammar.
- Added shorthand 'd' for day and 'w' for week.
- Added support for returning `double` and `Duration` from `parse`.
- Added `tryParse` which is a nullable alternative to `parse`.
- Adds support for duration "from" datetime
  - Note that raw datetime parsing (such as 00:00) is still missing
- Added ability to map to comma from data.

### Changed

- Unrecognized tokens now return [TokenType.CT_ERROR].
- Terminate on error in compiler.
- Value no longer relies on subclasses.

### Fixes

- Fixed rechron_dev not matching with library declaration.
- Fixed dependency linking from rechron to rechron_dev.
- Removed aliases from grammar file.
- Removed unused 'and' token.

## 0.1.1-dev.1

### Changed

- Decreased dart sdk to stable version.

## 0.1.0

- Initial version.
