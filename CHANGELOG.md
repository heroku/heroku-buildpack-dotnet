# Changelog

## [Unreleased]

### Changed

- The .NET SDK inventory was updated with new download URLs for version 9.0 release artifacts. ([#41](https://github.com/heroku/heroku-buildpack-dotnet/pull/41))

### Added

- Support for .NET SDK versions: 8.0.113 (linux-amd64), 8.0.113 (linux-arm64), 8.0.309 (linux-amd64), 8.0.309 (linux-arm64), 8.0.406 (linux-amd64), 8.0.406 (linux-arm64), 9.0.103 (linux-amd64), 9.0.103 (linux-arm64), 9.0.200 (linux-amd64), 9.0.200 (linux-arm64). ([#41](https://github.com/heroku/heroku-buildpack-dotnet/pull/41))


## [v5] - 2025-02-10

### Changed

- Detected process types are now only registered as default processes when no Procfile is present. [#39](https://github.com/heroku/heroku-buildpack-dotnet/pull/39)
- The .NET SDK inventory was updated with new download URLs for version 9.0 release artifacts. [#39](https://github.com/heroku/heroku-buildpack-dotnet/pull/39)

## [v4] - 2025-01-16

### Added

- Support for .NET SDK versions: 8.0.112 (linux-amd64), 8.0.112 (linux-arm64), 8.0.308 (linux-amd64), 8.0.308 (linux-arm64), 8.0.405 (linux-amd64), 8.0.405 (linux-arm64), 9.0.102 (linux-amd64), 9.0.102 (linux-arm64). ([#34](https://github.com/heroku/heroku-buildpack-dotnet/pull/34))

## [v3] - 2024-12-04

### Added

- Support for .NET SDK versions: 9.0.101 (linux-amd64), 9.0.101 (linux-arm64). ([#25](https://github.com/heroku/heroku-buildpack-dotnet/pull/25))

## [v2] - 2024-11-30

### Changed

- The buildpack will now retry SDK downloads up to 5 times. ([#17](https://github.com/heroku/heroku-buildpack-dotnet/pull/17))

## [v1] - 2024-11-30

### Added

- Initial implementation.

[unreleased]: https://github.com/heroku/heroku-buildpack-dotnet/compare/v5...main
[v5]: https://github.com/heroku/heroku-buildpack-dotnet/compare/v4...v5
[v4]: https://github.com/heroku/heroku-buildpack-dotnet/compare/v3...v4
[v3]: https://github.com/heroku/heroku-buildpack-dotnet/compare/v2...v3
[v2]: https://github.com/heroku/heroku-buildpack-dotnet/compare/v1...v2
[v1]: https://github.com/heroku/heroku-buildpack-dotnet/releases/tag/v1
